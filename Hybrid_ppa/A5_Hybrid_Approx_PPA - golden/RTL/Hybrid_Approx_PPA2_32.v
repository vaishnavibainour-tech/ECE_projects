`timescale 1ns/1ps

module Hybrid_Approx_PPA2_32 (
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

// ripple carry 0–7, cin = 0
assign C[0] = g0[0];
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
//  PART 1 : 12-bit SKLANSKY on bits 8–19 (cin = C[7])
//============================================================

//------------- STAGE-1 (distance 1, nodes at 9,11,13,15,17,19)
wire [19:8] sk1_p, sk1_g;

// bit 8: includes C7
assign sk1_p[8] = p[8];
assign sk1_g[8] = g[8] | (p[8] & C[7]);

assign sk1_p[9]  = p[9]  & p[8];
assign sk1_g[9]  = g[9]  | (p[9] & g[8]);

assign sk1_p[10] = p[10];
assign sk1_g[10] = g[10];

assign sk1_p[11] = p[11] & p[10];
assign sk1_g[11] = g[11] | (p[11] & g[10]);

assign sk1_p[12] = p[12];
assign sk1_g[12] = g[12];

assign sk1_p[13] = p[13] & p[12];
assign sk1_g[13] = g[13] | (p[13] & g[12]);

assign sk1_p[14] = p[14];
assign sk1_g[14] = g[14];

assign sk1_p[15] = p[15] & p[14];
assign sk1_g[15] = g[15] | (p[15] & g[14]);

assign sk1_p[16] = p[16];
assign sk1_g[16] = g[16];

assign sk1_p[17] = p[17] & p[16];
assign sk1_g[17] = g[17] | (p[17] & g[16]);

assign sk1_p[18] = p[18];
assign sk1_g[18] = g[18];

assign sk1_p[19] = p[19] & p[18];
assign sk1_g[19] = g[19] | (p[19] & g[18]);

//------------- STAGE-2 (distance 2, nodes at 10,14,18)
wire [19:8] sk2_p, sk2_g;

assign sk2_p[8]  = sk1_p[8];
assign sk2_g[8]  = sk1_g[8];
assign sk2_p[9]  = sk1_p[9];
assign sk2_g[9]  = sk1_g[9];

assign sk2_p[10] = sk1_p[10] & sk1_p[9];
assign sk2_g[10] = sk1_g[10] | (sk1_p[10] & sk1_g[9]);

assign sk2_p[11] = sk1_p[11] & sk1_p[9];
assign sk2_g[11] = sk1_g[11] | (sk1_p[11] & sk1_g[9]);

assign sk2_p[12] = sk1_p[12];
assign sk2_g[12] = sk1_g[12];

assign sk2_p[13] = sk1_p[13];
assign sk2_g[13] = sk1_g[13];

assign sk2_p[14] = sk1_p[14] & sk1_p[13];
assign sk2_g[14] = sk1_g[14] | (sk1_p[14] & sk1_g[13]);

assign sk2_p[15] = sk1_p[15] & sk1_p[13];
assign sk2_g[15] = sk1_g[15] | (sk1_p[15] & sk1_g[13]);

assign sk2_p[16] = sk1_p[16];
assign sk2_g[16] = sk1_g[16];

assign sk2_p[17] = sk1_p[17];
assign sk2_g[17] = sk1_g[17];

assign sk2_p[18] = sk1_p[18] & sk1_p[17];
assign sk2_g[18] = sk1_g[18] | (sk1_p[18] & sk1_g[17]);

assign sk2_p[19] = sk1_p[19] & sk1_p[17];
assign sk2_g[19] = sk1_g[19] | (sk1_p[19] & sk1_g[17]);

//------------- STAGE-3 (distance 4, node at 12)
wire [19:8] sk3_p, sk3_g;

assign sk3_p[8]  = sk2_p[8];
assign sk3_g[8]  = sk2_g[8];
assign sk3_p[9]  = sk2_p[9];
assign sk3_g[9]  = sk2_g[9];
assign sk3_p[10] = sk2_p[10];
assign sk3_g[10] = sk2_g[10];
assign sk3_p[11] = sk2_p[11];
assign sk3_g[11] = sk2_g[11];

assign sk3_p[12] = sk2_p[12] & sk2_p[11];
assign sk3_g[12] = sk2_g[12] | (sk2_p[12] & sk2_g[11]);

assign sk3_p[13] = sk2_p[13] & sk2_p[11];
assign sk3_g[13] = sk2_g[13] | (sk2_p[13] & sk2_g[11]);

assign sk3_p[14] = sk2_p[14] & sk2_p[11];
assign sk3_g[14] = sk2_g[14] | (sk2_p[14] & sk2_g[11]);

assign sk3_p[15] = sk2_p[15] & sk2_p[11];
assign sk3_g[15] = sk2_g[15] | (sk2_p[15] & sk2_g[11]);

assign sk3_p[16] = sk2_p[16];
assign sk3_g[16] = sk2_g[16];
assign sk3_p[17] = sk2_p[17];
assign sk3_g[17] = sk2_g[17];
assign sk3_p[18] = sk2_p[18];
assign sk3_g[18] = sk2_g[18];
assign sk3_p[19] = sk2_p[19];
assign sk3_g[19] = sk2_g[19];

//------------- STAGE-4 (distance 8, nodes at 16–19)
wire [19:8] sk4_p, sk4_g;

assign sk4_p[8]  = sk3_p[8];
assign sk4_g[8]  = sk3_g[8];
assign sk4_p[9]  = sk3_p[9];
assign sk4_g[9]  = sk3_g[9];
assign sk4_p[10] = sk3_p[10];
assign sk4_g[10] = sk3_g[10];
assign sk4_p[11] = sk3_p[11];
assign sk4_g[11] = sk3_g[11];
assign sk4_p[12] = sk3_p[12];
assign sk4_g[12] = sk3_g[12];
assign sk4_p[13] = sk3_p[13];
assign sk4_g[13] = sk3_g[13];
assign sk4_p[14] = sk3_p[14];
assign sk4_g[14] = sk3_g[14];
assign sk4_p[15] = sk3_p[15];
assign sk4_g[15] = sk3_g[15];

assign sk4_p[16] = sk3_p[16] & sk3_p[15];
assign sk4_g[16] = sk3_g[16] | (sk3_p[16] & sk3_g[15]);

assign sk4_p[17] = sk3_p[17] & sk3_p[15];
assign sk4_g[17] = sk3_g[17] | (sk3_p[17] & sk3_g[15]);

assign sk4_p[18] = sk3_p[18] & sk3_p[15];
assign sk4_g[18] = sk3_g[18] | (sk3_p[18] & sk3_g[15]);

assign sk4_p[19] = sk3_p[19] & sk3_p[15];
assign sk4_g[19] = sk3_g[19] | (sk3_p[19] & sk3_g[15]);

// carries for bits 8–19
assign C[8]  = sk4_g[8];
assign C[9]  = sk4_g[9];
assign C[10] = sk4_g[10];
assign C[11] = sk4_g[11];
assign C[12] = sk4_g[12];
assign C[13] = sk4_g[13];
assign C[14] = sk4_g[14];
assign C[15] = sk4_g[15];
assign C[16] = sk4_g[16];
assign C[17] = sk4_g[17];
assign C[18] = sk4_g[18];
assign C[19] = sk4_g[19];

wire C19 = sk4_g[19];  // carry into Knowles section

//============================================================
//  PART 2 : 12-bit KNOWLES on bits 20–31 (cin = C19)
//============================================================

//------------- STAGE-1 (distance 1, dense chain 20–31)
wire [31:20] kn1_p, kn1_g;

assign kn1_p[20] = p[20];
assign kn1_g[20] = g[20] | (p[20] & C19);  // include C19

assign kn1_p[21] = p[21] & p[20];
assign kn1_g[21] = g[21] | (p[21] & g[20]);

assign kn1_p[22] = p[22] & p[21];
assign kn1_g[22] = g[22] | (p[22] & g[21]);

assign kn1_p[23] = p[23] & p[22];
assign kn1_g[23] = g[23] | (p[23] & g[22]);

assign kn1_p[24] = p[24] & p[23];
assign kn1_g[24] = g[24] | (p[24] & g[23]);

assign kn1_p[25] = p[25] & p[24];
assign kn1_g[25] = g[25] | (p[25] & g[24]);

assign kn1_p[26] = p[26] & p[25];
assign kn1_g[26] = g[26] | (p[26] & g[25]);

assign kn1_p[27] = p[27] & p[26];
assign kn1_g[27] = g[27] | (p[27] & g[26]);

assign kn1_p[28] = p[28] & p[27];
assign kn1_g[28] = g[28] | (p[28] & g[27]);

assign kn1_p[29] = p[29] & p[28];
assign kn1_g[29] = g[29] | (p[29] & g[28]);

assign kn1_p[30] = p[30] & p[29];
assign kn1_g[30] = g[30] | (p[30] & g[29]);

assign kn1_p[31] = p[31] & p[30];
assign kn1_g[31] = g[31] | (p[31] & g[30]);

//------------- STAGE-2 (distance 2, nodes 22–31)
wire [31:20] kn2_p, kn2_g;

assign kn2_p[20] = kn1_p[20];
assign kn2_g[20] = kn1_g[20];

assign kn2_p[21] = kn1_p[21];
assign kn2_g[21] = kn1_g[21];

assign kn2_p[22] = kn1_p[22] & kn1_p[20];
assign kn2_g[22] = kn1_g[22] | (kn1_p[22] & kn1_g[20]);

assign kn2_p[23] = kn1_p[23] & kn1_p[21];
assign kn2_g[23] = kn1_g[23] | (kn1_p[23] & kn1_g[21]);

assign kn2_p[24] = kn1_p[24] & kn1_p[22];
assign kn2_g[24] = kn1_g[24] | (kn1_p[24] & kn1_g[22]);

assign kn2_p[25] = kn1_p[25] & kn1_p[23];
assign kn2_g[25] = kn1_g[25] | (kn1_p[25] & kn1_g[23]);

assign kn2_p[26] = kn1_p[26] & kn1_p[24];
assign kn2_g[26] = kn1_g[26] | (kn1_p[26] & kn1_g[24]);

assign kn2_p[27] = kn1_p[27] & kn1_p[25];
assign kn2_g[27] = kn1_g[27] | (kn1_p[27] & kn1_g[25]);

assign kn2_p[28] = kn1_p[28] & kn1_p[26];
assign kn2_g[28] = kn1_g[28] | (kn1_p[28] & kn1_g[26]);

assign kn2_p[29] = kn1_p[29] & kn1_p[27];
assign kn2_g[29] = kn1_g[29] | (kn1_p[29] & kn1_g[27]);

assign kn2_p[30] = kn1_p[30] & kn1_p[28];
assign kn2_g[30] = kn1_g[30] | (kn1_p[30] & kn1_g[28]);

assign kn2_p[31] = kn1_p[31] & kn1_p[29];
assign kn2_g[31] = kn1_g[31] | (kn1_p[31] & kn1_g[29]);

//------------- STAGE-3 (distance 4, nodes 24–31)
wire [31:20] kn3_p, kn3_g;

assign kn3_p[20] = kn2_p[20];
assign kn3_g[20] = kn2_g[20];
assign kn3_p[21] = kn2_p[21];
assign kn3_g[21] = kn2_g[21];
assign kn3_p[22] = kn2_p[22];
assign kn3_g[22] = kn2_g[22];
assign kn3_p[23] = kn2_p[23];
assign kn3_g[23] = kn2_g[23];

assign kn3_p[24] = kn2_p[24] & kn2_p[20];
assign kn3_g[24] = kn2_g[24] | (kn2_p[24] & kn2_g[20]);

assign kn3_p[25] = kn2_p[25] & kn2_p[21];
assign kn3_g[25] = kn2_g[25] | (kn2_p[25] & kn2_g[21]);

assign kn3_p[26] = kn2_p[26] & kn2_p[22];
assign kn3_g[26] = kn2_g[26] | (kn2_p[26] & kn2_g[22]);

assign kn3_p[27] = kn2_p[27] & kn2_p[23];
assign kn3_g[27] = kn2_g[27] | (kn2_p[27] & kn2_g[23]);

assign kn3_p[28] = kn2_p[28] & kn2_p[24];
assign kn3_g[28] = kn2_g[28] | (kn2_p[28] & kn2_g[24]);

assign kn3_p[29] = kn2_p[29] & kn2_p[25];
assign kn3_g[29] = kn2_g[29] | (kn2_p[29] & kn2_g[25]);

assign kn3_p[30] = kn2_p[30] & kn2_p[26];
assign kn3_g[30] = kn2_g[30] | (kn2_p[30] & kn2_g[26]);

assign kn3_p[31] = kn2_p[31] & kn2_p[27];
assign kn3_g[31] = kn2_g[31] | (kn2_p[31] & kn2_g[27]);

//------------- STAGE-4 (distance 8, nodes 28–31)
wire [31:20] kn4_p, kn4_g;

assign kn4_p[20] = kn3_p[20];
assign kn4_g[20] = kn3_g[20];
assign kn4_p[21] = kn3_p[21];
assign kn4_g[21] = kn3_g[21];
assign kn4_p[22] = kn3_p[22];
assign kn4_g[22] = kn3_g[22];
assign kn4_p[23] = kn3_p[23];
assign kn4_g[23] = kn3_g[23];
assign kn4_p[24] = kn3_p[24];
assign kn4_g[24] = kn3_g[24];
assign kn4_p[25] = kn3_p[25];
assign kn4_g[25] = kn3_g[25];
assign kn4_p[26] = kn3_p[26];
assign kn4_g[26] = kn3_g[26];
assign kn4_p[27] = kn3_p[27];
assign kn4_g[27] = kn3_g[27];

assign kn4_p[28] = kn3_p[28] & kn3_p[20];
assign kn4_g[28] = kn3_g[28] | (kn3_p[28] & kn3_g[20]);

assign kn4_p[29] = kn3_p[29] & kn3_p[21];
assign kn4_g[29] = kn3_g[29] | (kn3_p[29] & kn3_g[21]);

assign kn4_p[30] = kn3_p[30] & kn3_p[22];
assign kn4_g[30] = kn3_g[30] | (kn3_p[30] & kn3_g[22]);

assign kn4_p[31] = kn3_p[31] & kn3_p[23];
assign kn4_g[31] = kn3_g[31] | (kn3_p[31] & kn3_g[23]);

// carries 20–31
assign C[20] = kn4_g[20];
assign C[21] = kn4_g[21];
assign C[22] = kn4_g[22];
assign C[23] = kn4_g[23];
assign C[24] = kn4_g[24];
assign C[25] = kn4_g[25];
assign C[26] = kn4_g[26];
assign C[27] = kn4_g[27];
assign C[28] = kn4_g[28];
assign C[29] = kn4_g[29];
assign C[30] = kn4_g[30];
assign C[31] = kn4_g[31];

assign cout = kn4_g[31];

//============================================================
//  FINAL SUMS
//============================================================

// approximate sums 0–7 (OR)
assign s[0] = p0[0] | C[0];
assign s[1] = p0[1] | C[1];
assign s[2] = p0[2] | C[2];
assign s[3] = p0[3] | C[3];
assign s[4] = p0[4] | C[4];
assign s[5] = p0[5] | C[5];
assign s[6] = p0[6] | C[6];
assign s[7] = p0[7] | C[7];

// exact sums 8–31
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
