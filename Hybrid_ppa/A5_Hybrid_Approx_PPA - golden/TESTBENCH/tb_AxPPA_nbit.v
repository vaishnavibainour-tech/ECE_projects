`include "../RTL/define.vh"
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Praveen Bohra
// Create Date:    
// Design Name: 
// Module Name:    tb_AxPPA_nbit 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description:    Test Bench Exact Majority Logic Full Adder
// Dependencies: 
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module tb_AxPPA_nbit;

reg [`N-1:0]	A,B;

wire [`N-1:0]   SUM;
wire            COUT;
reg             reset;

// Local parameter
localparam  [`N-1:0] test_upper_limit =  {`N{1'b1}};

// Instantiate the majority Logic full adder module
`ifdef Mod_App_Sklansky
		Mod_Approx_Sklansky32 MOD_AxPP_SLK(
`elsif Mod_App_Knowles	
		Mod_Approx_Knowles32 MOD_AxPP_KNW(
`elsif Hybrid_Approx_PPA1	
		Hybrid_Approx_PPA1_32 Hybrid_Approx_PPA1(
`elsif 	Hybrid_Approx_PPA2
		Hybrid_Approx_PPA2_32 Hybrid_Approx_PPA2(
`endif	
				.a		(A), 
				.b		(B),
				.s   	(SUM),
				.cout	(COUT) 
			    );
						
// Clock generation (for testbench purposes)
reg clk = 0;
always #5 clk = ~clk;


integer seed;
initial
	seed  = $random;
	
always @(posedge clk)
begin
	if(reset) begin
		A   = 0; 
        B   = 0; 
	end
	else begin
		A   = $urandom; 
        B   = $urandom; 
    end
end

wire [`N:0] result,golden_result;
assign result[`N:0]        = {COUT,SUM};
assign golden_result[`N:0] = (A + B);

// Calculating Diffrence
reg [`N:0] difference; 
always @(*)
begin
  if (result > golden_result)
    difference     = result - golden_result;
  else  
    difference     = golden_result - result;
end      

// Testbench stimulus
integer f,g,h;
initial begin
	reset = 1'b1;
	repeat (2) @ (posedge clk);
	reset = 1'b0;
	
      f = $fopen(`output_file_name);
      g = $fopen(`golden_file_name);
      h = $fopen(`diffrence_file_name);
	  
repeat (100000) @ (posedge clk) begin
	  $fwrite(h," %0d \n",$unsigned(difference));
      $fwrite(g," %0d \n",$unsigned(golden_result));
      $fwrite(f," %0d  %0d = %0d \n",$unsigned(A),$unsigned(B),$unsigned(result));
end

$fclose(f);  
$fclose(g);
$fclose(h);

#10 $stop;
end


reg [31:0] bit_diff;
integer i;

always @(*) begin
    bit_diff = SUM ^ golden_result[31:0];  
end

endmodule //tb_AxPPA_nbit
