[CmdletBinding()]
param(
    [ValidatePattern('^[A-Za-z0-9][A-Za-z0-9_-]*$')]
    [string]$RunName = ('sim_auto_' + (Get-Date -Format 'yyyyMMdd_HHmmss_fff')),
    [switch]$OpenWave
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
$h03Root = Split-Path -Parent $PSScriptRoot
$h03Utf8 = New-Object System.Text.UTF8Encoding($false)

function Write-H03Text {
    param([string]$Path, [string]$Content)
    [System.IO.File]::WriteAllText($Path, $Content, $h03Utf8)
}

# These calls use fixed arguments and relative paths with no spaces.
# Process streams avoid Windows PowerShell's UTF-16 redirection and stderr rules.
function Invoke-H03Tool {
    param([string]$Program, [string[]]$ToolArgs, [string]$Log)
    $h03Process = New-Object System.Diagnostics.Process
    try {
        $h03Process.StartInfo.FileName = $Program
        $h03Process.StartInfo.Arguments = $ToolArgs -join ' '
        $h03Process.StartInfo.WorkingDirectory = $h03Root
        $h03Process.StartInfo.UseShellExecute = $false
        $h03Process.StartInfo.CreateNoWindow = $true
        $h03Process.StartInfo.RedirectStandardOutput = $true
        $h03Process.StartInfo.RedirectStandardError = $true
        [void]$h03Process.Start()
        $h03Stdout = $h03Process.StandardOutput.ReadToEndAsync()
        $h03Stderr = $h03Process.StandardError.ReadToEndAsync()
        $h03Process.WaitForExit()
        $h03Output = $h03Stdout.GetAwaiter().GetResult()
        $h03Errors = $h03Stderr.GetAwaiter().GetResult()
        Write-H03Text -Path $Log -Content ($h03Output + $h03Errors)
        return $h03Process.ExitCode
    } finally {
        $h03Process.Dispose()
    }
}

# Complete preflight before creating a run directory.
foreach ($h03File in @('rtl/h03_spi_master.sv', 'tb/h03_spi_master_tb.sv')) {
    if (-not (Test-Path -LiteralPath (Join-Path $h03Root $h03File) -PathType Leaf)) {
        throw "Missing source: $h03File"
    }
}
$h03Iverilog = (Get-Command iverilog -CommandType Application -ErrorAction Stop | Select-Object -First 1).Source
$h03Vvp = (Get-Command vvp -CommandType Application -ErrorAction Stop | Select-Object -First 1).Source
$h03Git = (Get-Command git -CommandType Application -ErrorAction Stop | Select-Object -First 1).Source
if ($OpenWave) {
    $h03Gtkwave = (Get-Command gtkwave -CommandType Application -ErrorAction Stop | Select-Object -First 1).Source
}
$h03RelativeRun = 'evidence/runs/' + $RunName
$h03Run = Join-Path $h03Root $h03RelativeRun
if (Test-Path -LiteralPath $h03Run) {
    throw "Run already exists: $h03Run. Choose another -RunName."
}
New-Item -ItemType Directory -Path $h03Run -ErrorAction Stop | Out-Null

try {
    $h03Rc = Invoke-H03Tool -Program $h03Git -ToolArgs @('rev-parse', 'HEAD') -Log (Join-Path $h03Run 'commit.txt')
    if ($h03Rc -ne 0) { throw 'Cannot record Git HEAD; run inside the project repository.' }
    $h03Rc = Invoke-H03Tool -Program $h03Git -ToolArgs @('status', '--porcelain=v1', '--untracked-files=normal') -Log (Join-Path $h03Run 'git_status.txt')
    if ($h03Rc -ne 0) { throw 'Cannot record working-tree status.' }

    $h03Versions = @()
    foreach ($h03Tool in @(
        @{Name='iverilog'; Path=$h03Iverilog; Flag='-V'},
        @{Name='vvp'; Path=$h03Vvp; Flag='-V'},
        @{Name='git'; Path=$h03Git; Flag='--version'}
    )) {
        $h03VersionLog = Join-Path $h03Run ($h03Tool.Name + '_version.txt')
        $h03Rc = Invoke-H03Tool -Program $h03Tool.Path -ToolArgs @($h03Tool.Flag) -Log $h03VersionLog
        $h03Versions += "=== $($h03Tool.Name) (version exit=$h03Rc) ==="
        $h03Versions += [System.IO.File]::ReadAllText($h03VersionLog)
    }
    Write-H03Text -Path (Join-Path $h03Run 'tool_versions.txt') -Content (($h03Versions -join "`n") + "`n")

    $h03Hashes = foreach ($h03File in @('rtl/h03_spi_master.sv', 'tb/h03_spi_master_tb.sv')) {
        $h03Hash = (Get-FileHash -LiteralPath (Join-Path $h03Root $h03File) -Algorithm SHA256).Hash.ToLowerInvariant()
        "$h03Hash  $h03File"
    }
    Write-H03Text -Path (Join-Path $h03Run 'sources.sha256') -Content (($h03Hashes -join "`n") + "`n")
    $h03RunnerHash = (Get-FileHash -LiteralPath $PSCommandPath -Algorithm SHA256).Hash.ToLowerInvariant()
    Write-H03Text -Path (Join-Path $h03Run 'runner.sha256') -Content "$h03RunnerHash  scripts/run_sim.ps1`n"
    $h03Info = @(
        "RUN_NAME=$RunName",
        ('STARTED_UTC=' + (Get-Date).ToUniversalTime().ToString('o')),
        ('POWERSHELL=' + $PSVersionTable.PSVersion.ToString()),
        'TESTBENCH=h03_spi_master_tb',
        'EXPECTED_CASES=5', 'HALF_CYCLES=4', 'MSB_FIRST=1', 'CLK_PERIOD_NS=10',
        'SOURCE_NOTE=commit.txt is HEAD; git_status.txt records local changes; sources.sha256 identifies actual source bytes.'
    )
    Write-H03Text -Path (Join-Path $h03Run 'run_info.txt') -Content (($h03Info -join "`n") + "`n")

    $h03CompileArgs = @('-g2012', '-Wall', '-s', 'h03_spi_master_tb', '-o',
        "$h03RelativeRun/simulation.vvp", 'rtl/h03_spi_master.sv', 'tb/h03_spi_master_tb.sv')
    $h03Rc = Invoke-H03Tool -Program $h03Iverilog -ToolArgs $h03CompileArgs -Log (Join-Path $h03Run 'compile.log')
    Write-H03Text -Path (Join-Path $h03Run 'compile_exit.txt') -Content "COMPILE_EXIT=$h03Rc`n"
    Get-Content -LiteralPath (Join-Path $h03Run 'compile.log') -Encoding UTF8
    if ($h03Rc -ne 0) { throw "Compile failed: $h03Rc. See compile.log." }

    $h03Rc = Invoke-H03Tool -Program $h03Vvp -ToolArgs @("$h03RelativeRun/simulation.vvp", "+VCD=$h03RelativeRun/sample_mode0.vcd") -Log (Join-Path $h03Run 'simulation.log')
    Write-H03Text -Path (Join-Path $h03Run 'simulation_exit.txt') -Content "SIMULATION_EXIT=$h03Rc`n"
    $h03Lines = @(Get-Content -LiteralPath (Join-Path $h03Run 'simulation.log') -Encoding UTF8)
    $h03Lines | ForEach-Object { Write-Host $_ }
    if ($h03Rc -ne 0) { throw "Simulation failed: $h03Rc. See simulation.log." }

    $h03Cases = @($h03Lines | Where-Object { $_ -cmatch '^CASE PASS ' }).Count
    $h03Summaries = @($h03Lines | Where-Object { $_ -cmatch '^SIMULATION PASS ' })
    if ($h03Cases -ne 5) { throw "Expected 5 CASE PASS lines; got $h03Cases." }
    if ($h03Summaries.Count -ne 1 -or $h03Summaries[0] -cne 'SIMULATION PASS cases=5 HC=4 ORDER=1') {
        throw 'Expected exactly one matching five-case summary.'
    }
    $h03Vcd = Join-Path $h03Run 'sample_mode0.vcd'
    if (-not (Test-Path -LiteralPath $h03Vcd -PathType Leaf)) { throw 'Missing VCD.' }
    if ((Get-Item -LiteralPath $h03Vcd).Length -eq 0) { throw 'Empty VCD.' }
    Write-H03Text -Path (Join-Path $h03Run 'validation.txt') -Content "RESULT=PASS`nCASE_PASS_COUNT=$h03Cases`nSUMMARY_PASS_COUNT=1`n"
    Write-Host "RUNNER PASS: $h03Run"
} catch {
    Write-H03Text -Path (Join-Path $h03Run 'validation.txt') -Content ("RESULT=FAIL`nDETAIL=" + $_.Exception.Message + "`n")
    Write-Host ("RUNNER FAIL: " + $_.Exception.Message)
    Write-Host "Evidence kept at: $h03Run"
    exit 1
}

if ($OpenWave) {
    # An explicitly requested interactive waveform viewer.
    Start-Process -FilePath $h03Gtkwave -ArgumentList ('"' + $h03Vcd + '"') -WorkingDirectory $h03Root | Out-Null
}
exit 0
