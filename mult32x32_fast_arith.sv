// 32X32 Multiplier arithmetic unit template
module mult32x32_fast_arith (
    input logic clk,             // Clock
    input logic reset,           // Reset
    input logic [31:0] a,        // Input a
    input logic [31:0] b,        // Input b
    input logic a_sel,           // Select one 2-byte word from A
    input logic b_sel,           // Select one 2-byte word from B
    input logic [1:0] shift_sel, // Select output from shifters
    input logic upd_prod,        // Update the product register
    input logic clr_prod,        // Clear the product register
    output logic a_msw_is_0,     // Indicates MSW of operand A is 0
    output logic b_msw_is_0,     // Indicates MSW of operand B is 0
    output logic [63:0] product  // Miltiplication product
);

	mult32x32_arith arith
	(
		.clk(clk),
		.reset(reset),
		.a(a),
		.b(b),
		.a_sel(a_sel),
		.b_sel(b_sel),
		.shift_sel(shift_sel),
		.upd_prod(upd_prod),
		.clr_prod(clr_prod),
		.product(product)
	);

	always_comb begin
		a_msw_is_0 = 1'b0;
		b_msw_is_0 = 1'b0;
		if(a[31:16] == 16'b0) begin
			a_msw_is_0 = 1'b1;
		end
		if(b[31:16] == 16'b0) begin
			b_msw_is_0 = 1'b1;
		end
	end
endmodule
