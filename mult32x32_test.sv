// 32X32 Multiplier test template
module mult32x32_test;

    logic clk;            // Clock
    logic reset;          // Reset
    logic start;          // Start signal
    logic [31:0] a;       // Input a
    logic [31:0] b;       // Input b
    logic busy;           // Multiplier busy indication
    logic [63:0] product; // Miltiplication product

	mult32x32 mult_inst(
		.clk(clk),
		.reset(reset),
		.start(start),
		.a(a),
		.b(b),
		.busy(busy),
		.product(product)
	);
//how much time is 1 unit of time? i just entered 5 as 1 unit of time due to our diagrama...
	initial begin
		clk = 1'b1;
		reset = 1'b1;
		start = 1'b0;
		a = 0;
		b = 0;
		#8
		reset = 1'b0;
		#2
		a = 32'hC46B736;
		b = 32'h1302BF7F;
		start = 1'b1;
		#2
		start = 1'b0;
		#10;
	end
	
	always begin
		#2
		clk = ~clk;
	end

endmodule

