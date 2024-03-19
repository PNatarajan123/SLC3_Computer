



module nzpbranch(
	input logic reset, 
	input logic clk,
	input logic [15:0] ir, 
	input logic [15:0] Bus,
	input logic Ld_ben, 
	input logic ld_cc, 
	
	output logic Ben
	);

	// high level 
	// nzp register to store nzp values, local ben signal, update ben on ld signal
	// alwayscomb for updating nzp based on bus 
	// alwaysff for updating ben based on ld signal
			
// module branch(
//     input clk,
//     input logic [2:0] nzp_vals, 
//     input logic [2:0] ir,
//     input logic ld_ben,
//     output logic ben
// );

// TODO: UPDATE LOGIC for bus  
//     always_ff @(posedge clk) begin
//         if (ld_ben) begin
//             ben <= (nzp_vals & ir) ? 1'b1 : 1'b0; 
//         end
	// if (Bus[15] == 1'b1) begin N = 1'b1; Z = 1'b0; P = 1'b0; end
	// 	else if(Bus == 16'h0000) begin N = 1'b0; Z = 1'b1; P = 1'b0; end
	// 	else if(Bus[15] == 1'b0 && Bus != 16'h0000) begin N = 1'b0; Z = 1'b0; P = 1'b1; end
//     end
// endmodule		  	
	
	logic [2:0] nzp, Dr;
	assign Dr = ir[11:9];

	logic N, Z, P, Br_in;
	
	// combinational logic for nzp vals, needs to be done live 
	always_comb begin // FIXME: TIMINGLOOP error
		// logic for nzp vals
		if (Bus[15] == 1'b1) begin N = 1'b1; Z = 1'b0; P = 1'b0; end
		else if(Bus == 16'h0000) begin N = 1'b0; Z = 1'b1; P = 1'b0; end
		else if(Bus[15] == 1'b0 && Bus != 16'h0000) begin N = 1'b0; Z = 1'b0; P = 1'b1; end
		// default case to stop latch
		else begin N = 1'b0; Z = 1'b0; P = 1'b0; end // TODO: check if this is needed inferred latch???
		Br_in = ((nzp[0] & Dr[0]) | (nzp[1] & Dr[1]) | (nzp[2] & Dr[2])); // assign local signal to branch signal, updates as vals change
	end
	
	




	// module branch(
//     input clk,
//     input logic [2:0] nzp_vals, 
//     input logic [11:9] ir,
//     input logic ld_ben,
//     output logic ben
//     );

//     always_ff @(posedge clk) begin
//         if (ld_ben) begin
//             if (nzp_vals == ir) begin
//                 ben <= 1'b1;
//             end else begin
//                 ben <= 1'b0;
//             end
//         end
//     end
// endmodule

	// sequential logic for ben based on ld signal
	always_ff @ (posedge clk) begin
		
		if(reset) begin nzp <= 3'b000; Ben <= 16'h0000; end	
		else if(Ld_ben) begin Ben <= Br_in; end	// load ben with branch signal
		if(ld_cc) begin nzp[1] <= Z; nzp[2] <= N; nzp[0] <= P; end
	end

endmodule 