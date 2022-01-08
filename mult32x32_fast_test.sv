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
		#20
		reset = 1'b0;
		#5
		a = 205961014;
		b = 318947199;
		start = 1'b1;
		#5
		start = 1'b0;
		//waiting for busy come down...?
		#5
		a = (205961014) >> 8; //can i do it?
		b = (318947199) >> 8;
		start = 1'b1;
		#5
		start = 1'b0;
		//wating for busy to do down?
	end
	
	always begin
	#5
	clk = ~clk;
	end

endmodule
