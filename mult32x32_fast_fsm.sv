// 32X32 Multiplier FSM
module mult32x32_fast_fsm (
    input logic clk,              // Clock
    input logic reset,            // Reset
    input logic start,            // Start signal
    input logic a_msw_is_0,       // Indicates MSW of operand A is 0
    input logic b_msw_is_0,       // Indicates MSW of operand B is 0
    output logic busy,            // Multiplier busy indication
    output logic a_sel,           // Select one 2-byte word from A
    output logic b_sel,           // Select one 2-byte word from B
    output logic [1:0] shift_sel, // Select output from shifters
    output logic upd_prod,        // Update the product register
    output logic clr_prod         // Clear the product register
);

typedef enum 
	{
		A,
		B,
		C,
		D,
		E	
	} sm_type;
	sm_type current_state;
	sm_type next_state;

	always_ff @(posedge clk, posedge reset) begin
		if (reset == 1'b1) begin
			current_state <= A;
		end
		else begin
			current_state <= next_state;
		end
	end
	
	always_comb begin
	//Here are the defualts values:
		next_state = current_state;
		busy = 1'b1;
		upd_prod = 1'b1;
		clr_prod = 1'b0;
	
		case(current_state)
			A: begin
				if(start == 1'b0) begin
					busy = 1'b0;
					upd_prod = 1'b0;
				end
				else begin
					next_state = B;
					a_sel = 1'b1;
					b_sel = 1'b1;
					shift_sel = 2'b00;
					clr_prod = 1'b1;
				end
			end
			B: begin
				if((a_msw_is_0==1'b0) && (b_msw_is_0==1'b0)) begin
						next_state = C;
						a_sel = 1'b0;
						b_sel = 1'b1;
						shift_sel = 2'b01;
				end
				else begin	
					next_state = A;
					upd_prod = 1'b1;
				end
			end
			C: begin
				next_state = D;
				a_sel = 1'b1;
				b_sel = 1'b0;
				shift_sel = 2'b01;
			end
			D: begin
				next_state = E;
				a_sel = 1'b0;
				b_sel = 1'b0;
				shift_sel = 2'b10;
			end
			E: begin
				next_state = A;
				upd_prod = 1'b0;
			end
		endcase
	end
// ------------------


// End of your code

endmodule
