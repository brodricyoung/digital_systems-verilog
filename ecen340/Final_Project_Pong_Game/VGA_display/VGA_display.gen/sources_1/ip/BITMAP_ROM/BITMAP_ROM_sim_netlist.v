// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2024.2 (win64) Build 5239630 Fri Nov 08 22:35:27 MST 2024
// Date        : Thu Mar 20 13:40:32 2025
// Host        : Brodrics_laptop running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim {c:/Users/young/OneDrive/Documents/- Hardware
//               Labs/digital_systems-verilog/ecen340/Final_Project_Pong_Game/VGA_display/VGA_display.gen/sources_1/ip/BITMAP_ROM/BITMAP_ROM_sim_netlist.v}
// Design      : BITMAP_ROM
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "BITMAP_ROM,blk_mem_gen_v8_4_9,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_9,Vivado 2024.2" *) 
(* NotValidForBitStream *)
module BITMAP_ROM
   (clka,
    addra,
    douta);
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA CLK" *) (* x_interface_mode = "slave BRAM_PORTA" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTA, MEM_ADDRESS_MODE BYTE_ADDRESS, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clka;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [6:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DOUT" *) output [127:0]douta;

  wire [6:0]addra;
  wire clka;
  wire [127:0]douta;
  wire NLW_U0_dbiterr_UNCONNECTED;
  wire NLW_U0_rsta_busy_UNCONNECTED;
  wire NLW_U0_rstb_busy_UNCONNECTED;
  wire NLW_U0_s_axi_arready_UNCONNECTED;
  wire NLW_U0_s_axi_awready_UNCONNECTED;
  wire NLW_U0_s_axi_bvalid_UNCONNECTED;
  wire NLW_U0_s_axi_dbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_rlast_UNCONNECTED;
  wire NLW_U0_s_axi_rvalid_UNCONNECTED;
  wire NLW_U0_s_axi_sbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_wready_UNCONNECTED;
  wire NLW_U0_sbiterr_UNCONNECTED;
  wire [127:0]NLW_U0_doutb_UNCONNECTED;
  wire [6:0]NLW_U0_rdaddrecc_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [6:0]NLW_U0_s_axi_rdaddrecc_UNCONNECTED;
  wire [127:0]NLW_U0_s_axi_rdata_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;

  (* C_ADDRA_WIDTH = "7" *) 
  (* C_ADDRB_WIDTH = "7" *) 
  (* C_ALGORITHM = "1" *) 
  (* C_AXI_ID_WIDTH = "4" *) 
  (* C_AXI_SLAVE_TYPE = "0" *) 
  (* C_AXI_TYPE = "1" *) 
  (* C_BYTE_SIZE = "9" *) 
  (* C_COMMON_CLK = "0" *) 
  (* C_COUNT_18K_BRAM = "0" *) 
  (* C_COUNT_36K_BRAM = "2" *) 
  (* C_CTRL_ECC_ALGO = "NONE" *) 
  (* C_DEFAULT_DATA = "0" *) 
  (* C_DISABLE_WARN_BHV_COLL = "0" *) 
  (* C_DISABLE_WARN_BHV_RANGE = "0" *) 
  (* C_ELABORATION_DIR = "./" *) 
  (* C_ENABLE_32BIT_ADDRESS = "0" *) 
  (* C_EN_DEEPSLEEP_PIN = "0" *) 
  (* C_EN_ECC_PIPE = "0" *) 
  (* C_EN_RDADDRA_CHG = "0" *) 
  (* C_EN_RDADDRB_CHG = "0" *) 
  (* C_EN_SAFETY_CKT = "0" *) 
  (* C_EN_SHUTDOWN_PIN = "0" *) 
  (* C_EN_SLEEP_PIN = "0" *) 
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     12.7408 mW" *) 
  (* C_FAMILY = "artix7" *) 
  (* C_HAS_AXI_ID = "0" *) 
  (* C_HAS_ENA = "0" *) 
  (* C_HAS_ENB = "0" *) 
  (* C_HAS_INJECTERR = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_A = "1" *) 
  (* C_HAS_MEM_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_REGCEA = "0" *) 
  (* C_HAS_REGCEB = "0" *) 
  (* C_HAS_RSTA = "0" *) 
  (* C_HAS_RSTB = "0" *) 
  (* C_HAS_SOFTECC_INPUT_REGS_A = "0" *) 
  (* C_HAS_SOFTECC_OUTPUT_REGS_B = "0" *) 
  (* C_INITA_VAL = "0" *) 
  (* C_INITB_VAL = "0" *) 
  (* C_INIT_FILE = "BITMAP_ROM.mem" *) 
  (* C_INIT_FILE_NAME = "BITMAP_ROM.mif" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_LOAD_INIT_FILE = "1" *) 
  (* C_MEM_TYPE = "3" *) 
  (* C_MUX_PIPELINE_STAGES = "0" *) 
  (* C_PRIM_TYPE = "1" *) 
  (* C_READ_DEPTH_A = "128" *) 
  (* C_READ_DEPTH_B = "128" *) 
  (* C_READ_LATENCY_A = "1" *) 
  (* C_READ_LATENCY_B = "1" *) 
  (* C_READ_WIDTH_A = "128" *) 
  (* C_READ_WIDTH_B = "128" *) 
  (* C_RSTRAM_A = "0" *) 
  (* C_RSTRAM_B = "0" *) 
  (* C_RST_PRIORITY_A = "CE" *) 
  (* C_RST_PRIORITY_B = "CE" *) 
  (* C_SIM_COLLISION_CHECK = "ALL" *) 
  (* C_USE_BRAM_BLOCK = "0" *) 
  (* C_USE_BYTE_WEA = "0" *) 
  (* C_USE_BYTE_WEB = "0" *) 
  (* C_USE_DEFAULT_DATA = "1" *) 
  (* C_USE_ECC = "0" *) 
  (* C_USE_SOFTECC = "0" *) 
  (* C_USE_URAM = "0" *) 
  (* C_WEA_WIDTH = "1" *) 
  (* C_WEB_WIDTH = "1" *) 
  (* C_WRITE_DEPTH_A = "128" *) 
  (* C_WRITE_DEPTH_B = "128" *) 
  (* C_WRITE_MODE_A = "WRITE_FIRST" *) 
  (* C_WRITE_MODE_B = "WRITE_FIRST" *) 
  (* C_WRITE_WIDTH_A = "128" *) 
  (* C_WRITE_WIDTH_B = "128" *) 
  (* C_XDEVICEFAMILY = "artix7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  BITMAP_ROM_blk_mem_gen_v8_4_9 U0
       (.addra(addra),
        .addrb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .clka(clka),
        .clkb(1'b0),
        .dbiterr(NLW_U0_dbiterr_UNCONNECTED),
        .deepsleep(1'b0),
        .dina({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .dinb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .douta(douta),
        .doutb(NLW_U0_doutb_UNCONNECTED[127:0]),
        .eccpipece(1'b0),
        .ena(1'b0),
        .enb(1'b0),
        .injectdbiterr(1'b0),
        .injectsbiterr(1'b0),
        .rdaddrecc(NLW_U0_rdaddrecc_UNCONNECTED[6:0]),
        .regcea(1'b1),
        .regceb(1'b1),
        .rsta(1'b0),
        .rsta_busy(NLW_U0_rsta_busy_UNCONNECTED),
        .rstb(1'b0),
        .rstb_busy(NLW_U0_rstb_busy_UNCONNECTED),
        .s_aclk(1'b0),
        .s_aresetn(1'b0),
        .s_axi_araddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arburst({1'b0,1'b0}),
        .s_axi_arid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arready(NLW_U0_s_axi_arready_UNCONNECTED),
        .s_axi_arsize({1'b0,1'b0,1'b0}),
        .s_axi_arvalid(1'b0),
        .s_axi_awaddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awburst({1'b0,1'b0}),
        .s_axi_awid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awready(NLW_U0_s_axi_awready_UNCONNECTED),
        .s_axi_awsize({1'b0,1'b0,1'b0}),
        .s_axi_awvalid(1'b0),
        .s_axi_bid(NLW_U0_s_axi_bid_UNCONNECTED[3:0]),
        .s_axi_bready(1'b0),
        .s_axi_bresp(NLW_U0_s_axi_bresp_UNCONNECTED[1:0]),
        .s_axi_bvalid(NLW_U0_s_axi_bvalid_UNCONNECTED),
        .s_axi_dbiterr(NLW_U0_s_axi_dbiterr_UNCONNECTED),
        .s_axi_injectdbiterr(1'b0),
        .s_axi_injectsbiterr(1'b0),
        .s_axi_rdaddrecc(NLW_U0_s_axi_rdaddrecc_UNCONNECTED[6:0]),
        .s_axi_rdata(NLW_U0_s_axi_rdata_UNCONNECTED[127:0]),
        .s_axi_rid(NLW_U0_s_axi_rid_UNCONNECTED[3:0]),
        .s_axi_rlast(NLW_U0_s_axi_rlast_UNCONNECTED),
        .s_axi_rready(1'b0),
        .s_axi_rresp(NLW_U0_s_axi_rresp_UNCONNECTED[1:0]),
        .s_axi_rvalid(NLW_U0_s_axi_rvalid_UNCONNECTED),
        .s_axi_sbiterr(NLW_U0_s_axi_sbiterr_UNCONNECTED),
        .s_axi_wdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_wlast(1'b0),
        .s_axi_wready(NLW_U0_s_axi_wready_UNCONNECTED),
        .s_axi_wstrb(1'b0),
        .s_axi_wvalid(1'b0),
        .sbiterr(NLW_U0_sbiterr_UNCONNECTED),
        .shutdown(1'b0),
        .sleep(1'b0),
        .wea(1'b0),
        .web(1'b0));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2024.2"
`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
FPXllyX2NFs/RMngGqZy2bLYbZr92CdofeZrJOHklWXExpaPgHNYp2Lzm4MnflbnrfSkCmLwwKT5
zfRgEip7FKQ5Zhb73p0MAIADixBZ/ZRt4hQkJL0T9brm0waLHfanjnov2aCX6jN3LbQc3ujmDga6
Dd73k78u4xjRTDv1/P4=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
kr7VKKvChFoiyRCReag+OvU3jnmG9pN0cv+BxhNmMKLthg/ksgNZyU3L+fQ7cmIQELtlUjwjkBAP
Jjq5RsCnHbJxj+Ys1GNhriiBsxLqxWCP8onhAVvgZN2xZFOih0UWpqlU8NVP8Eww1ohvkDgxTstC
3kDmYehxIUJjqCC/mgRZmuezqugrFdubYmBoz16tUvD17iA5qqCIMS9xSIXYp2LBNekmWEwrVqzu
R4koEo4UlXl/CEw0XY3QvMoHnlXgu6N/6sc+nxZtKSwjiMVvGnZE9UVvJPAC3Hn3zKFGlK53mmGO
Tj0dWzhwX0ahSYzkyJC/HLdbGZmriL2UNvDyFw==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
CaLc9FGt3AdRHfNtGAsGFY/QEvHY1Vv4TvvgCDsdDMqiuDeLizFJDJeskBWjeKDoE2cufK8TxiBq
mySRQNJoeOKnxTiDdf+Rx6m0iR6h/YeswegYwgghpM5KVrl6mSwF3+4yEovPM7a+9ArDQ5vl+WT8
SilNGzyW0KnTwe7+szs=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
cEnudSW1X71p0Xuq6jrXOxHnBku87IA0RA3zKqmeZHZM0r+9rEm5MSzX8RecnQ994yiqeyxbIH2l
fGEzUzr0ZzryS3fkf2LnJuB39f2YARW9eVCSiaeWaraZuY1l89T+h3vgdlurS/1LIraYLS1MyOXa
6F1LAcQp3W4OO4ctc3q1FRMZGldRS1biMsKwJ8Lxj8NEOm67UfgFrJNQAxbVXEfbWRWhKtwNxcTB
JbgC8j4EHkIA46mzoHloeBAL6KieplQUBjKXSSTb66rxglbFhWLy+mirROHcocu9J4ZbvTRYZEww
4lso1lqAllVLAoKYqa3WImZuSRoTbGDngBt9Lg==

`pragma protect key_keyowner="Real Intent", key_keyname="RI-RSA-KEY-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
rOyI+x4PlmKcVSFoN3oKgSYpVlmYxc194Ej04il/YmBg10xopy4zmtu5sdCP/uGSNYcNGWeAiw01
mNf98KyNgTUFXruHCA38qjhhEIvl4vfWWn3W3mFRxrIuwmnreT6qTvgMaxIkCdVBDP7Iy7O6WmCf
3Va5X5hnCHhtXgX5UYniBHiLjmupv63B8XMAYDH2n6mQ3H0DF7mtb7psBafd0Z6+IWUbmzwMtKrf
ZrRJBGAhNT0i1KrEjEh/rWjN7Z7N32zQ+Pl1kc5gYCQIX5McfdTdqSaRVXZ/HF90ymS7/8d5LDyj
Er+ORdcjnOn6oAyY4PuUUl4OYUHv5k+RglTe5Q==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2023_11", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
bJa7kPSpDipzoJoQu1APEjc8vFLqBfQZK/grZvWijD7/FgMTerFCWLUY6n8DWeGdvjXvTeyrqCHE
2rP/H57wUqPC8tIJlGm6ZYQGjZ3TgYqLrJshDE5zYMTO//q0vuSraWvZP7A7SLuW6y7tFE/nplpx
L8gbYORx6j70okGUwnamCMS9yhFr7Z2QTJne1k4GNFGvy66URk3k5cBPl5j4/1yc4xGV+aWYl6L8
q8RorRU/CltObHKrji/jdiY1WtdGrkpRyCEFc+XNPazL9xSLLu5bz6XlvKwoks+8a5KYT/VFUovM
JbM0bpAXM8Z7rGaPuXjqXtZBg5praTZLu/WNcA==

`pragma protect key_keyowner="Metrics Technologies Inc.", key_keyname="DSim", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
PYKBDinOGc/kIVdFzXrz2wA4/QNFxLDrQfTWfR5TjYE6bm49vrZi0bawcr9HXp4OP1+XxPLB3oCP
oV5e/rYeDln531ebt8yEg27XCoSHEX4FU8oG8aBJ8fqgWayOnAMJt025WodOxuZXbhT1zPo7J3uh
6iO9Mv7RtYE2fZ1W+G8oN//FTOEJYPWlKYnt0cDeZrN3I4rHHptZHuu7l8T+df0PYea3x6U3Mvkl
ojZ+TwQtdu0NuYY5j3QNgx3+W2XYq1M773FAnEz/deW54EjE+jf1jjrBk2pl8SYxeKuutS15oPVF
eHdqXYVcJxoUY5JH8z04lITKEnZ4oq6sYS6dog==

`pragma protect key_keyowner="Atrenta", key_keyname="ATR-SG-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=384)
`pragma protect key_block
tl+2vFCWZ583gQGsVC7oopz2NCKBiJ9uOHYBGzJZheOHJMqI/ehNvo25l710eBx00tztXzM30AH6
ZhAJg+kJwE2jO0MV5fmG5dnwXmLqoGEJMBs7xwWxvYK7w/0z9M0AJKD7HnuC+IiLhNU/fIxyuE+I
+vWqp//RcfY0tMMp2I2J1yEW6GUahS1ve/4JchssZ7Xu7VthoSDWXMQWATbvsUsDzeSo2+Ruz8Kq
Dc05HqEU8NgBxDPPEKLCcdKLp4byglwj7iCAtCjsPy8P18qjgb2sycFjNgmaiNMMB51WqeD+hneG
hLOue9bqVdEojkrb3q4WbsGZKz0bAGsryxslOlYHP1b8vey3yI2ixA80wyERe8d3GRIeZiSxGykH
qWxsE6x/iyi8QRb5mXZPMApA+Fln8tYmn7+1rFCm8gF4gJWhr1PsSJqTi658symGrzT0Ghjvf2QL
SvvoaeNdy0pOsWs7jLBFndd4GiFA+9K6Y33sziLToU9EvvFokENIslod

`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="CDS_RSA_KEY_VER_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
oYiCujFRj1F3wKsGZlHR9niEtR9MLXEVAVfy+f/3xrmpW6Ye5a+fBCvm4TH+iRQefGHNdMPnzTNW
K/pEPAS9uMJjOdFiu+APT+LYrSRnEg4W0dX5buSDGM6LBWAuMseoTMjbJJoYDGLRckJgW43E30mX
ej4823nkbfwc+Ecbrup825qLyv8RTQLNHafvJA5lSapdqXwnlOIYRmcHn+sfAh5pGv9kW9aokcdh
ObR2XYxX99rYloyvz3x0pmjxD5ILW4SQMB1IUEuuyqX6eb5IQ+kZ41hjvsHIuQH29vzpCfV9Jqha
WC5yxxK1R+cleZSKD1H1gVzbTei8uFs/91Bgeg==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
urNc+S8AFPj+GVFdqJE5V7P8O6QI6MA3nkwYb8NKbYbVufnXKg6voJIRYYeYr7EOa8mrqirozWbY
Lln9SLWnkaAy2LvL/N6WahoQdCt++4RH+xe768XvSrVUFPrIwZRixqMLurc/tPov4i5P/ukZKl18
ZPZvXRzUNlvCZnMPcF+5QCQihqPbjcZ0YyGgWgX/ipTGG3sNqmylGN7qLa4Rgqu/mB5a2xVyu5Wc
911+/X3VVFx697WVaP5V0SbOzYN8R8+8B8kdznwixMA+f4lSbBXyRysVOSzYjo8bKEMqyKMVBQn9
xDmEuV0DvVWXdO7VPvWA1LuJFwS07OxeI2GCcQ==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
QcP7fsLZxaDrG29e9HQeXfu2TsKsdyW7Yc1vWct6lbmDEfXkWMU1fFWSPIjPzRc9UOnfEu0bRn+B
D+8MWokqes3WF7txljBmgUPiNGZ8arUU6ENa/IY/Wv7iaB/ZKM5PtdnFAkjDIrYyKFCTz/U6Yzwi
hBGGarK/wYQOLzeeKRewiPTiNUL7tztWuMZ1t1msxD951EeKrwjrjcXIIuf/TzrOGUOlWgjHlnrl
4Q/lfMAnRLBNTSWG+5wWewCE8jK2X/gJ5AV4p3x1WP3+JglbxpP39l3pzedXqciZPbuz2XlFnRPV
KByaUaAShzJ56p8+0HjWebibqQdieGNPiPWW0Q==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 51472)
`pragma protect data_block
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
aw==
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
