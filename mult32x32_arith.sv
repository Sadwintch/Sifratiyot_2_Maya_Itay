// 32X32 Multiplier arithmetic unit template
module mult32x32_arith (
    input logic clk,             // Clock
    input logic reset,           // Reset
    input logic [31:0] a,        // Input a
    input logic [31:0] b,        // Input b
    input logic a_sel,           // Select one 2-byte word from A
    input logic b_sel,           // Select one 2-byte word from B
    input logic [1:0] shift_sel, // Select output from shifters
    input logic upd_prod,        // Update the product register
    input logic clr_prod,        // Clear the product register
    output logic [63:0] product  // Miltiplication product
);

	logic unsigned [15:0] a_out;
	logic unsigned [15:0] b_out;
	logic unsigned [31:0] mul_out_32;
	logic unsigned [63:0] mul_32_to_64;
	logic unsigned [63:0] shift_out;
	logic unsigned [63:0] add_out;

	always_ff @(posedge clk, posedge reset) begin
		if (reset == 1'b1) begin
			product <= 64'b0;
		end
		else begin
		if (clr_prod==1'b1) begin
			product <= 64'b0;
		end
		else if (upd_prod==1'b1) begin
			product <= add_out;
		end
		end
    end

	always_comb begin
		case(a_sel)
			1'b1: a_out = a[15:0];
			1'b0: a_out = a[31:16];
		endcase
		case(b_sel)
			1'b1: b_out = b[15:0];
			1'b0: b_out = b[31:16];
		endcase
		
		mul_out_32 = a_out*b_out;
		mul_32_to_64 = {32'b0, mul_out_32};
		
		case(shift_sel)
			2'b00: shift_out = mul_32_to_64;
			2'b01: shift_out = mul_32_to_64 << 16;
			2'b10: shift_out = mul_32_to_64 << 32;
			2'b11: shift_out = 64'b0;
		endcase
		
		add_out = product + shift_out;
	end

endmodule
