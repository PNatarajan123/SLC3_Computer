module alu(
    input logic [15:0] A, B, // B is sr1, A is sr2
    input logic [1:0] aluk,
    output logic [15:0] R
    );

    always_comb begin
        case (aluk)
            2'b00: R = A + B;
            2'b01: R = A & B;
            2'b10: R = ~A ;
            2'b11: R = A;
            default: R = 16'bX;
        endcase
    end

endmodule
