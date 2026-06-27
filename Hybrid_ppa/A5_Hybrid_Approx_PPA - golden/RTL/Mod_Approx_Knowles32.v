`timescale 1ns/1ps
module Mod_Approx_Knowles32(
    input  [31:0] a, b,
    output [31:0] s,
    output        cout
);

//============================================================
//  APPROXIMATE BLOCK (BITS 0–7)  – ripple carry + OR sums
//============================================================
wire [7:0] p0, g0;
wire [31:0] C;

assign p0 = a[7:0] ^ b[7:0];
assign g0 = a[7:0] & b[7:0];

assign C[0] = g0[0] | (p0[0] & 1'b0);
assign C[1] = g0[1] | (p0[1] & C[0]);
assign C[2] = g0[2] | (p0[2] & C[1]);
assign C[3] = g0[3] | (p0[3] & C[2]);
assign C[4] = g0[4] | (p0[4] & C[3]);
assign C[5] = g0[5] | (p0[5] & C[4]);
assign C[6] = g0[6] | (p0[6] & C[5]);
assign C[7] = g0[7] | (p0[7] & C[6]);

//============================================================
//  EXACT REGION PRE-PROCESSING (BITS 8–31)
//============================================================
wire [31:8] p, g;
assign p[31:8] = a[31:8] ^ b[31:8];
assign g[31:8] = a[31:8] & b[31:8];

//============================================================
//  KNOWLES STAGE-1  (distance = 1, nodes at 9–31)
//============================================================
wire [31:8] k1_p, k1_g;

// bit 8: pass, but include C7
assign k1_p[8] = p[8];
assign k1_g[8] = g[8] | (p[8] & C[7]);

assign k1_p[9]  = p[9]  & p[8];
assign k1_g[9]  = g[9]  | (p[9]  & g[8]);

assign k1_p[10] = p[10] & p[9];
assign k1_g[10] = g[10] | (p[10] & g[9]);

assign k1_p[11] = p[11] & p[10];
assign k1_g[11] = g[11] | (p[11] & g[10]);

assign k1_p[12] = p[12] & p[11];
assign k1_g[12] = g[12] | (p[12] & g[11]);

assign k1_p[13] = p[13] & p[12];
assign k1_g[13] = g[13] | (p[13] & g[12]);

assign k1_p[14] = p[14] & p[13];
assign k1_g[14] = g[14] | (p[14] & g[13]);

assign k1_p[15] = p[15] & p[14];
assign k1_g[15] = g[15] | (p[15] & g[14]);

assign k1_p[16] = p[16] & p[15];
assign k1_g[16] = g[16] | (p[16] & g[15]);

assign k1_p[17] = p[17] & p[16];
assign k1_g[17] = g[17] | (p[17] & g[16]);

assign k1_p[18] = p[18] & p[17];
assign k1_g[18] = g[18] | (p[18] & g[17]);

assign k1_p[19] = p[19] & p[18];
assign k1_g[19] = g[19] | (p[19] & g[18]);

assign k1_p[20] = p[20] & p[19];
assign k1_g[20] = g[20] | (p[20] & g[19]);

assign k1_p[21] = p[21] & p[20];
assign k1_g[21] = g[21] | (p[21] & g[20]);

assign k1_p[22] = p[22] & p[21];
assign k1_g[22] = g[22] | (p[22] & g[21]);

assign k1_p[23] = p[23] & p[22];
assign k1_g[23] = g[23] | (p[23] & g[22]);

assign k1_p[24] = p[24] & p[23];
assign k1_g[24] = g[24] | (p[24] & g[23]);

assign k1_p[25] = p[25] & p[24];
assign k1_g[25] = g[25] | (p[25] & g[24]);

assign k1_p[26] = p[26] & p[25];
assign k1_g[26] = g[26] | (p[26] & g[25]);

assign k1_p[27] = p[27] & p[26];
assign k1_g[27] = g[27] | (p[27] & g[26]);

assign k1_p[28] = p[28] & p[27];
assign k1_g[28] = g[28] | (p[28] & g[27]);

assign k1_p[29] = p[29] & p[28];
assign k1_g[29] = g[29] | (p[29] & g[28]);

assign k1_p[30] = p[30] & p[29];
assign k1_g[30] = g[30] | (p[30] & g[29]);

assign k1_p[31] = p[31] & p[30];
assign k1_g[31] = g[31] | (p[31] & g[30]);

//============================================================
//  KNOWLES STAGE-2  (distance = 2, nodes at 10–31)
//============================================================
wire [31:8] k2_p, k2_g;

assign k2_p[8] = k1_p[8];
assign k2_g[8] = k1_g[8];

assign k2_p[9] = k1_p[9];
assign k2_g[9] = k1_g[9];

assign k2_p[10] = k1_p[10] & k1_p[8];
assign k2_g[10] = k1_g[10] | (k1_p[10] & k1_g[8]);

assign k2_p[11] = k1_p[11] & k1_p[9];
assign k2_g[11] = k1_g[11] | (k1_p[11] & k1_g[9]);

assign k2_p[12] = k1_p[12] & k1_p[10];
assign k2_g[12] = k1_g[12] | (k1_p[12] & k1_g[10]);

assign k2_p[13] = k1_p[13] & k1_p[11];
assign k2_g[13] = k1_g[13] | (k1_p[13] & k1_g[11]);

assign k2_p[14] = k1_p[14] & k1_p[12];
assign k2_g[14] = k1_g[14] | (k1_p[14] & k1_g[12]);

assign k2_p[15] = k1_p[15] & k1_p[13];
assign k2_g[15] = k1_g[15] | (k1_p[15] & k1_g[13]);

assign k2_p[16] = k1_p[16] & k1_p[14];
assign k2_g[16] = k1_g[16] | (k1_p[16] & k1_g[14]);

assign k2_p[17] = k1_p[17] & k1_p[15];
assign k2_g[17] = k1_g[17] | (k1_p[17] & k1_g[15]);

assign k2_p[18] = k1_p[18] & k1_p[16];
assign k2_g[18] = k1_g[18] | (k1_p[18] & k1_g[16]);

assign k2_p[19] = k1_p[19] & k1_p[17];
assign k2_g[19] = k1_g[19] | (k1_p[19] & k1_g[17]);

assign k2_p[20] = k1_p[20] & k1_p[18];
assign k2_g[20] = k1_g[20] | (k1_p[20] & k1_g[18]);

assign k2_p[21] = k1_p[21] & k1_p[19];
assign k2_g[21] = k1_g[21] | (k1_p[21] & k1_g[19]);

assign k2_p[22] = k1_p[22] & k1_p[20];
assign k2_g[22] = k1_g[22] | (k1_p[22] & k1_g[20]);

assign k2_p[23] = k1_p[23] & k1_p[21];
assign k2_g[23] = k1_g[23] | (k1_p[23] & k1_g[21]);

assign k2_p[24] = k1_p[24] & k1_p[22];
assign k2_g[24] = k1_g[24] | (k1_p[24] & k1_g[22]);

assign k2_p[25] = k1_p[25] & k1_p[23];
assign k2_g[25] = k1_g[25] | (k1_p[25] & k1_g[23]);

assign k2_p[26] = k1_p[26] & k1_p[24];
assign k2_g[26] = k1_g[26] | (k1_p[26] & k1_g[24]);

assign k2_p[27] = k1_p[27] & k1_p[25];
assign k2_g[27] = k1_g[27] | (k1_p[27] & k1_g[25]);

assign k2_p[28] = k1_p[28] & k1_p[26];
assign k2_g[28] = k1_g[28] | (k1_p[28] & k1_g[26]);

assign k2_p[29] = k1_p[29] & k1_p[27];
assign k2_g[29] = k1_g[29] | (k1_p[29] & k1_g[27]);

assign k2_p[30] = k1_p[30] & k1_p[28];
assign k2_g[30] = k1_g[30] | (k1_p[30] & k1_g[28]);

assign k2_p[31] = k1_p[31] & k1_p[29];
assign k2_g[31] = k1_g[31] | (k1_p[31] & k1_g[29]);

//============================================================
//  KNOWLES STAGE-3  (distance = 4, nodes at 12–31)
//============================================================
wire [31:8] k3_p, k3_g;

assign k3_p[8]  = k2_p[8];
assign k3_g[8]  = k2_g[8];
assign k3_p[9]  = k2_p[9];
assign k3_g[9]  = k2_g[9];
assign k3_p[10] = k2_p[10];
assign k3_g[10] = k2_g[10];
assign k3_p[11] = k2_p[11];
assign k3_g[11] = k2_g[11];

assign k3_p[12] = k2_p[12] & k2_p[8];
assign k3_g[12] = k2_g[12] | (k2_p[12] & k2_g[8]);

assign k3_p[13] = k2_p[13] & k2_p[9];
assign k3_g[13] = k2_g[13] | (k2_p[13] & k2_g[9]);

assign k3_p[14] = k2_p[14] & k2_p[10];
assign k3_g[14] = k2_g[14] | (k2_p[14] & k2_g[10]);

assign k3_p[15] = k2_p[15] & k2_p[11];
assign k3_g[15] = k2_g[15] | (k2_p[15] & k2_g[11]);

assign k3_p[16] = k2_p[16] & k2_p[12];
assign k3_g[16] = k2_g[16] | (k2_p[16] & k2_g[12]);

assign k3_p[17] = k2_p[17] & k2_p[13];
assign k3_g[17] = k2_g[17] | (k2_p[17] & k2_g[13]);

assign k3_p[18] = k2_p[18] & k2_p[14];
assign k3_g[18] = k2_g[18] | (k2_p[18] & k2_g[14]);

assign k3_p[19] = k2_p[19] & k2_p[15];
assign k3_g[19] = k2_g[19] | (k2_p[19] & k2_g[15]);

assign k3_p[20] = k2_p[20] & k2_p[16];
assign k3_g[20] = k2_g[20] | (k2_p[20] & k2_g[16]);

assign k3_p[21] = k2_p[21] & k2_p[17];
assign k3_g[21] = k2_g[21] | (k2_p[21] & k2_g[17]);

assign k3_p[22] = k2_p[22] & k2_p[18];
assign k3_g[22] = k2_g[22] | (k2_p[22] & k2_g[18]);

assign k3_p[23] = k2_p[23] & k2_p[19];
assign k3_g[23] = k2_g[23] | (k2_p[23] & k2_g[19]);

assign k3_p[24] = k2_p[24] & k2_p[20];
assign k3_g[24] = k2_g[24] | (k2_p[24] & k2_g[20]);

assign k3_p[25] = k2_p[25] & k2_p[21];
assign k3_g[25] = k2_g[25] | (k2_p[25] & k2_g[21]);

assign k3_p[26] = k2_p[26] & k2_p[22];
assign k3_g[26] = k2_g[26] | (k2_p[26] & k2_g[22]);

assign k3_p[27] = k2_p[27] & k2_p[23];
assign k3_g[27] = k2_g[27] | (k2_p[27] & k2_g[23]);

assign k3_p[28] = k2_p[28] & k2_p[24];
assign k3_g[28] = k2_g[28] | (k2_p[28] & k2_g[24]);

assign k3_p[29] = k2_p[29] & k2_p[25];
assign k3_g[29] = k2_g[29] | (k2_p[29] & k2_g[25]);

assign k3_p[30] = k2_p[30] & k2_p[26];
assign k3_g[30] = k2_g[30] | (k2_p[30] & k2_g[26]);

assign k3_p[31] = k2_p[31] & k2_p[27];
assign k3_g[31] = k2_g[31] | (k2_p[31] & k2_g[27]);

//============================================================
//  KNOWLES STAGE-4  (distance = 8, nodes at 16–31)
//============================================================
wire [31:8] k4_p, k4_g;

assign k4_p[8]  = k3_p[8];
assign k4_g[8]  = k3_g[8];
assign k4_p[9]  = k3_p[9];
assign k4_g[9]  = k3_g[9];
assign k4_p[10] = k3_p[10];
assign k4_g[10] = k3_g[10];
assign k4_p[11] = k3_p[11];
assign k4_g[11] = k3_g[11];
assign k4_p[12] = k3_p[12];
assign k4_g[12] = k3_g[12];
assign k4_p[13] = k3_p[13];
assign k4_g[13] = k3_g[13];
assign k4_p[14] = k3_p[14];
assign k4_g[14] = k3_g[14];
assign k4_p[15] = k3_p[15];
assign k4_g[15] = k3_g[15];

assign k4_p[16] = k3_p[16] & k3_p[8];
assign k4_g[16] = k3_g[16] | (k3_p[16] & k3_g[8]);

assign k4_p[17] = k3_p[17] & k3_p[9];
assign k4_g[17] = k3_g[17] | (k3_p[17] & k3_g[9]);

assign k4_p[18] = k3_p[18] & k3_p[10];
assign k4_g[18] = k3_g[18] | (k3_p[18] & k3_g[10]);

assign k4_p[19] = k3_p[19] & k3_p[11];
assign k4_g[19] = k3_g[19] | (k3_p[19] & k3_g[11]);

assign k4_p[20] = k3_p[20] & k3_p[12];
assign k4_g[20] = k3_g[20] | (k3_p[20] & k3_g[12]);

assign k4_p[21] = k3_p[21] & k3_p[13];
assign k4_g[21] = k3_g[21] | (k3_p[21] & k3_g[13]);

assign k4_p[22] = k3_p[22] & k3_p[14];
assign k4_g[22] = k3_g[22] | (k3_p[22] & k3_g[14]);

assign k4_p[23] = k3_p[23] & k3_p[15];
assign k4_g[23] = k3_g[23] | (k3_p[23] & k3_g[15]);

assign k4_p[24] = k3_p[24] & k3_p[16];
assign k4_g[24] = k3_g[24] | (k3_p[24] & k3_g[16]);

assign k4_p[25] = k3_p[25] & k3_p[17];
assign k4_g[25] = k3_g[25] | (k3_p[25] & k3_g[17]);

assign k4_p[26] = k3_p[26] & k3_p[18];
assign k4_g[26] = k3_g[26] | (k3_p[26] & k3_g[18]);

assign k4_p[27] = k3_p[27] & k3_p[19];
assign k4_g[27] = k3_g[27] | (k3_p[27] & k3_g[19]);

assign k4_p[28] = k3_p[28] & k3_p[20];
assign k4_g[28] = k3_g[28] | (k3_p[28] & k3_g[20]);

assign k4_p[29] = k3_p[29] & k3_p[21];
assign k4_g[29] = k3_g[29] | (k3_p[29] & k3_g[21]);

assign k4_p[30] = k3_p[30] & k3_p[22];
assign k4_g[30] = k3_g[30] | (k3_p[30] & k3_g[22]);

assign k4_p[31] = k3_p[31] & k3_p[23];
assign k4_g[31] = k3_g[31] | (k3_p[31] & k3_g[23]);

//============================================================
//  KNOWLES STAGE-5  (distance = 16, nodes at 24–31)
//============================================================
wire [31:8] k5_p, k5_g;

assign k5_p[8]  = k4_p[8];
assign k5_g[8]  = k4_g[8];
assign k5_p[9]  = k4_p[9];
assign k5_g[9]  = k4_g[9];
assign k5_p[10] = k4_p[10];
assign k5_g[10] = k4_g[10];
assign k5_p[11] = k4_p[11];
assign k5_g[11] = k4_g[11];
assign k5_p[12] = k4_p[12];
assign k5_g[12] = k4_g[12];
assign k5_p[13] = k4_p[13];
assign k5_g[13] = k4_g[13];
assign k5_p[14] = k4_p[14];
assign k5_g[14] = k4_g[14];
assign k5_p[15] = k4_p[15];
assign k5_g[15] = k4_g[15];
assign k5_p[16] = k4_p[16];
assign k5_g[16] = k4_g[16];
assign k5_p[17] = k4_p[17];
assign k5_g[17] = k4_g[17];
assign k5_p[18] = k4_p[18];
assign k5_g[18] = k4_g[18];
assign k5_p[19] = k4_p[19];
assign k5_g[19] = k4_g[19];
assign k5_p[20] = k4_p[20];
assign k5_g[20] = k4_g[20];
assign k5_p[21] = k4_p[21];
assign k5_g[21] = k4_g[21];
assign k5_p[22] = k4_p[22];
assign k5_g[22] = k4_g[22];
assign k5_p[23] = k4_p[23];
assign k5_g[23] = k4_g[23];

assign k5_p[24] = k4_p[24] & k4_p[8];
assign k5_g[24] = k4_g[24] | (k4_p[24] & k4_g[8]);

assign k5_p[25] = k4_p[25] & k4_p[9];
assign k5_g[25] = k4_g[25] | (k4_p[25] & k4_g[9]);

assign k5_p[26] = k4_p[26] & k4_p[10];
assign k5_g[26] = k4_g[26] | (k4_p[26] & k4_g[10]);

assign k5_p[27] = k4_p[27] & k4_p[11];
assign k5_g[27] = k4_g[27] | (k4_p[27] & k4_g[11]);

assign k5_p[28] = k4_p[28] & k4_p[12];
assign k5_g[28] = k4_g[28] | (k4_p[28] & k4_g[12]);

assign k5_p[29] = k4_p[29] & k4_p[13];
assign k5_g[29] = k4_g[29] | (k4_p[29] & k4_g[13]);

assign k5_p[30] = k4_p[30] & k4_p[14];
assign k5_g[30] = k4_g[30] | (k4_p[30] & k4_g[14]);

assign k5_p[31] = k4_p[31] & k4_p[15];
assign k5_g[31] = k4_g[31] | (k4_p[31] & k4_g[15]);

//============================================================
//  CARRY ASSIGNMENTS FOR EXACT REGION
//============================================================
assign C[8]  = k5_g[8];
assign C[9]  = k5_g[9];
assign C[10] = k5_g[10];
assign C[11] = k5_g[11];
assign C[12] = k5_g[12];
assign C[13] = k5_g[13];
assign C[14] = k5_g[14];
assign C[15] = k5_g[15];
assign C[16] = k5_g[16];
assign C[17] = k5_g[17];
assign C[18] = k5_g[18];
assign C[19] = k5_g[19];
assign C[20] = k5_g[20];
assign C[21] = k5_g[21];
assign C[22] = k5_g[22];
assign C[23] = k5_g[23];
assign C[24] = k5_g[24];
assign C[25] = k5_g[25];
assign C[26] = k5_g[26];
assign C[27] = k5_g[27];
assign C[28] = k5_g[28];
assign C[29] = k5_g[29];
assign C[30] = k5_g[30];
assign C[31] = k5_g[31];

assign cout = k5_g[31];

//============================================================
//  FINAL SUMS
//============================================================
assign s[0] = p0[0] | C[0];
assign s[1] = p0[1] | C[1];
assign s[2] = p0[2] | C[2];
assign s[3] = p0[3] | C[3];
assign s[4] = p0[4] | C[4];
assign s[5] = p0[5] | C[5];
assign s[6] = p0[6] | C[6];
assign s[7] = p0[7] | C[7];

assign s[8]  = p[8]  ^ C[7];
assign s[9]  = p[9]  ^ C[8];
assign s[10] = p[10] ^ C[9];
assign s[11] = p[11] ^ C[10];
assign s[12] = p[12] ^ C[11];
assign s[13] = p[13] ^ C[12];
assign s[14] = p[14] ^ C[13];
assign s[15] = p[15] ^ C[14];
assign s[16] = p[16] ^ C[15];
assign s[17] = p[17] ^ C[16];
assign s[18] = p[18] ^ C[17];
assign s[19] = p[19] ^ C[18];
assign s[20] = p[20] ^ C[19];
assign s[21] = p[21] ^ C[20];
assign s[22] = p[22] ^ C[21];
assign s[23] = p[23] ^ C[22];
assign s[24] = p[24] ^ C[23];
assign s[25] = p[25] ^ C[24];
assign s[26] = p[26] ^ C[25];
assign s[27] = p[27] ^ C[26];
assign s[28] = p[28] ^ C[27];
assign s[29] = p[29] ^ C[28];
assign s[30] = p[30] ^ C[29];
assign s[31] = p[31] ^ C[30];

endmodule
