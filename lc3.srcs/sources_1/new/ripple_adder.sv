
module full_adder(
    input x,
    input y,
    input cin,
    output logic s,
    output logic cout
);
    assign s = x ^ y ^ cin;
    assign cout = (x & y) | (y & cin) | (cin & x);
endmodule



module four_bit_ra(
    input [3:0] x,
    input [3:0] y,
    input cin,
    output logic [3:0] s,
    output logic cout);
    logic c0,c1,c2;
    
    
    full_adder fa0(.x(x[0]), .y(y[0]), .cin(cin), .s(s[0]), .cout(c0));
    full_adder fa1(.x(x[1]), .y(y[1]), .cin(c0),  .s(s[1]), .cout(c1));
    full_adder fa2(.x(x[2]), .y(y[2]), .cin(c1),  .s(s[2]), .cout(c2));
    full_adder fa3(.x(x[3]), .y(y[3]), .cin(c2),  .s(s[3]), .cout(cout));
    
endmodule

module ripple_adder (
    input  logic  [15:0] a, 
    input  logic  [15:0] b,
    input  logic         cin,
    
    output logic  [15:0] s,
    output logic         cout
);

    /* TODO
        *
        * Insert code here to implement a ripple adder.
        * Your code should be completly combinational (don't use always_ff or always_latch).
        * Feel free to create sub-modules or other files. */
        logic C0,C1,C2;
        four_bit_ra FRA0(.x(a[3:0]), .y(b[3:0]), .cin(0), .s(s[3:0]), .cout(C0));
        four_bit_ra FRA1(.x(a[7:4]), .y(b[7:4]), .cin(C0), .s(s[7:4]), .cout(C1));
        four_bit_ra FRA2(.x(a[11:8]), .y(b[11:8]), .cin(C1), .s(s[11:8]), .cout(C2));
        four_bit_ra FRA3(.x(a[15:12]), .y(b[15:12]), .cin(C2), .s(s[15:12]), .cout(cout));
endmodule


//module full_adder (
//    input logic a,
//    input logic b,
//    input logic cin,
//    output logic s,
//    output logic cout
//);

//    assign s = (a ^ b) ^ cin;
//    assign cout = (a & b) | (cin & (a ^ b));
    
//endmodule


//module CRA_4bit (
//	input  logic  [3:0] a, 
//    input  logic  [3:0] b,
//	input  logic         cin,
	
//	output logic  [3:0] s,
//	output logic         cout
//);
//	/* TODO
//		*
//		* Insert code here to implement a ripple adder.
//		* Your code should be completly combinational (don't use always_ff or always_latch).
//		* Feel free to create sub-modules or other files. */
		
//		logic c0, c1, c2;
//		full_adder(.a(a[0]), .b(b[0]), .cin(cin), .s(s[0]), .c0(cout));
//  		full_adder(.a(a[1]), .b(b[1]), .cin(c0), .s(s[1]), .c1(cout));
//		full_adder(.a(a[2]), .b(b[2]), .cin(c1), .s(s[2]), .c2(cout));
//		full_adder(.a(a[3]), .b(b[3]), .cin(c2), .s(s[3]), .cout(cout));

//endmodule


//module ripple_adder (
//	input  logic  [15:0] a, 
//    input  logic  [15:0] b,
//	input  logic         cin,
	
//	output logic  [15:0] s,
//	output logic         cout
//);
//	/* TODO
//		*
//		* Insert code here to implement a ripple adder.
//		* Your code should be completly combinational (don't use always_ff or always_latch).
//		* Feel free to create sub-modules or other files. */
//    logic c0, c1, c2;
//    CRA_4bit (.a(a[3:0]), .b(b[3:0]), .cin(cin), .s(s[3:0]), .c0(cout));
//    CRA_4bit(.a(a[7:4]), .b(b[7:4]), .cin(c0), .s(s[7:4]), .c1(cout));
//    CRA_4bit(.a(a[11:8]), .b(b[11:8]), .cin(c1), .s(s[11:8]), .c2(cout));
//    CRA_4bit(.a(a[15:12]), .b(b[15:12]), .cin(c2), .s(s[15:12]), .cout(cout));
//endmodule
