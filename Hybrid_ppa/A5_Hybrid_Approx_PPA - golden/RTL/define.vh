// Select The Design u want to simulate

//`define Mod_App_Sklansky
//`define Mod_App_Knowles
`define Hybrid_Approx_PPA1
//`define Hybrid_Approx_PPA2


`define N 32

//###############################################
//###### DONT CHANGE BELOW VALUES ###############
//###############################################

//### file names based on above selections ###
`ifdef Mod_App_Sklansky
				`define output_file_name    "./result/output_MODAxPPA_SLK_32.txt"  
				`define golden_file_name    "./result/golden_MODAxPPA_SLK_32.txt"  
				`define diffrence_file_name "./result/diffrence_MODAxPPA_SLK_32.txt" 		   		   
`elsif Mod_App_Knowles
				`define output_file_name    "./result/output_MODAxPPA_KNO_32.txt"  
				`define golden_file_name    "./result/golden_MODAxPPA_KNO_32.txt"  
				`define diffrence_file_name "./result/diffrence_MODAxPPA_KNO_32.txt" 		   		   
`elsif Hybrid_Approx_PPA1
				`define output_file_name    "./result/output_Hybrid_Approx_PPA1.txt"  
				`define golden_file_name    "./result/golden_Hybrid_Approx_PPA1.txt"  
				`define diffrence_file_name "./result/diffrence_Hybrid_Approx_PPA1.txt" 		   
`elsif Hybrid_Approx_PPA2
				`define output_file_name    "./result/output_Hybrid_Approx_PPA2.txt"  
				`define golden_file_name    "./result/golden_Hybrid_Approx_PPA2.txt"  
				`define diffrence_file_name "./result/diffrence_Hybrid_Approx_PPA2.txt" 		   
`endif
 
 //### Instansiate the Design you want to simulate ### 

 `ifdef Mod_App_Sklansky
  `define select_design  Mod_Approx_Sklansky32
 `elsif Mod_App_Knowles
  `define select_design  Mod_Approx_knowles32
 `elsif Hybrid_Approx_PPA1
  `define select_design  Hybrid_Approx_PPA1_32
`elsif Hybrid_Approx_PPA2
  `define select_design  Hybrid_Approx_PPA2_32
 `endif   

