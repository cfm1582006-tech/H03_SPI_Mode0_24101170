module tt_um_h03_spi_mode0 (clk,
    ena,
    rst_n,
    ui_in,
    uio_in,
    uio_oe,
    uio_out,
    uo_out);
 input clk;
 input ena;
 input rst_n;
 input [7:0] ui_in;
 input [7:0] uio_in;
 output [7:0] uio_oe;
 output [7:0] uio_out;
 output [7:0] uo_out;

 wire _000_;
 wire _001_;
 wire _002_;
 wire _003_;
 wire _004_;
 wire _005_;
 wire _006_;
 wire _007_;
 wire _008_;
 wire _009_;
 wire _010_;
 wire _011_;
 wire _012_;
 wire _013_;
 wire _014_;
 wire _015_;
 wire _016_;
 wire _017_;
 wire _018_;
 wire _019_;
 wire _020_;
 wire _021_;
 wire _022_;
 wire _023_;
 wire _024_;
 wire _025_;
 wire _026_;
 wire _027_;
 wire _028_;
 wire _029_;
 wire _030_;
 wire _031_;
 wire _032_;
 wire _033_;
 wire _034_;
 wire _035_;
 wire _036_;
 wire _037_;
 wire _038_;
 wire _039_;
 wire _040_;
 wire _041_;
 wire _042_;
 wire _043_;
 wire _044_;
 wire _045_;
 wire _046_;
 wire _047_;
 wire _048_;
 wire _049_;
 wire _050_;
 wire _051_;
 wire _052_;
 wire _053_;
 wire _054_;
 wire _055_;
 wire _056_;
 wire _057_;
 wire _058_;
 wire _059_;
 wire _060_;
 wire _061_;
 wire _062_;
 wire _063_;
 wire _064_;
 wire _065_;
 wire _066_;
 wire _067_;
 wire _068_;
 wire _069_;
 wire _070_;
 wire _071_;
 wire _072_;
 wire _073_;
 wire _074_;
 wire _075_;
 wire _076_;
 wire _077_;
 wire _078_;
 wire _079_;
 wire _080_;
 wire _081_;
 wire _082_;
 wire _083_;
 wire _084_;
 wire _085_;
 wire _086_;
 wire _087_;
 wire _088_;
 wire _089_;
 wire _090_;
 wire busy;
 wire \core.cs_n ;
 wire \core.done ;
 wire \core.edge_count[0] ;
 wire \core.edge_count[1] ;
 wire \core.edge_count[2] ;
 wire \core.edge_count[3] ;
 wire \core.half_count[0] ;
 wire \core.half_count[1] ;
 wire \core.mosi ;
 wire \core.rx_shift[0] ;
 wire \core.rx_shift[1] ;
 wire \core.rx_shift[2] ;
 wire \core.rx_shift[3] ;
 wire \core.rx_shift[4] ;
 wire \core.rx_shift[5] ;
 wire \core.rx_shift[6] ;
 wire \core.rx_shift[7] ;
 wire \core.sclk ;
 wire \core.state[0] ;
 wire \core.state[1] ;
 wire \core.state[2] ;
 wire \core.tx_shift[0] ;
 wire \core.tx_shift[1] ;
 wire \core.tx_shift[2] ;
 wire \core.tx_shift[3] ;
 wire \core.tx_shift[4] ;
 wire \core.tx_shift[5] ;
 wire \core.tx_shift[6] ;
 wire net1;
 wire net2;
 wire net3;
 wire net4;
 wire net5;
 wire net6;
 wire net7;
 wire net8;
 wire net9;
 wire net10;
 wire net11;
 wire net12;
 wire net41;
 wire net42;
 wire net47;
 wire net48;
 wire net49;
 wire net50;
 wire clknet_0_clk;
 wire net43;
 wire net44;
 wire net45;
 wire net13;
 wire net14;
 wire net15;
 wire net16;
 wire net17;
 wire net46;
 wire net18;
 wire net19;
 wire net20;
 wire net21;
 wire net22;
 wire net23;
 wire net24;
 wire net25;
 wire net26;
 wire net27;
 wire net28;
 wire net29;
 wire net30;
 wire net31;
 wire net32;
 wire net33;
 wire net34;
 wire net35;
 wire net36;
 wire net37;
 wire net38;
 wire net39;
 wire net40;
 wire net;
 wire clknet_3_0__leaf_clk;
 wire clknet_3_1__leaf_clk;
 wire clknet_3_2__leaf_clk;
 wire clknet_3_3__leaf_clk;
 wire clknet_3_4__leaf_clk;
 wire clknet_3_5__leaf_clk;
 wire clknet_3_6__leaf_clk;
 wire clknet_3_7__leaf_clk;
 wire net51;
 wire net52;
 wire net53;
 wire net54;
 wire net55;
 wire net56;
 wire net57;
 wire net58;
 wire net59;
 wire net60;
 wire net61;
 wire net62;
 wire net63;
 wire net64;
 wire net65;
 wire net66;
 wire net67;
 wire net68;
 wire net69;
 wire net70;
 wire net71;
 wire net72;
 wire net73;
 wire net74;
 wire net75;
 wire net76;
 wire net77;
 wire net78;
 wire net79;
 wire net80;
 wire net81;
 wire net82;
 wire net83;
 wire net84;
 wire net85;
 wire net86;

 sky130_fd_sc_hd__fill_1 FILLER_0_103 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_12 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_15 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_18 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_21 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_24 ();
 sky130_fd_sc_hd__fill_1 FILLER_0_27 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_29 ();
 sky130_fd_sc_hd__decap_3 FILLER_0_65 ();
 sky130_fd_sc_hd__fill_2 FILLER_0_85 ();
 sky130_fd_sc_hd__decap_3 FILLER_10_115 ();
 sky130_fd_sc_hd__decap_3 FILLER_10_118 ();
 sky130_fd_sc_hd__decap_3 FILLER_10_121 ();
 sky130_fd_sc_hd__decap_3 FILLER_10_124 ();
 sky130_fd_sc_hd__fill_2 FILLER_10_127 ();
 sky130_fd_sc_hd__fill_1 FILLER_10_3 ();
 sky130_fd_sc_hd__decap_3 FILLER_10_37 ();
 sky130_fd_sc_hd__fill_2 FILLER_10_40 ();
 sky130_fd_sc_hd__decap_3 FILLER_10_51 ();
 sky130_fd_sc_hd__decap_3 FILLER_10_54 ();
 sky130_fd_sc_hd__decap_3 FILLER_10_57 ();
 sky130_fd_sc_hd__fill_2 FILLER_10_60 ();
 sky130_fd_sc_hd__decap_3 FILLER_10_70 ();
 sky130_fd_sc_hd__decap_3 FILLER_10_73 ();
 sky130_fd_sc_hd__decap_3 FILLER_10_76 ();
 sky130_fd_sc_hd__decap_3 FILLER_10_79 ();
 sky130_fd_sc_hd__fill_2 FILLER_10_82 ();
 sky130_fd_sc_hd__decap_3 FILLER_11_113 ();
 sky130_fd_sc_hd__fill_1 FILLER_11_116 ();
 sky130_fd_sc_hd__decap_3 FILLER_11_134 ();
 sky130_fd_sc_hd__fill_2 FILLER_11_3 ();
 sky130_fd_sc_hd__decap_3 FILLER_11_37 ();
 sky130_fd_sc_hd__decap_3 FILLER_11_40 ();
 sky130_fd_sc_hd__fill_1 FILLER_11_43 ();
 sky130_fd_sc_hd__decap_3 FILLER_11_52 ();
 sky130_fd_sc_hd__fill_1 FILLER_11_55 ();
 sky130_fd_sc_hd__fill_2 FILLER_11_83 ();
 sky130_fd_sc_hd__decap_3 FILLER_11_90 ();
 sky130_fd_sc_hd__decap_3 FILLER_11_93 ();
 sky130_fd_sc_hd__fill_1 FILLER_11_96 ();
 sky130_fd_sc_hd__fill_1 FILLER_12_101 ();
 sky130_fd_sc_hd__fill_2 FILLER_12_127 ();
 sky130_fd_sc_hd__fill_1 FILLER_12_27 ();
 sky130_fd_sc_hd__decap_3 FILLER_12_35 ();
 sky130_fd_sc_hd__decap_3 FILLER_12_38 ();
 sky130_fd_sc_hd__decap_3 FILLER_12_41 ();
 sky130_fd_sc_hd__decap_3 FILLER_12_44 ();
 sky130_fd_sc_hd__fill_1 FILLER_12_47 ();
 sky130_fd_sc_hd__decap_3 FILLER_12_56 ();
 sky130_fd_sc_hd__fill_1 FILLER_12_59 ();
 sky130_fd_sc_hd__decap_3 FILLER_12_74 ();
 sky130_fd_sc_hd__fill_1 FILLER_12_85 ();
 sky130_fd_sc_hd__decap_3 FILLER_12_95 ();
 sky130_fd_sc_hd__decap_3 FILLER_12_98 ();
 sky130_fd_sc_hd__decap_3 FILLER_13_101 ();
 sky130_fd_sc_hd__decap_3 FILLER_13_104 ();
 sky130_fd_sc_hd__decap_3 FILLER_13_107 ();
 sky130_fd_sc_hd__fill_2 FILLER_13_110 ();
 sky130_fd_sc_hd__decap_3 FILLER_13_3 ();
 sky130_fd_sc_hd__decap_3 FILLER_13_39 ();
 sky130_fd_sc_hd__fill_2 FILLER_13_47 ();
 sky130_fd_sc_hd__fill_1 FILLER_13_57 ();
 sky130_fd_sc_hd__fill_1 FILLER_13_6 ();
 sky130_fd_sc_hd__fill_2 FILLER_13_75 ();
 sky130_fd_sc_hd__decap_3 FILLER_14_102 ();
 sky130_fd_sc_hd__decap_3 FILLER_14_105 ();
 sky130_fd_sc_hd__decap_3 FILLER_14_108 ();
 sky130_fd_sc_hd__decap_3 FILLER_14_134 ();
 sky130_fd_sc_hd__fill_2 FILLER_14_26 ();
 sky130_fd_sc_hd__decap_3 FILLER_14_46 ();
 sky130_fd_sc_hd__fill_1 FILLER_14_66 ();
 sky130_fd_sc_hd__decap_3 FILLER_14_93 ();
 sky130_fd_sc_hd__decap_3 FILLER_14_96 ();
 sky130_fd_sc_hd__decap_3 FILLER_14_99 ();
 sky130_fd_sc_hd__decap_3 FILLER_15_103 ();
 sky130_fd_sc_hd__decap_3 FILLER_15_106 ();
 sky130_fd_sc_hd__decap_3 FILLER_15_109 ();
 sky130_fd_sc_hd__decap_3 FILLER_15_113 ();
 sky130_fd_sc_hd__decap_3 FILLER_15_116 ();
 sky130_fd_sc_hd__decap_3 FILLER_15_119 ();
 sky130_fd_sc_hd__decap_3 FILLER_15_128 ();
 sky130_fd_sc_hd__decap_3 FILLER_15_131 ();
 sky130_fd_sc_hd__decap_3 FILLER_15_134 ();
 sky130_fd_sc_hd__decap_3 FILLER_15_24 ();
 sky130_fd_sc_hd__decap_3 FILLER_15_27 ();
 sky130_fd_sc_hd__decap_3 FILLER_15_3 ();
 sky130_fd_sc_hd__decap_3 FILLER_15_30 ();
 sky130_fd_sc_hd__decap_3 FILLER_15_33 ();
 sky130_fd_sc_hd__decap_3 FILLER_15_36 ();
 sky130_fd_sc_hd__decap_3 FILLER_15_39 ();
 sky130_fd_sc_hd__fill_1 FILLER_15_42 ();
 sky130_fd_sc_hd__decap_3 FILLER_15_51 ();
 sky130_fd_sc_hd__fill_2 FILLER_15_54 ();
 sky130_fd_sc_hd__fill_2 FILLER_15_6 ();
 sky130_fd_sc_hd__decap_3 FILLER_16_100 ();
 sky130_fd_sc_hd__decap_3 FILLER_16_103 ();
 sky130_fd_sc_hd__decap_3 FILLER_16_106 ();
 sky130_fd_sc_hd__decap_3 FILLER_16_109 ();
 sky130_fd_sc_hd__decap_3 FILLER_16_112 ();
 sky130_fd_sc_hd__decap_3 FILLER_16_115 ();
 sky130_fd_sc_hd__decap_3 FILLER_16_118 ();
 sky130_fd_sc_hd__fill_1 FILLER_16_121 ();
 sky130_fd_sc_hd__decap_3 FILLER_16_127 ();
 sky130_fd_sc_hd__decap_3 FILLER_16_130 ();
 sky130_fd_sc_hd__decap_3 FILLER_16_133 ();
 sky130_fd_sc_hd__fill_1 FILLER_16_136 ();
 sky130_fd_sc_hd__decap_3 FILLER_16_24 ();
 sky130_fd_sc_hd__fill_1 FILLER_16_27 ();
 sky130_fd_sc_hd__decap_3 FILLER_16_29 ();
 sky130_fd_sc_hd__decap_3 FILLER_16_3 ();
 sky130_fd_sc_hd__decap_3 FILLER_16_32 ();
 sky130_fd_sc_hd__decap_3 FILLER_16_35 ();
 sky130_fd_sc_hd__decap_3 FILLER_16_38 ();
 sky130_fd_sc_hd__decap_3 FILLER_16_41 ();
 sky130_fd_sc_hd__decap_3 FILLER_16_44 ();
 sky130_fd_sc_hd__decap_3 FILLER_16_47 ();
 sky130_fd_sc_hd__fill_1 FILLER_16_56 ();
 sky130_fd_sc_hd__fill_2 FILLER_16_6 ();
 sky130_fd_sc_hd__fill_1 FILLER_16_68 ();
 sky130_fd_sc_hd__fill_1 FILLER_16_75 ();
 sky130_fd_sc_hd__decap_3 FILLER_16_81 ();
 sky130_fd_sc_hd__decap_3 FILLER_16_85 ();
 sky130_fd_sc_hd__decap_3 FILLER_16_88 ();
 sky130_fd_sc_hd__decap_3 FILLER_16_91 ();
 sky130_fd_sc_hd__decap_3 FILLER_16_94 ();
 sky130_fd_sc_hd__decap_3 FILLER_16_97 ();
 sky130_fd_sc_hd__decap_3 FILLER_17_102 ();
 sky130_fd_sc_hd__decap_3 FILLER_17_105 ();
 sky130_fd_sc_hd__decap_3 FILLER_17_108 ();
 sky130_fd_sc_hd__fill_1 FILLER_17_111 ();
 sky130_fd_sc_hd__fill_2 FILLER_17_113 ();
 sky130_fd_sc_hd__decap_3 FILLER_17_129 ();
 sky130_fd_sc_hd__decap_3 FILLER_17_132 ();
 sky130_fd_sc_hd__fill_2 FILLER_17_135 ();
 sky130_fd_sc_hd__decap_3 FILLER_17_24 ();
 sky130_fd_sc_hd__decap_3 FILLER_17_27 ();
 sky130_fd_sc_hd__decap_3 FILLER_17_3 ();
 sky130_fd_sc_hd__decap_3 FILLER_17_30 ();
 sky130_fd_sc_hd__decap_3 FILLER_17_33 ();
 sky130_fd_sc_hd__decap_3 FILLER_17_36 ();
 sky130_fd_sc_hd__decap_3 FILLER_17_39 ();
 sky130_fd_sc_hd__decap_3 FILLER_17_42 ();
 sky130_fd_sc_hd__decap_3 FILLER_17_45 ();
 sky130_fd_sc_hd__decap_3 FILLER_17_6 ();
 sky130_fd_sc_hd__decap_3 FILLER_17_70 ();
 sky130_fd_sc_hd__decap_3 FILLER_17_73 ();
 sky130_fd_sc_hd__decap_3 FILLER_17_76 ();
 sky130_fd_sc_hd__decap_3 FILLER_17_79 ();
 sky130_fd_sc_hd__decap_3 FILLER_17_82 ();
 sky130_fd_sc_hd__decap_3 FILLER_17_85 ();
 sky130_fd_sc_hd__decap_3 FILLER_17_88 ();
 sky130_fd_sc_hd__fill_1 FILLER_17_9 ();
 sky130_fd_sc_hd__decap_3 FILLER_17_91 ();
 sky130_fd_sc_hd__decap_3 FILLER_18_111 ();
 sky130_fd_sc_hd__fill_2 FILLER_18_114 ();
 sky130_fd_sc_hd__decap_3 FILLER_18_133 ();
 sky130_fd_sc_hd__fill_1 FILLER_18_136 ();
 sky130_fd_sc_hd__fill_1 FILLER_18_19 ();
 sky130_fd_sc_hd__decap_3 FILLER_18_29 ();
 sky130_fd_sc_hd__fill_1 FILLER_18_63 ();
 sky130_fd_sc_hd__fill_1 FILLER_18_72 ();
 sky130_fd_sc_hd__decap_3 FILLER_18_81 ();
 sky130_fd_sc_hd__fill_1 FILLER_18_85 ();
 sky130_fd_sc_hd__decap_3 FILLER_19_107 ();
 sky130_fd_sc_hd__fill_2 FILLER_19_110 ();
 sky130_fd_sc_hd__fill_2 FILLER_19_113 ();
 sky130_fd_sc_hd__decap_3 FILLER_19_121 ();
 sky130_fd_sc_hd__decap_3 FILLER_19_124 ();
 sky130_fd_sc_hd__decap_3 FILLER_19_127 ();
 sky130_fd_sc_hd__decap_3 FILLER_19_130 ();
 sky130_fd_sc_hd__decap_3 FILLER_19_133 ();
 sky130_fd_sc_hd__fill_1 FILLER_19_136 ();
 sky130_fd_sc_hd__fill_1 FILLER_19_36 ();
 sky130_fd_sc_hd__fill_2 FILLER_19_54 ();
 sky130_fd_sc_hd__decap_3 FILLER_19_57 ();
 sky130_fd_sc_hd__fill_1 FILLER_19_60 ();
 sky130_fd_sc_hd__fill_2 FILLER_19_78 ();
 sky130_fd_sc_hd__decap_3 FILLER_1_109 ();
 sky130_fd_sc_hd__fill_1 FILLER_1_113 ();
 sky130_fd_sc_hd__fill_2 FILLER_1_135 ();
 sky130_fd_sc_hd__decap_3 FILLER_1_45 ();
 sky130_fd_sc_hd__fill_1 FILLER_1_57 ();
 sky130_fd_sc_hd__fill_1 FILLER_1_66 ();
 sky130_fd_sc_hd__fill_1 FILLER_1_75 ();
 sky130_fd_sc_hd__decap_3 FILLER_20_110 ();
 sky130_fd_sc_hd__decap_3 FILLER_20_113 ();
 sky130_fd_sc_hd__decap_3 FILLER_20_116 ();
 sky130_fd_sc_hd__decap_3 FILLER_20_119 ();
 sky130_fd_sc_hd__decap_3 FILLER_20_122 ();
 sky130_fd_sc_hd__decap_3 FILLER_20_125 ();
 sky130_fd_sc_hd__decap_3 FILLER_20_128 ();
 sky130_fd_sc_hd__decap_3 FILLER_20_131 ();
 sky130_fd_sc_hd__fill_1 FILLER_20_27 ();
 sky130_fd_sc_hd__decap_3 FILLER_20_29 ();
 sky130_fd_sc_hd__fill_1 FILLER_20_3 ();
 sky130_fd_sc_hd__decap_3 FILLER_20_32 ();
 sky130_fd_sc_hd__fill_1 FILLER_20_35 ();
 sky130_fd_sc_hd__decap_3 FILLER_20_81 ();
 sky130_fd_sc_hd__decap_3 FILLER_21_108 ();
 sky130_fd_sc_hd__decap_3 FILLER_21_11 ();
 sky130_fd_sc_hd__fill_1 FILLER_21_111 ();
 sky130_fd_sc_hd__decap_3 FILLER_21_113 ();
 sky130_fd_sc_hd__decap_3 FILLER_21_116 ();
 sky130_fd_sc_hd__decap_3 FILLER_21_119 ();
 sky130_fd_sc_hd__decap_3 FILLER_21_122 ();
 sky130_fd_sc_hd__decap_3 FILLER_21_125 ();
 sky130_fd_sc_hd__decap_3 FILLER_21_128 ();
 sky130_fd_sc_hd__decap_3 FILLER_21_14 ();
 sky130_fd_sc_hd__decap_3 FILLER_21_25 ();
 sky130_fd_sc_hd__decap_3 FILLER_21_28 ();
 sky130_fd_sc_hd__decap_3 FILLER_21_31 ();
 sky130_fd_sc_hd__fill_2 FILLER_21_34 ();
 sky130_fd_sc_hd__decap_3 FILLER_21_44 ();
 sky130_fd_sc_hd__decap_3 FILLER_21_47 ();
 sky130_fd_sc_hd__decap_3 FILLER_21_50 ();
 sky130_fd_sc_hd__decap_3 FILLER_21_53 ();
 sky130_fd_sc_hd__decap_3 FILLER_21_57 ();
 sky130_fd_sc_hd__decap_3 FILLER_21_64 ();
 sky130_fd_sc_hd__decap_3 FILLER_21_67 ();
 sky130_fd_sc_hd__decap_3 FILLER_21_70 ();
 sky130_fd_sc_hd__decap_3 FILLER_21_77 ();
 sky130_fd_sc_hd__fill_1 FILLER_21_84 ();
 sky130_fd_sc_hd__decap_3 FILLER_22_102 ();
 sky130_fd_sc_hd__decap_3 FILLER_22_105 ();
 sky130_fd_sc_hd__decap_3 FILLER_22_108 ();
 sky130_fd_sc_hd__fill_1 FILLER_22_111 ();
 sky130_fd_sc_hd__decap_3 FILLER_22_113 ();
 sky130_fd_sc_hd__decap_3 FILLER_22_116 ();
 sky130_fd_sc_hd__decap_3 FILLER_22_119 ();
 sky130_fd_sc_hd__decap_3 FILLER_22_122 ();
 sky130_fd_sc_hd__decap_3 FILLER_22_125 ();
 sky130_fd_sc_hd__decap_3 FILLER_22_128 ();
 sky130_fd_sc_hd__decap_3 FILLER_22_131 ();
 sky130_fd_sc_hd__fill_2 FILLER_22_26 ();
 sky130_fd_sc_hd__decap_3 FILLER_22_37 ();
 sky130_fd_sc_hd__decap_3 FILLER_22_40 ();
 sky130_fd_sc_hd__decap_3 FILLER_22_43 ();
 sky130_fd_sc_hd__fill_2 FILLER_22_46 ();
 sky130_fd_sc_hd__decap_3 FILLER_22_57 ();
 sky130_fd_sc_hd__decap_3 FILLER_22_6 ();
 sky130_fd_sc_hd__decap_3 FILLER_22_60 ();
 sky130_fd_sc_hd__decap_3 FILLER_22_71 ();
 sky130_fd_sc_hd__fill_2 FILLER_22_74 ();
 sky130_fd_sc_hd__fill_1 FILLER_22_9 ();
 sky130_fd_sc_hd__decap_3 FILLER_22_99 ();
 sky130_fd_sc_hd__fill_1 FILLER_2_103 ();
 sky130_fd_sc_hd__fill_1 FILLER_2_11 ();
 sky130_fd_sc_hd__decap_3 FILLER_2_29 ();
 sky130_fd_sc_hd__fill_1 FILLER_2_83 ();
 sky130_fd_sc_hd__fill_1 FILLER_2_85 ();
 sky130_fd_sc_hd__decap_3 FILLER_3_100 ();
 sky130_fd_sc_hd__fill_1 FILLER_3_103 ();
 sky130_fd_sc_hd__fill_1 FILLER_3_119 ();
 sky130_fd_sc_hd__decap_3 FILLER_3_23 ();
 sky130_fd_sc_hd__fill_2 FILLER_3_26 ();
 sky130_fd_sc_hd__decap_3 FILLER_3_52 ();
 sky130_fd_sc_hd__fill_1 FILLER_3_55 ();
 sky130_fd_sc_hd__decap_3 FILLER_3_57 ();
 sky130_fd_sc_hd__fill_1 FILLER_3_60 ();
 sky130_fd_sc_hd__decap_3 FILLER_3_97 ();
 sky130_fd_sc_hd__decap_3 FILLER_4_73 ();
 sky130_fd_sc_hd__decap_3 FILLER_4_85 ();
 sky130_fd_sc_hd__fill_2 FILLER_4_88 ();
 sky130_fd_sc_hd__fill_1 FILLER_4_98 ();
 sky130_fd_sc_hd__fill_2 FILLER_5_100 ();
 sky130_fd_sc_hd__fill_2 FILLER_5_110 ();
 sky130_fd_sc_hd__fill_1 FILLER_5_133 ();
 sky130_fd_sc_hd__decap_3 FILLER_5_16 ();
 sky130_fd_sc_hd__decap_3 FILLER_5_3 ();
 sky130_fd_sc_hd__fill_1 FILLER_5_35 ();
 sky130_fd_sc_hd__fill_2 FILLER_5_6 ();
 sky130_fd_sc_hd__decap_3 FILLER_5_80 ();
 sky130_fd_sc_hd__decap_3 FILLER_5_83 ();
 sky130_fd_sc_hd__fill_2 FILLER_5_86 ();
 sky130_fd_sc_hd__decap_3 FILLER_5_94 ();
 sky130_fd_sc_hd__decap_3 FILLER_5_97 ();
 sky130_fd_sc_hd__fill_1 FILLER_6_101 ();
 sky130_fd_sc_hd__fill_1 FILLER_6_119 ();
 sky130_fd_sc_hd__fill_2 FILLER_6_16 ();
 sky130_fd_sc_hd__decap_3 FILLER_6_24 ();
 sky130_fd_sc_hd__fill_1 FILLER_6_27 ();
 sky130_fd_sc_hd__decap_3 FILLER_6_3 ();
 sky130_fd_sc_hd__decap_3 FILLER_6_36 ();
 sky130_fd_sc_hd__fill_2 FILLER_6_39 ();
 sky130_fd_sc_hd__fill_2 FILLER_6_6 ();
 sky130_fd_sc_hd__decap_3 FILLER_6_66 ();
 sky130_fd_sc_hd__decap_3 FILLER_6_77 ();
 sky130_fd_sc_hd__decap_3 FILLER_6_80 ();
 sky130_fd_sc_hd__fill_1 FILLER_6_83 ();
 sky130_fd_sc_hd__decap_3 FILLER_6_85 ();
 sky130_fd_sc_hd__fill_2 FILLER_6_88 ();
 sky130_fd_sc_hd__decap_3 FILLER_6_98 ();
 sky130_fd_sc_hd__fill_1 FILLER_7_111 ();
 sky130_fd_sc_hd__decap_3 FILLER_7_113 ();
 sky130_fd_sc_hd__fill_1 FILLER_7_116 ();
 sky130_fd_sc_hd__decap_3 FILLER_7_125 ();
 sky130_fd_sc_hd__fill_1 FILLER_7_136 ();
 sky130_fd_sc_hd__decap_3 FILLER_7_24 ();
 sky130_fd_sc_hd__fill_2 FILLER_7_27 ();
 sky130_fd_sc_hd__decap_3 FILLER_7_3 ();
 sky130_fd_sc_hd__decap_3 FILLER_7_35 ();
 sky130_fd_sc_hd__decap_3 FILLER_7_38 ();
 sky130_fd_sc_hd__decap_3 FILLER_7_41 ();
 sky130_fd_sc_hd__decap_3 FILLER_7_44 ();
 sky130_fd_sc_hd__decap_3 FILLER_7_47 ();
 sky130_fd_sc_hd__decap_3 FILLER_7_50 ();
 sky130_fd_sc_hd__decap_3 FILLER_7_53 ();
 sky130_fd_sc_hd__fill_2 FILLER_7_6 ();
 sky130_fd_sc_hd__decap_3 FILLER_7_65 ();
 sky130_fd_sc_hd__decap_3 FILLER_7_68 ();
 sky130_fd_sc_hd__fill_2 FILLER_7_71 ();
 sky130_fd_sc_hd__decap_3 FILLER_7_79 ();
 sky130_fd_sc_hd__decap_3 FILLER_7_82 ();
 sky130_fd_sc_hd__decap_3 FILLER_7_85 ();
 sky130_fd_sc_hd__decap_3 FILLER_8_100 ();
 sky130_fd_sc_hd__decap_3 FILLER_8_103 ();
 sky130_fd_sc_hd__fill_1 FILLER_8_106 ();
 sky130_fd_sc_hd__decap_3 FILLER_8_115 ();
 sky130_fd_sc_hd__fill_2 FILLER_8_118 ();
 sky130_fd_sc_hd__decap_3 FILLER_8_25 ();
 sky130_fd_sc_hd__decap_3 FILLER_8_29 ();
 sky130_fd_sc_hd__fill_2 FILLER_8_3 ();
 sky130_fd_sc_hd__decap_3 FILLER_8_32 ();
 sky130_fd_sc_hd__decap_3 FILLER_8_35 ();
 sky130_fd_sc_hd__decap_3 FILLER_8_38 ();
 sky130_fd_sc_hd__decap_3 FILLER_8_41 ();
 sky130_fd_sc_hd__decap_3 FILLER_8_44 ();
 sky130_fd_sc_hd__decap_3 FILLER_8_54 ();
 sky130_fd_sc_hd__decap_3 FILLER_8_57 ();
 sky130_fd_sc_hd__decap_3 FILLER_8_60 ();
 sky130_fd_sc_hd__decap_3 FILLER_8_63 ();
 sky130_fd_sc_hd__decap_3 FILLER_8_66 ();
 sky130_fd_sc_hd__decap_3 FILLER_8_69 ();
 sky130_fd_sc_hd__fill_1 FILLER_8_72 ();
 sky130_fd_sc_hd__decap_3 FILLER_8_80 ();
 sky130_fd_sc_hd__fill_1 FILLER_8_83 ();
 sky130_fd_sc_hd__decap_3 FILLER_8_85 ();
 sky130_fd_sc_hd__decap_3 FILLER_8_88 ();
 sky130_fd_sc_hd__decap_3 FILLER_8_91 ();
 sky130_fd_sc_hd__decap_3 FILLER_8_94 ();
 sky130_fd_sc_hd__decap_3 FILLER_8_97 ();
 sky130_fd_sc_hd__fill_2 FILLER_9_102 ();
 sky130_fd_sc_hd__fill_1 FILLER_9_111 ();
 sky130_fd_sc_hd__decap_3 FILLER_9_113 ();
 sky130_fd_sc_hd__decap_3 FILLER_9_116 ();
 sky130_fd_sc_hd__decap_3 FILLER_9_119 ();
 sky130_fd_sc_hd__fill_1 FILLER_9_122 ();
 sky130_fd_sc_hd__decap_3 FILLER_9_131 ();
 sky130_fd_sc_hd__decap_3 FILLER_9_134 ();
 sky130_fd_sc_hd__fill_1 FILLER_9_21 ();
 sky130_fd_sc_hd__fill_1 FILLER_9_3 ();
 sky130_fd_sc_hd__decap_3 FILLER_9_65 ();
 sky130_fd_sc_hd__decap_3 FILLER_9_68 ();
 sky130_fd_sc_hd__fill_1 FILLER_9_71 ();
 sky130_fd_sc_hd__decap_3 FILLER_9_90 ();
 sky130_fd_sc_hd__decap_3 FILLER_9_93 ();
 sky130_fd_sc_hd__decap_3 FILLER_9_96 ();
 sky130_fd_sc_hd__decap_3 FILLER_9_99 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_0_Left_23 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_0_Right_0 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_10_Left_33 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_10_Right_10 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_11_Left_34 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_11_Right_11 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_12_Left_35 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_12_Right_12 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_13_Left_36 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_13_Right_13 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_14_Left_37 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_14_Right_14 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_15_Left_38 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_15_Right_15 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_16_Left_39 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_16_Right_16 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_17_Left_40 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_17_Right_17 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_18_Left_41 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_18_Right_18 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_19_Left_42 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_19_Right_19 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_1_Left_24 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_1_Right_1 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_20_Left_43 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_20_Right_20 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_21_Left_44 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_21_Right_21 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_22_Left_45 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_22_Right_22 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_2_Left_25 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_2_Right_2 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_3_Left_26 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_3_Right_3 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_4_Left_27 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_4_Right_4 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_5_Left_28 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_5_Right_5 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_6_Left_29 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_6_Right_6 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_7_Left_30 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_7_Right_7 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_8_Left_31 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_8_Right_8 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_9_Left_32 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_9_Right_9 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_0_46 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_0_47 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_0_48 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_0_49 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_10_68 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_10_69 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_11_70 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_11_71 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_12_72 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_12_73 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_13_74 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_13_75 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_14_76 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_14_77 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_15_78 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_15_79 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_16_80 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_16_81 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_17_82 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_17_83 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_18_84 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_18_85 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_19_86 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_19_87 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_1_50 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_1_51 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_20_88 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_20_89 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_21_90 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_21_91 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_22_92 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_22_93 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_22_94 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_22_95 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_2_52 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_2_53 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_3_54 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_3_55 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_4_56 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_4_57 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_5_58 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_5_59 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_6_60 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_6_61 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_7_62 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_7_63 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_8_64 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_8_65 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_9_66 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_9_67 ();
 sky130_fd_sc_hd__inv_2 _091_ (.A(net85),
    .Y(_080_));
 sky130_fd_sc_hd__and2_2 _092_ (.A(net31),
    .B(net37),
    .X(_081_));
 sky130_fd_sc_hd__or2_2 _093_ (.A(\core.edge_count[1] ),
    .B(\core.edge_count[0] ),
    .X(_082_));
 sky130_fd_sc_hd__or4b_2 _094_ (.A(\core.edge_count[2] ),
    .B(\core.edge_count[1] ),
    .C(\core.edge_count[0] ),
    .D_N(\core.edge_count[3] ),
    .X(_083_));
 sky130_fd_sc_hd__nand2_2 _095_ (.A(\core.half_count[1] ),
    .B(\core.half_count[0] ),
    .Y(_084_));
 sky130_fd_sc_hd__nand3_2 _096_ (.A(\core.half_count[1] ),
    .B(\core.half_count[0] ),
    .C(\core.sclk ),
    .Y(_085_));
 sky130_fd_sc_hd__or2_2 _097_ (.A(_083_),
    .B(_085_),
    .X(_086_));
 sky130_fd_sc_hd__inv_2 _098_ (.A(_086_),
    .Y(_087_));
 sky130_fd_sc_hd__and2_2 _099_ (.A(_081_),
    .B(_087_),
    .X(_000_));
 sky130_fd_sc_hd__and4_2 _100_ (.A(net36),
    .B(net11),
    .C(net1),
    .D(net35),
    .X(_088_));
 sky130_fd_sc_hd__or2_2 _101_ (.A(_081_),
    .B(_088_),
    .X(_012_));
 sky130_fd_sc_hd__a21o_2 _102_ (.A1(_081_),
    .A2(_086_),
    .B1(_088_),
    .X(_002_));
 sky130_fd_sc_hd__a21boi_2 _103_ (.A1(net11),
    .A2(net1),
    .B1_N(net35),
    .Y(_089_));
 sky130_fd_sc_hd__and2b_2 _104_ (.A_N(\core.state[1] ),
    .B(net38),
    .X(_090_));
 sky130_fd_sc_hd__nand2b_2 _105_ (.A_N(_089_),
    .B(net30),
    .Y(_001_));
 sky130_fd_sc_hd__a21boi_2 _106_ (.A1(\core.sclk ),
    .A2(_083_),
    .B1_N(net33),
    .Y(_037_));
 sky130_fd_sc_hd__a21o_2 _107_ (.A1(net33),
    .A2(_084_),
    .B1(\core.state[1] ),
    .X(_038_));
 sky130_fd_sc_hd__a211o_2 _108_ (.A1(net33),
    .A2(_084_),
    .B1(_089_),
    .C1(\core.state[1] ),
    .X(_039_));
 sky130_fd_sc_hd__nor2_2 _109_ (.A(net28),
    .B(net27),
    .Y(_040_));
 sky130_fd_sc_hd__a22o_2 _110_ (.A1(\core.tx_shift[6] ),
    .A2(net31),
    .B1(net35),
    .B2(net10),
    .X(_041_));
 sky130_fd_sc_hd__or3_2 _111_ (.A(net28),
    .B(net27),
    .C(_041_),
    .X(_042_));
 sky130_fd_sc_hd__o211a_2 _112_ (.A1(net76),
    .A2(_040_),
    .B1(_042_),
    .C1(net37),
    .X(_013_));
 sky130_fd_sc_hd__a21o_2 _113_ (.A1(\core.half_count[1] ),
    .A2(\core.half_count[0] ),
    .B1(\core.sclk ),
    .X(_043_));
 sky130_fd_sc_hd__and3_2 _114_ (.A(_081_),
    .B(_085_),
    .C(_043_),
    .X(_014_));
 sky130_fd_sc_hd__a21bo_2 _115_ (.A1(net51),
    .A2(net34),
    .B1_N(_012_),
    .X(_015_));
 sky130_fd_sc_hd__and2_2 _116_ (.A(\core.state[1] ),
    .B(net38),
    .X(_016_));
 sky130_fd_sc_hd__a22o_2 _117_ (.A1(net65),
    .A2(net30),
    .B1(net29),
    .B2(\core.rx_shift[0] ),
    .X(_017_));
 sky130_fd_sc_hd__a22o_2 _118_ (.A1(net67),
    .A2(net30),
    .B1(net29),
    .B2(\core.rx_shift[1] ),
    .X(_018_));
 sky130_fd_sc_hd__a22o_2 _119_ (.A1(net58),
    .A2(net30),
    .B1(net29),
    .B2(\core.rx_shift[2] ),
    .X(_019_));
 sky130_fd_sc_hd__a22o_2 _120_ (.A1(net62),
    .A2(net30),
    .B1(net29),
    .B2(\core.rx_shift[3] ),
    .X(_020_));
 sky130_fd_sc_hd__a22o_2 _121_ (.A1(net60),
    .A2(net30),
    .B1(net29),
    .B2(\core.rx_shift[4] ),
    .X(_021_));
 sky130_fd_sc_hd__a22o_2 _122_ (.A1(net56),
    .A2(net30),
    .B1(net29),
    .B2(\core.rx_shift[5] ),
    .X(_022_));
 sky130_fd_sc_hd__a22o_2 _123_ (.A1(net64),
    .A2(net30),
    .B1(net29),
    .B2(net54),
    .X(_023_));
 sky130_fd_sc_hd__a22o_2 _124_ (.A1(net15),
    .A2(_090_),
    .B1(net29),
    .B2(net52),
    .X(_024_));
 sky130_fd_sc_hd__and2b_2 _125_ (.A_N(\core.state[1] ),
    .B(net34),
    .X(_044_));
 sky130_fd_sc_hd__nand2b_2 _126_ (.A_N(\core.state[1] ),
    .B(\core.half_count[0] ),
    .Y(_045_));
 sky130_fd_sc_hd__o211a_2 _127_ (.A1(\core.half_count[0] ),
    .A2(_044_),
    .B1(_045_),
    .C1(net38),
    .X(_025_));
 sky130_fd_sc_hd__nand2b_2 _128_ (.A_N(\core.half_count[1] ),
    .B(_045_),
    .Y(_046_));
 sky130_fd_sc_hd__and3_2 _129_ (.A(net38),
    .B(_038_),
    .C(_046_),
    .X(_026_));
 sky130_fd_sc_hd__nand3b_2 _130_ (.A_N(\core.sclk ),
    .B(\core.half_count[0] ),
    .C(\core.half_count[1] ),
    .Y(_047_));
 sky130_fd_sc_hd__a21o_2 _131_ (.A1(net34),
    .A2(_047_),
    .B1(\core.state[1] ),
    .X(_048_));
 sky130_fd_sc_hd__and4b_2 _132_ (.A_N(\core.sclk ),
    .B(_044_),
    .C(\core.half_count[1] ),
    .D(\core.half_count[0] ),
    .X(_049_));
 sky130_fd_sc_hd__mux2_1 _133_ (.A0(_049_),
    .A1(_048_),
    .S(\core.edge_count[0] ),
    .X(_050_));
 sky130_fd_sc_hd__and2_2 _134_ (.A(net39),
    .B(_050_),
    .X(_027_));
 sky130_fd_sc_hd__nand2_2 _135_ (.A(\core.edge_count[1] ),
    .B(\core.edge_count[0] ),
    .Y(_051_));
 sky130_fd_sc_hd__a32o_2 _136_ (.A1(_082_),
    .A2(_049_),
    .A3(_051_),
    .B1(_048_),
    .B2(\core.edge_count[1] ),
    .X(_052_));
 sky130_fd_sc_hd__and2_2 _137_ (.A(net39),
    .B(_052_),
    .X(_028_));
 sky130_fd_sc_hd__a31o_2 _138_ (.A1(\core.edge_count[1] ),
    .A2(\core.edge_count[0] ),
    .A3(_049_),
    .B1(\core.edge_count[2] ),
    .X(_053_));
 sky130_fd_sc_hd__nand3_2 _139_ (.A(\core.edge_count[2] ),
    .B(\core.edge_count[1] ),
    .C(\core.edge_count[0] ),
    .Y(_054_));
 sky130_fd_sc_hd__a21o_2 _140_ (.A1(_049_),
    .A2(_054_),
    .B1(_048_),
    .X(_055_));
 sky130_fd_sc_hd__and3_2 _141_ (.A(net39),
    .B(_053_),
    .C(_055_),
    .X(_029_));
 sky130_fd_sc_hd__a41o_2 _142_ (.A1(\core.edge_count[2] ),
    .A2(\core.edge_count[1] ),
    .A3(\core.edge_count[0] ),
    .A4(_049_),
    .B1(\core.edge_count[3] ),
    .X(_056_));
 sky130_fd_sc_hd__o211a_2 _143_ (.A1(_080_),
    .A2(_055_),
    .B1(_056_),
    .C1(net39),
    .X(_030_));
 sky130_fd_sc_hd__a211o_2 _144_ (.A1(net35),
    .A2(net3),
    .B1(net28),
    .C1(net27),
    .X(_057_));
 sky130_fd_sc_hd__o211a_2 _145_ (.A1(net83),
    .A2(_040_),
    .B1(_057_),
    .C1(net36),
    .X(_031_));
 sky130_fd_sc_hd__a22o_2 _146_ (.A1(\core.tx_shift[0] ),
    .A2(net31),
    .B1(net35),
    .B2(net4),
    .X(_058_));
 sky130_fd_sc_hd__or3_2 _147_ (.A(net28),
    .B(net27),
    .C(_058_),
    .X(_059_));
 sky130_fd_sc_hd__o211a_2 _148_ (.A1(net79),
    .A2(_040_),
    .B1(_059_),
    .C1(net36),
    .X(_032_));
 sky130_fd_sc_hd__a22o_2 _149_ (.A1(\core.tx_shift[1] ),
    .A2(net31),
    .B1(net35),
    .B2(net5),
    .X(_060_));
 sky130_fd_sc_hd__or3_2 _150_ (.A(net28),
    .B(net27),
    .C(_060_),
    .X(_061_));
 sky130_fd_sc_hd__o211a_2 _151_ (.A1(net81),
    .A2(_040_),
    .B1(_061_),
    .C1(net37),
    .X(_033_));
 sky130_fd_sc_hd__a22o_2 _152_ (.A1(\core.tx_shift[2] ),
    .A2(net32),
    .B1(net35),
    .B2(net6),
    .X(_062_));
 sky130_fd_sc_hd__or3_2 _153_ (.A(net28),
    .B(net27),
    .C(_062_),
    .X(_063_));
 sky130_fd_sc_hd__o211a_2 _154_ (.A1(net77),
    .A2(_040_),
    .B1(_063_),
    .C1(net37),
    .X(_034_));
 sky130_fd_sc_hd__a22o_2 _155_ (.A1(\core.tx_shift[3] ),
    .A2(net32),
    .B1(net35),
    .B2(net7),
    .X(_064_));
 sky130_fd_sc_hd__or3_2 _156_ (.A(net28),
    .B(net27),
    .C(_064_),
    .X(_065_));
 sky130_fd_sc_hd__o211a_2 _157_ (.A1(net80),
    .A2(_040_),
    .B1(_065_),
    .C1(net37),
    .X(_035_));
 sky130_fd_sc_hd__a22o_2 _158_ (.A1(\core.tx_shift[4] ),
    .A2(net32),
    .B1(\core.state[0] ),
    .B2(net8),
    .X(_066_));
 sky130_fd_sc_hd__or3_2 _159_ (.A(net28),
    .B(net27),
    .C(_066_),
    .X(_067_));
 sky130_fd_sc_hd__o211a_2 _160_ (.A1(net82),
    .A2(_040_),
    .B1(_067_),
    .C1(net37),
    .X(_036_));
 sky130_fd_sc_hd__a22o_2 _161_ (.A1(\core.tx_shift[5] ),
    .A2(net32),
    .B1(\core.state[0] ),
    .B2(net9),
    .X(_068_));
 sky130_fd_sc_hd__or3_2 _162_ (.A(_037_),
    .B(_039_),
    .C(_068_),
    .X(_069_));
 sky130_fd_sc_hd__o211a_2 _163_ (.A1(net78),
    .A2(_040_),
    .B1(_069_),
    .C1(net37),
    .X(_003_));
 sky130_fd_sc_hd__a211oi_2 _164_ (.A1(net33),
    .A2(_047_),
    .B1(_089_),
    .C1(\core.state[1] ),
    .Y(_070_));
 sky130_fd_sc_hd__and2b_2 _165_ (.A_N(net26),
    .B(net36),
    .X(_071_));
 sky130_fd_sc_hd__and3_2 _166_ (.A(net31),
    .B(net36),
    .C(net12),
    .X(_072_));
 sky130_fd_sc_hd__o22a_2 _167_ (.A1(net71),
    .A2(net26),
    .B1(_071_),
    .B2(_072_),
    .X(_004_));
 sky130_fd_sc_hd__and3_2 _168_ (.A(\core.rx_shift[0] ),
    .B(net31),
    .C(net36),
    .X(_073_));
 sky130_fd_sc_hd__o22a_2 _169_ (.A1(net75),
    .A2(net26),
    .B1(_071_),
    .B2(_073_),
    .X(_005_));
 sky130_fd_sc_hd__and3_2 _170_ (.A(\core.rx_shift[1] ),
    .B(net31),
    .C(net36),
    .X(_074_));
 sky130_fd_sc_hd__o22a_2 _171_ (.A1(net74),
    .A2(net26),
    .B1(_071_),
    .B2(_074_),
    .X(_006_));
 sky130_fd_sc_hd__and3_2 _172_ (.A(\core.rx_shift[2] ),
    .B(net31),
    .C(net36),
    .X(_075_));
 sky130_fd_sc_hd__o22a_2 _173_ (.A1(net70),
    .A2(net26),
    .B1(_071_),
    .B2(_075_),
    .X(_007_));
 sky130_fd_sc_hd__and3_2 _174_ (.A(\core.rx_shift[3] ),
    .B(net33),
    .C(net38),
    .X(_076_));
 sky130_fd_sc_hd__o22a_2 _175_ (.A1(net73),
    .A2(net26),
    .B1(_071_),
    .B2(_076_),
    .X(_008_));
 sky130_fd_sc_hd__and3_2 _176_ (.A(\core.rx_shift[4] ),
    .B(net33),
    .C(net38),
    .X(_077_));
 sky130_fd_sc_hd__o22a_2 _177_ (.A1(net69),
    .A2(net26),
    .B1(_071_),
    .B2(_077_),
    .X(_009_));
 sky130_fd_sc_hd__and3_2 _178_ (.A(\core.rx_shift[5] ),
    .B(net33),
    .C(net38),
    .X(_078_));
 sky130_fd_sc_hd__o22a_2 _179_ (.A1(net54),
    .A2(net26),
    .B1(_071_),
    .B2(_078_),
    .X(_010_));
 sky130_fd_sc_hd__and3_2 _180_ (.A(\core.rx_shift[6] ),
    .B(net33),
    .C(net38),
    .X(_079_));
 sky130_fd_sc_hd__o22a_2 _181_ (.A1(net52),
    .A2(_070_),
    .B1(_071_),
    .B2(net55),
    .X(_011_));
 sky130_fd_sc_hd__dfxtp_2 _182_ (.CLK(clknet_3_2__leaf_clk),
    .D(_013_),
    .Q(\core.mosi ));
 sky130_fd_sc_hd__dfxtp_2 _183_ (.CLK(clknet_3_6__leaf_clk),
    .D(_014_),
    .Q(\core.sclk ));
 sky130_fd_sc_hd__dfxtp_2 _184_ (.CLK(clknet_3_3__leaf_clk),
    .D(_015_),
    .Q(\core.cs_n ));
 sky130_fd_sc_hd__dfxtp_2 _185_ (.CLK(clknet_3_5__leaf_clk),
    .D(_016_),
    .Q(\core.done ));
 sky130_fd_sc_hd__dfxtp_2 _186_ (.CLK(clknet_3_1__leaf_clk),
    .D(net66),
    .Q(net21));
 sky130_fd_sc_hd__dfxtp_2 _187_ (.CLK(clknet_3_1__leaf_clk),
    .D(net68),
    .Q(net22));
 sky130_fd_sc_hd__dfxtp_2 _188_ (.CLK(clknet_3_1__leaf_clk),
    .D(net59),
    .Q(net23));
 sky130_fd_sc_hd__dfxtp_2 _189_ (.CLK(clknet_3_4__leaf_clk),
    .D(net63),
    .Q(net24));
 sky130_fd_sc_hd__dfxtp_2 _190_ (.CLK(clknet_3_4__leaf_clk),
    .D(net61),
    .Q(net25));
 sky130_fd_sc_hd__dfxtp_2 _191_ (.CLK(clknet_3_7__leaf_clk),
    .D(net57),
    .Q(net13));
 sky130_fd_sc_hd__dfxtp_2 _192_ (.CLK(clknet_3_5__leaf_clk),
    .D(_023_),
    .Q(net14));
 sky130_fd_sc_hd__dfxtp_2 _193_ (.CLK(clknet_3_5__leaf_clk),
    .D(net53),
    .Q(net15));
 sky130_fd_sc_hd__dfxtp_2 _194_ (.CLK(clknet_3_7__leaf_clk),
    .D(_025_),
    .Q(\core.half_count[0] ));
 sky130_fd_sc_hd__dfxtp_2 _195_ (.CLK(clknet_3_6__leaf_clk),
    .D(_026_),
    .Q(\core.half_count[1] ));
 sky130_fd_sc_hd__dfxtp_2 _196_ (.CLK(clknet_3_7__leaf_clk),
    .D(_027_),
    .Q(\core.edge_count[0] ));
 sky130_fd_sc_hd__dfxtp_2 _197_ (.CLK(clknet_3_7__leaf_clk),
    .D(_028_),
    .Q(\core.edge_count[1] ));
 sky130_fd_sc_hd__dfxtp_2 _198_ (.CLK(clknet_3_6__leaf_clk),
    .D(_029_),
    .Q(\core.edge_count[2] ));
 sky130_fd_sc_hd__dfxtp_2 _199_ (.CLK(clknet_3_6__leaf_clk),
    .D(net86),
    .Q(\core.edge_count[3] ));
 sky130_fd_sc_hd__dfxtp_2 _200_ (.CLK(clknet_3_0__leaf_clk),
    .D(net84),
    .Q(\core.tx_shift[0] ));
 sky130_fd_sc_hd__dfxtp_2 _201_ (.CLK(clknet_3_1__leaf_clk),
    .D(_032_),
    .Q(\core.tx_shift[1] ));
 sky130_fd_sc_hd__dfxtp_2 _202_ (.CLK(clknet_3_3__leaf_clk),
    .D(_033_),
    .Q(\core.tx_shift[2] ));
 sky130_fd_sc_hd__dfxtp_2 _203_ (.CLK(clknet_3_0__leaf_clk),
    .D(_034_),
    .Q(\core.tx_shift[3] ));
 sky130_fd_sc_hd__dfxtp_2 _204_ (.CLK(clknet_3_2__leaf_clk),
    .D(_035_),
    .Q(\core.tx_shift[4] ));
 sky130_fd_sc_hd__dfxtp_2 _205_ (.CLK(clknet_3_2__leaf_clk),
    .D(_036_),
    .Q(\core.tx_shift[5] ));
 sky130_fd_sc_hd__dfxtp_2 _206_ (.CLK(clknet_3_2__leaf_clk),
    .D(_003_),
    .Q(\core.tx_shift[6] ));
 sky130_fd_sc_hd__dfxtp_2 _207_ (.CLK(clknet_3_0__leaf_clk),
    .D(net72),
    .Q(\core.rx_shift[0] ));
 sky130_fd_sc_hd__dfxtp_2 _208_ (.CLK(clknet_3_0__leaf_clk),
    .D(_005_),
    .Q(\core.rx_shift[1] ));
 sky130_fd_sc_hd__dfxtp_2 _209_ (.CLK(clknet_3_0__leaf_clk),
    .D(_006_),
    .Q(\core.rx_shift[2] ));
 sky130_fd_sc_hd__dfxtp_2 _210_ (.CLK(clknet_3_4__leaf_clk),
    .D(_007_),
    .Q(\core.rx_shift[3] ));
 sky130_fd_sc_hd__dfxtp_2 _211_ (.CLK(clknet_3_4__leaf_clk),
    .D(_008_),
    .Q(\core.rx_shift[4] ));
 sky130_fd_sc_hd__dfxtp_2 _212_ (.CLK(clknet_3_6__leaf_clk),
    .D(_009_),
    .Q(\core.rx_shift[5] ));
 sky130_fd_sc_hd__dfxtp_2 _213_ (.CLK(clknet_3_5__leaf_clk),
    .D(_010_),
    .Q(\core.rx_shift[6] ));
 sky130_fd_sc_hd__dfxtp_2 _214_ (.CLK(clknet_3_4__leaf_clk),
    .D(_011_),
    .Q(\core.rx_shift[7] ));
 sky130_fd_sc_hd__dfxtp_2 _215_ (.CLK(clknet_3_1__leaf_clk),
    .D(_001_),
    .Q(\core.state[0] ));
 sky130_fd_sc_hd__dfxtp_2 _216_ (.CLK(clknet_3_3__leaf_clk),
    .D(_000_),
    .Q(\core.state[1] ));
 sky130_fd_sc_hd__dfxtp_2 _217_ (.CLK(clknet_3_3__leaf_clk),
    .D(_002_),
    .Q(\core.state[2] ));
 sky130_fd_sc_hd__dfxtp_2 _218_ (.CLK(clknet_3_2__leaf_clk),
    .D(_012_),
    .Q(busy));
 sky130_fd_sc_hd__buf_2 _230_ (.A(busy),
    .X(net16));
 sky130_fd_sc_hd__buf_2 _231_ (.A(\core.done ),
    .X(net17));
 sky130_fd_sc_hd__buf_2 _232_ (.A(\core.sclk ),
    .X(net18));
 sky130_fd_sc_hd__buf_2 _233_ (.A(\core.mosi ),
    .X(net19));
 sky130_fd_sc_hd__buf_2 _234_ (.A(\core.cs_n ),
    .X(net20));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_0_clk (.A(clk),
    .X(clknet_0_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_3_0__f_clk (.A(clknet_0_clk),
    .X(clknet_3_0__leaf_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_3_1__f_clk (.A(clknet_0_clk),
    .X(clknet_3_1__leaf_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_3_2__f_clk (.A(clknet_0_clk),
    .X(clknet_3_2__leaf_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_3_3__f_clk (.A(clknet_0_clk),
    .X(clknet_3_3__leaf_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_3_4__f_clk (.A(clknet_0_clk),
    .X(clknet_3_4__leaf_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_3_5__f_clk (.A(clknet_0_clk),
    .X(clknet_3_5__leaf_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_3_6__f_clk (.A(clknet_0_clk),
    .X(clknet_3_6__leaf_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_3_7__f_clk (.A(clknet_0_clk),
    .X(clknet_3_7__leaf_clk));
 sky130_fd_sc_hd__clkbuf_4 clkload0 (.A(clknet_3_3__leaf_clk));
 sky130_fd_sc_hd__clkbuf_4 clkload1 (.A(clknet_3_5__leaf_clk));
 sky130_fd_sc_hd__clkbuf_4 clkload2 (.A(clknet_3_7__leaf_clk));
 sky130_fd_sc_hd__clkdlybuf4s25_1 fanout26 (.A(_070_),
    .X(net26));
 sky130_fd_sc_hd__clkdlybuf4s25_1 fanout27 (.A(_039_),
    .X(net27));
 sky130_fd_sc_hd__clkdlybuf4s25_1 fanout28 (.A(_037_),
    .X(net28));
 sky130_fd_sc_hd__clkdlybuf4s25_1 fanout29 (.A(_016_),
    .X(net29));
 sky130_fd_sc_hd__clkdlybuf4s25_1 fanout30 (.A(_090_),
    .X(net30));
 sky130_fd_sc_hd__clkdlybuf4s25_1 fanout31 (.A(net34),
    .X(net31));
 sky130_fd_sc_hd__clkdlybuf4s25_1 fanout32 (.A(net34),
    .X(net32));
 sky130_fd_sc_hd__clkdlybuf4s25_1 fanout33 (.A(net34),
    .X(net33));
 sky130_fd_sc_hd__clkdlybuf4s25_1 fanout34 (.A(\core.state[2] ),
    .X(net34));
 sky130_fd_sc_hd__clkdlybuf4s25_1 fanout35 (.A(\core.state[0] ),
    .X(net35));
 sky130_fd_sc_hd__clkdlybuf4s25_1 fanout36 (.A(net40),
    .X(net36));
 sky130_fd_sc_hd__clkdlybuf4s25_1 fanout37 (.A(net40),
    .X(net37));
 sky130_fd_sc_hd__clkdlybuf4s25_1 fanout38 (.A(net40),
    .X(net38));
 sky130_fd_sc_hd__clkdlybuf4s25_1 fanout39 (.A(net40),
    .X(net39));
 sky130_fd_sc_hd__clkdlybuf4s25_1 fanout40 (.A(net2),
    .X(net40));
 sky130_fd_sc_hd__dlygate4sd3_1 hold51 (.A(\core.cs_n ),
    .X(net51));
 sky130_fd_sc_hd__dlygate4sd3_1 hold52 (.A(\core.rx_shift[7] ),
    .X(net52));
 sky130_fd_sc_hd__dlygate4sd3_1 hold53 (.A(_024_),
    .X(net53));
 sky130_fd_sc_hd__dlygate4sd3_1 hold54 (.A(\core.rx_shift[6] ),
    .X(net54));
 sky130_fd_sc_hd__dlygate4sd3_1 hold55 (.A(_079_),
    .X(net55));
 sky130_fd_sc_hd__dlygate4sd3_1 hold56 (.A(net13),
    .X(net56));
 sky130_fd_sc_hd__dlygate4sd3_1 hold57 (.A(_022_),
    .X(net57));
 sky130_fd_sc_hd__dlygate4sd3_1 hold58 (.A(net23),
    .X(net58));
 sky130_fd_sc_hd__dlygate4sd3_1 hold59 (.A(_019_),
    .X(net59));
 sky130_fd_sc_hd__dlygate4sd3_1 hold60 (.A(net25),
    .X(net60));
 sky130_fd_sc_hd__dlygate4sd3_1 hold61 (.A(_021_),
    .X(net61));
 sky130_fd_sc_hd__dlygate4sd3_1 hold62 (.A(net24),
    .X(net62));
 sky130_fd_sc_hd__dlygate4sd3_1 hold63 (.A(_020_),
    .X(net63));
 sky130_fd_sc_hd__dlygate4sd3_1 hold64 (.A(net14),
    .X(net64));
 sky130_fd_sc_hd__dlygate4sd3_1 hold65 (.A(net21),
    .X(net65));
 sky130_fd_sc_hd__dlygate4sd3_1 hold66 (.A(_017_),
    .X(net66));
 sky130_fd_sc_hd__dlygate4sd3_1 hold67 (.A(net22),
    .X(net67));
 sky130_fd_sc_hd__dlygate4sd3_1 hold68 (.A(_018_),
    .X(net68));
 sky130_fd_sc_hd__dlygate4sd3_1 hold69 (.A(\core.rx_shift[5] ),
    .X(net69));
 sky130_fd_sc_hd__dlygate4sd3_1 hold70 (.A(\core.rx_shift[3] ),
    .X(net70));
 sky130_fd_sc_hd__dlygate4sd3_1 hold71 (.A(\core.rx_shift[0] ),
    .X(net71));
 sky130_fd_sc_hd__dlygate4sd3_1 hold72 (.A(_004_),
    .X(net72));
 sky130_fd_sc_hd__dlygate4sd3_1 hold73 (.A(\core.rx_shift[4] ),
    .X(net73));
 sky130_fd_sc_hd__dlygate4sd3_1 hold74 (.A(\core.rx_shift[2] ),
    .X(net74));
 sky130_fd_sc_hd__dlygate4sd3_1 hold75 (.A(\core.rx_shift[1] ),
    .X(net75));
 sky130_fd_sc_hd__dlygate4sd3_1 hold76 (.A(\core.mosi ),
    .X(net76));
 sky130_fd_sc_hd__dlygate4sd3_1 hold77 (.A(\core.tx_shift[3] ),
    .X(net77));
 sky130_fd_sc_hd__dlygate4sd3_1 hold78 (.A(\core.tx_shift[6] ),
    .X(net78));
 sky130_fd_sc_hd__dlygate4sd3_1 hold79 (.A(\core.tx_shift[1] ),
    .X(net79));
 sky130_fd_sc_hd__dlygate4sd3_1 hold80 (.A(\core.tx_shift[4] ),
    .X(net80));
 sky130_fd_sc_hd__dlygate4sd3_1 hold81 (.A(\core.tx_shift[2] ),
    .X(net81));
 sky130_fd_sc_hd__dlygate4sd3_1 hold82 (.A(\core.tx_shift[5] ),
    .X(net82));
 sky130_fd_sc_hd__dlygate4sd3_1 hold83 (.A(\core.tx_shift[0] ),
    .X(net83));
 sky130_fd_sc_hd__dlygate4sd3_1 hold84 (.A(_031_),
    .X(net84));
 sky130_fd_sc_hd__dlygate4sd3_1 hold85 (.A(\core.edge_count[3] ),
    .X(net85));
 sky130_fd_sc_hd__dlygate4sd3_1 hold86 (.A(_030_),
    .X(net86));
 sky130_fd_sc_hd__clkdlybuf4s25_1 input1 (.A(ena),
    .X(net1));
 sky130_fd_sc_hd__clkdlybuf4s25_1 input10 (.A(ui_in[7]),
    .X(net10));
 sky130_fd_sc_hd__clkdlybuf4s25_1 input11 (.A(uio_in[0]),
    .X(net11));
 sky130_fd_sc_hd__clkdlybuf4s25_1 input12 (.A(uio_in[1]),
    .X(net12));
 sky130_fd_sc_hd__clkdlybuf4s25_1 input2 (.A(rst_n),
    .X(net2));
 sky130_fd_sc_hd__clkdlybuf4s25_1 input3 (.A(ui_in[0]),
    .X(net3));
 sky130_fd_sc_hd__clkdlybuf4s25_1 input4 (.A(ui_in[1]),
    .X(net4));
 sky130_fd_sc_hd__clkdlybuf4s25_1 input5 (.A(ui_in[2]),
    .X(net5));
 sky130_fd_sc_hd__clkdlybuf4s25_1 input6 (.A(ui_in[3]),
    .X(net6));
 sky130_fd_sc_hd__clkdlybuf4s25_1 input7 (.A(ui_in[4]),
    .X(net7));
 sky130_fd_sc_hd__clkdlybuf4s25_1 input8 (.A(ui_in[5]),
    .X(net8));
 sky130_fd_sc_hd__clkdlybuf4s25_1 input9 (.A(ui_in[6]),
    .X(net9));
 sky130_fd_sc_hd__clkdlybuf4s25_1 output13 (.A(net13),
    .X(uio_out[2]));
 sky130_fd_sc_hd__clkdlybuf4s25_1 output14 (.A(net14),
    .X(uio_out[3]));
 sky130_fd_sc_hd__clkdlybuf4s25_1 output15 (.A(net15),
    .X(uio_out[4]));
 sky130_fd_sc_hd__clkdlybuf4s25_1 output16 (.A(net16),
    .X(uio_out[5]));
 sky130_fd_sc_hd__clkdlybuf4s25_1 output17 (.A(net17),
    .X(uio_out[6]));
 sky130_fd_sc_hd__clkdlybuf4s25_1 output18 (.A(net18),
    .X(uo_out[0]));
 sky130_fd_sc_hd__clkdlybuf4s25_1 output19 (.A(net19),
    .X(uo_out[1]));
 sky130_fd_sc_hd__clkdlybuf4s25_1 output20 (.A(net20),
    .X(uo_out[2]));
 sky130_fd_sc_hd__clkdlybuf4s25_1 output21 (.A(net21),
    .X(uo_out[3]));
 sky130_fd_sc_hd__clkdlybuf4s25_1 output22 (.A(net22),
    .X(uo_out[4]));
 sky130_fd_sc_hd__clkdlybuf4s25_1 output23 (.A(net23),
    .X(uo_out[5]));
 sky130_fd_sc_hd__clkdlybuf4s25_1 output24 (.A(net24),
    .X(uo_out[6]));
 sky130_fd_sc_hd__clkdlybuf4s25_1 output25 (.A(net25),
    .X(uo_out[7]));
 sky130_fd_sc_hd__conb_1 tt_um_h03_spi_mode0 (.LO(net));
 sky130_fd_sc_hd__conb_1 tt_um_h03_spi_mode0_41 (.LO(net41));
 sky130_fd_sc_hd__conb_1 tt_um_h03_spi_mode0_42 (.LO(net42));
 sky130_fd_sc_hd__conb_1 tt_um_h03_spi_mode0_43 (.LO(net43));
 sky130_fd_sc_hd__conb_1 tt_um_h03_spi_mode0_44 (.LO(net44));
 sky130_fd_sc_hd__conb_1 tt_um_h03_spi_mode0_45 (.LO(net45));
 sky130_fd_sc_hd__conb_1 tt_um_h03_spi_mode0_46 (.HI(net46));
 sky130_fd_sc_hd__conb_1 tt_um_h03_spi_mode0_47 (.HI(net47));
 sky130_fd_sc_hd__conb_1 tt_um_h03_spi_mode0_48 (.HI(net48));
 sky130_fd_sc_hd__conb_1 tt_um_h03_spi_mode0_49 (.HI(net49));
 sky130_fd_sc_hd__conb_1 tt_um_h03_spi_mode0_50 (.HI(net50));
 assign uio_oe[0] = net;
 assign uio_oe[1] = net41;
 assign uio_oe[2] = net46;
 assign uio_oe[3] = net47;
 assign uio_oe[4] = net48;
 assign uio_oe[5] = net49;
 assign uio_oe[6] = net50;
 assign uio_oe[7] = net42;
 assign uio_out[0] = net43;
 assign uio_out[1] = net44;
 assign uio_out[7] = net45;
endmodule
