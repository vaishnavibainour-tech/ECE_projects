`timescale 1ns/1ps

module Mod_Approx_Sklansky32 (
    input  [31:0] a, b,
    output [31:0] s,
    output        cout
);

//============================================================
//  APPROXIMATE BLOCK (BITS 0–7)
//============================================================
wire [7:0]  p0, g0;
wire [31:0] C;

assign p0 = a[7:0] ^ b[7:0];
assign g0 = a[7:0] & b[7:0];

// ripple carry for bits 0–7
assign C[0] = g0[0];                     // cin = 0
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
//  STAGE-1  (distance 1, nodes: 9,11,13,...,29)
//============================================================
wire [31:8] s1_cp, s1_cg;

// bit 8: pass, but include C7
assign s1_cp[8] = p[8];
assign s1_cg[8] = g[8] | (p[8] & C[7]);

assign s1_cp[9]  = p[9]  & p[8];
assign s1_cg[9]  = g[9]  | (p[9]  & g[8]);

assign s1_cp[10] = p[10];
assign s1_cg[10] = g[10];

assign s1_cp[11] = p[11] & p[10];
assign s1_cg[11] = g[11] | (p[11] & g[10]);

assign s1_cp[12] = p[12];
assign s1_cg[12] = g[12];

assign s1_cp[13] = p[13] & p[12];
assign s1_cg[13] = g[13] | (p[13] & g[12]);

assign s1_cp[14] = p[14];
assign s1_cg[14] = g[14];

assign s1_cp[15] = p[15] & p[14];
assign s1_cg[15] = g[15] | (p[15] & g[14]);

assign s1_cp[16] = p[16];
assign s1_cg[16] = g[16];

assign s1_cp[17] = p[17] & p[16];
assign s1_cg[17] = g[17] | (p[17] & g[16]);

assign s1_cp[18] = p[18];
assign s1_cg[18] = g[18];

assign s1_cp[19] = p[19] & p[18];
assign s1_cg[19] = g[19] | (p[19] & g[18]);

assign s1_cp[20] = p[20];
assign s1_cg[20] = g[20];

assign s1_cp[21] = p[21] & p[20];
assign s1_cg[21] = g[21] | (p[21] & g[20]);

assign s1_cp[22] = p[22];
assign s1_cg[22] = g[22];

assign s1_cp[23] = p[23] & p[22];
assign s1_cg[23] = g[23] | (p[23] & g[22]);

assign s1_cp[24] = p[24];
assign s1_cg[24] = g[24];

assign s1_cp[25] = p[25] & p[24];
assign s1_cg[25] = g[25] | (p[25] & g[24]);

assign s1_cp[26] = p[26];
assign s1_cg[26] = g[26];

assign s1_cp[27] = p[27] & p[26];
assign s1_cg[27] = g[27] | (p[27] & g[26]);

assign s1_cp[28] = p[28];
assign s1_cg[28] = g[28];

assign s1_cp[29] = p[29] & p[28];
assign s1_cg[29] = g[29] | (p[29] & g[28]);

assign s1_cp[30] = p[30];
assign s1_cg[30] = g[30];

assign s1_cp[31] = p[31];
assign s1_cg[31] = g[31];

//============================================================
//  STAGE-2  (distance 2, nodes: 10,14,18,22,26,30)
//============================================================
wire [31:8] s2_cp, s2_cg;

assign s2_cp[8]  = s1_cp[8];
assign s2_cg[8]  = s1_cg[8];
assign s2_cp[9]  = s1_cp[9];
assign s2_cg[9]  = s1_cg[9];

assign s2_cp[10] = s1_cp[10] & s1_cp[9];
assign s2_cg[10] = s1_cg[10] | (s1_cp[10] & s1_cg[9]);

assign s2_cp[11] = s1_cp[11] & s1_cp[9];
assign s2_cg[11] = s1_cg[11] | (s1_cp[11] & s1_cg[9]);

assign s2_cp[12] = s1_cp[12];
assign s2_cg[12] = s1_cg[12];

assign s2_cp[13] = s1_cp[13];
assign s2_cg[13] = s1_cg[13];

assign s2_cp[14] = s1_cp[14] & s1_cp[13];
assign s2_cg[14] = s1_cg[14] | (s1_cp[14] & s1_cg[13]);

assign s2_cp[15] = s1_cp[15] & s1_cp[13];
assign s2_cg[15] = s1_cg[15] | (s1_cp[15] & s1_cg[13]);

assign s2_cp[16] = s1_cp[16];
assign s2_cg[16] = s1_cg[16];

assign s2_cp[17] = s1_cp[17];
assign s2_cg[17] = s1_cg[17];

assign s2_cp[18] = s1_cp[18] & s1_cp[17];
assign s2_cg[18] = s1_cg[18] | (s1_cp[18] & s1_cg[17]);

assign s2_cp[19] = s1_cp[19] & s1_cp[17];
assign s2_cg[19] = s1_cg[19] | (s1_cp[19] & s1_cg[17]);

assign s2_cp[20] = s1_cp[20];
assign s2_cg[20] = s1_cg[20];

assign s2_cp[21] = s1_cp[21];
assign s2_cg[21] = s1_cg[21];

assign s2_cp[22] = s1_cp[22] & s1_cp[21];
assign s2_cg[22] = s1_cg[22] | (s1_cp[22] & s1_cg[21]);

assign s2_cp[23] = s1_cp[23] & s1_cp[21];
assign s2_cg[23] = s1_cg[23] | (s1_cp[23] & s1_cg[21]);

assign s2_cp[24] = s1_cp[24];
assign s2_cg[24] = s1_cg[24];

assign s2_cp[25] = s1_cp[25];
assign s2_cg[25] = s1_cg[25];

assign s2_cp[26] = s1_cp[26] & s1_cp[25];
assign s2_cg[26] = s1_cg[26] | (s1_cp[26] & s1_cg[25]);

assign s2_cp[27] = s1_cp[27] & s1_cp[25];
assign s2_cg[27] = s1_cg[27] | (s1_cp[27] & s1_cg[25]);

assign s2_cp[28] = s1_cp[28];
assign s2_cg[28] = s1_cg[28];

assign s2_cp[29] = s1_cp[29];
assign s2_cg[29] = s1_cg[29];

assign s2_cp[30] = s1_cp[30] & s1_cp[29];
assign s2_cg[30] = s1_cg[30] | (s1_cp[30] & s1_cg[29]);

assign s2_cp[31] = s1_cp[31] & s1_cp[29];
assign s2_cg[31] = s1_cg[31] | (s1_cp[31] & s1_cg[29]);

//============================================================
//  STAGE-3  (distance 4, nodes: 12,20,28)
//============================================================
wire [31:8] s3_cp, s3_cg;

assign s3_cp[8]  = s2_cp[8];
assign s3_cg[8]  = s2_cg[8];
assign s3_cp[9]  = s2_cp[9];
assign s3_cg[9]  = s2_cg[9];
assign s3_cp[10] = s2_cp[10];
assign s3_cg[10] = s2_cg[10];
assign s3_cp[11] = s2_cp[11];
assign s3_cg[11] = s2_cg[11];

assign s3_cp[12] = s2_cp[12] & s2_cp[11];
assign s3_cg[12] = s2_cg[12] | (s2_cp[12] & s2_cg[11]);

assign s3_cp[13] = s2_cp[13] & s2_cp[11];
assign s3_cg[13] = s2_cg[13] | (s2_cp[13] & s2_cg[11]);

assign s3_cp[14] = s2_cp[14] & s2_cp[11];
assign s3_cg[14] = s2_cg[14] | (s2_cp[14] & s2_cg[11]);

assign s3_cp[15] = s2_cp[15] & s2_cp[11];
assign s3_cg[15] = s2_cg[15] | (s2_cp[15] & s2_cg[11]);

assign s3_cp[16] = s2_cp[16];
assign s3_cg[16] = s2_cg[16];
assign s3_cp[17] = s2_cp[17];
assign s3_cg[17] = s2_cg[17];
assign s3_cp[18] = s2_cp[18];
assign s3_cg[18] = s2_cg[18];
assign s3_cp[19] = s2_cp[19];
assign s3_cg[19] = s2_cg[19];

assign s3_cp[20] = s2_cp[20] & s2_cp[19];
assign s3_cg[20] = s2_cg[20] | (s2_cp[20] & s2_cg[19]);

assign s3_cp[21] = s2_cp[21] & s2_cp[19];
assign s3_cg[21] = s2_cg[21] | (s2_cp[21] & s2_cg[19]);

assign s3_cp[22] = s2_cp[22] & s2_cp[19];
assign s3_cg[22] = s2_cg[22] | (s2_cp[22] & s2_cg[19]);

assign s3_cp[23] = s2_cp[23] & s2_cp[19];
assign s3_cg[23] = s2_cg[23] | (s2_cp[23] & s2_cg[19]);

assign s3_cp[24] = s2_cp[24];
assign s3_cg[24] = s2_cg[24];
assign s3_cp[25] = s2_cp[25];
assign s3_cg[25] = s2_cg[25];
assign s3_cp[26] = s2_cp[26];
assign s3_cg[26] = s2_cg[26];
assign s3_cp[27] = s2_cp[27];
assign s3_cg[27] = s2_cg[27];

assign s3_cp[28] = s2_cp[28] & s2_cp[27];
assign s3_cg[28] = s2_cg[28] | (s2_cp[28] & s2_cg[27]);

assign s3_cp[29] = s2_cp[29] & s2_cp[27];
assign s3_cg[29] = s2_cg[29] | (s2_cp[29] & s2_cg[27]);

assign s3_cp[30] = s2_cp[30] & s2_cp[27];
assign s3_cg[30] = s2_cg[30] | (s2_cp[30] & s2_cg[27]);

assign s3_cp[31] = s2_cp[31] & s2_cp[27];
assign s3_cg[31] = s2_cg[31] | (s2_cp[31] & s2_cg[27]);

//============================================================
//  STAGE-4  (distance 8, nodes: 16–23)
//============================================================
wire [31:8] s4_cp, s4_cg;

assign s4_cp[8]  = s3_cp[8];
assign s4_cg[8]  = s3_cg[8];
assign s4_cp[9]  = s3_cp[9];
assign s4_cg[9]  = s3_cg[9];
assign s4_cp[10] = s3_cp[10];
assign s4_cg[10] = s3_cg[10];
assign s4_cp[11] = s3_cp[11];
assign s4_cg[11] = s3_cg[11];
assign s4_cp[12] = s3_cp[12];
assign s4_cg[12] = s3_cg[12];
assign s4_cp[13] = s3_cp[13];
assign s4_cg[13] = s3_cg[13];
assign s4_cp[14] = s3_cp[14];
assign s4_cg[14] = s3_cg[14];
assign s4_cp[15] = s3_cp[15];
assign s4_cg[15] = s3_cg[15];

assign s4_cp[16] = s3_cp[16] & s3_cp[15];
assign s4_cg[16] = s3_cg[16] | (s3_cp[16] & s3_cg[15]);

assign s4_cp[17] = s3_cp[17] & s3_cp[15];
assign s4_cg[17] = s3_cg[17] | (s3_cp[17] & s3_cg[15]);

assign s4_cp[18] = s3_cp[18] & s3_cp[15];
assign s4_cg[18] = s3_cg[18] | (s3_cp[18] & s3_cg[15]);

assign s4_cp[19] = s3_cp[19] & s3_cp[15];
assign s4_cg[19] = s3_cg[19] | (s3_cp[19] & s3_cg[15]);

assign s4_cp[20] = s3_cp[20] & s3_cp[15];
assign s4_cg[20] = s3_cg[20] | (s3_cp[20] & s3_cg[15]);

assign s4_cp[21] = s3_cp[21] & s3_cp[15];
assign s4_cg[21] = s3_cg[21] | (s3_cp[21] & s3_cg[15]);

assign s4_cp[22] = s3_cp[22] & s3_cp[15];
assign s4_cg[22] = s3_cg[22] | (s3_cp[22] & s3_cg[15]);

assign s4_cp[23] = s3_cp[23] & s3_cp[15];
assign s4_cg[23] = s3_cg[23] | (s3_cp[23] & s3_cg[15]);

assign s4_cp[24] = s3_cp[24];
assign s4_cg[24] = s3_cg[24];
assign s4_cp[25] = s3_cp[25];
assign s4_cg[25] = s3_cg[25];
assign s4_cp[26] = s3_cp[26];
assign s4_cg[26] = s3_cg[26];
assign s4_cp[27] = s3_cp[27];
assign s4_cg[27] = s3_cg[27];
assign s4_cp[28] = s3_cp[28];
assign s4_cg[28] = s3_cg[28];
assign s4_cp[29] = s3_cp[29];
assign s4_cg[29] = s3_cg[29];
assign s4_cp[30] = s3_cp[30];
assign s4_cg[30] = s3_cg[30];
assign s4_cp[31] = s3_cp[31];
assign s4_cg[31] = s3_cg[31];

//============================================================
//  STAGE-5  (distance 16, nodes: 24–31)
//============================================================
wire [31:8] s5_cp, s5_cg;

assign s5_cp[8]  = s4_cp[8];
assign s5_cg[8]  = s4_cg[8];
assign s5_cp[9]  = s4_cp[9];
assign s5_cg[9]  = s4_cg[9];
assign s5_cp[10] = s4_cp[10];
assign s5_cg[10] = s4_cg[10];
assign s5_cp[11] = s4_cp[11];
assign s5_cg[11] = s4_cg[11];
assign s5_cp[12] = s4_cp[12];
assign s5_cg[12] = s4_cg[12];
assign s5_cp[13] = s4_cp[13];
assign s5_cg[13] = s4_cg[13];
assign s5_cp[14] = s4_cp[14];
assign s5_cg[14] = s4_cg[14];
assign s5_cp[15] = s4_cp[15];
assign s5_cg[15] = s4_cg[15];

assign s5_cp[16] = s4_cp[16];
assign s5_cg[16] = s4_cg[16];
assign s5_cp[17] = s4_cp[17];
assign s5_cg[17] = s4_cg[17];
assign s5_cp[18] = s4_cp[18];
assign s5_cg[18] = s4_cg[18];
assign s5_cp[19] = s4_cp[19];
assign s5_cg[19] = s4_cg[19];
assign s5_cp[20] = s4_cp[20];
assign s5_cg[20] = s4_cg[20];
assign s5_cp[21] = s4_cp[21];
assign s5_cg[21] = s4_cg[21];
assign s5_cp[22] = s4_cp[22];
assign s5_cg[22] = s4_cg[22];
assign s5_cp[23] = s4_cp[23];
assign s5_cg[23] = s4_cg[23];

assign s5_cp[24] = s4_cp[24] & s4_cp[23];
assign s5_cg[24] = s4_cg[24] | (s4_cp[24] & s4_cg[23]);

assign s5_cp[25] = s4_cp[25] & s4_cp[23];
assign s5_cg[25] = s4_cg[25] | (s4_cp[25] & s4_cg[23]);

assign s5_cp[26] = s4_cp[26] & s4_cp[23];
assign s5_cg[26] = s4_cg[26] | (s4_cp[26] & s4_cg[23]);

assign s5_cp[27] = s4_cp[27] & s4_cp[23];
assign s5_cg[27] = s4_cg[27] | (s4_cp[27] & s4_cg[23]);

assign s5_cp[28] = s4_cp[28] & s4_cp[23];
assign s5_cg[28] = s4_cg[28] | (s4_cp[28] & s4_cg[23]);

assign s5_cp[29] = s4_cp[29] & s4_cp[23];
assign s5_cg[29] = s4_cg[29] | (s4_cp[29] & s4_cg[23]);

assign s5_cp[30] = s4_cp[30] & s4_cp[23];
assign s5_cg[30] = s4_cg[30] | (s4_cp[30] & s4_cg[23]);

assign s5_cp[31] = s4_cp[31] & s4_cp[23];
assign s5_cg[31] = s4_cg[31] | (s4_cp[31] & s4_cg[23]);

//============================================================
//  CARRIES 8–31 FROM PREFIX
//============================================================
assign C[8]  = s5_cg[8];
assign C[9]  = s5_cg[9];
assign C[10] = s5_cg[10];
assign C[11] = s5_cg[11];
assign C[12] = s5_cg[12];
assign C[13] = s5_cg[13];
assign C[14] = s5_cg[14];
assign C[15] = s5_cg[15];
assign C[16] = s5_cg[16];
assign C[17] = s5_cg[17];
assign C[18] = s5_cg[18];
assign C[19] = s5_cg[19];
assign C[20] = s5_cg[20];
assign C[21] = s5_cg[21];
assign C[22] = s5_cg[22];
assign C[23] = s5_cg[23];
assign C[24] = s5_cg[24];
assign C[25] = s5_cg[25];
assign C[26] = s5_cg[26];
assign C[27] = s5_cg[27];
assign C[28] = s5_cg[28];
assign C[29] = s5_cg[29];
assign C[30] = s5_cg[30];
assign C[31] = s5_cg[31];

assign cout = s5_cg[31];

//============================================================
//  FINAL SUMS
//============================================================
// Approximate sums 0–7 (OR)
assign s[0] = p0[0] | C[0];
assign s[1] = p0[1] | C[1];
assign s[2] = p0[2] | C[2];
assign s[3] = p0[3] | C[3];
assign s[4] = p0[4] | C[4];
assign s[5] = p0[5] | C[5];
assign s[6] = p0[6] | C[6];
assign s[7] = p0[7] | C[7];

// Exact sums 8–31 (XOR with carry)
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
