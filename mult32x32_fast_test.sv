// 32X32 Multiplier test template
module mult32x32_fast_test;

    logic clk;            // Clock
    logic reset;          // Reset
    logic start;          // Start signal
    logic [31:0] a;       // Input a
    logic [31:0] b;       // Input b
    logic busy;           // Multiplier busy indication
    logic [63:0] product; // Miltiplication product


	mult32x32_fast mult_inst(
		.clk(clk),
		.reset(reset),
		.start(start),
		.a(a),
		.b(b),
		.busy(busy),
		.product(product)
	);

	initial begin
		clk = 1'b1;
		reset = 1'b1;
		start = 1'b0;
		a = 0;
		b = 0;
		#40
		reset = 1'b0;
		#10
		a = 205961014;
		b = 318947199;
		start = 1'b1;
		#10
		start = 1'b0;
		#50
		a = ((205961014) << 16) >> 16; 
		b = ((318947199) << 16) >> 16;
		start = 1'b1;
		#10
		start = 1'b0;
		#10;
	end
	
	always begin
	#5
	clk = ~clk;
	end

endmodule
