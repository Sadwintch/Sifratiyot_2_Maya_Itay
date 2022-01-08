# Operands to multiply
.data
a: .word 0xBAD
b: .word 0xFEED

.text
main:   # Load data from memory
		la      t3, a
        lw      t3, 0(t3)
        la      t4, b
        lw      t4, 0(t4)
        
        # t6 will contain the result
        add		t6, x0, x0

        # Mask for 16x8=24 multiply
        ori		t0, x0, 0xff
        slli	t0, t0, 8
        ori		t0, t0, 0xff
        slli	t0, t0, 8
        ori		t0, t0, 0xff
        
####################
# Start of your code

# Use the code below for 16x8 multiplication
#   mul		<PROD>, <FACTOR1>, <FACTOR2>
#   and		<PROD>, <PROD>, t0

		
		ori		t1, x0, 0x00ff	# t1 is mask for lower 8 bits
		and		t2, t3, t1	
		mul		t6, t4, t2	#multiplying b and lower half of a, adding result to t6
		and		t6, t6, t0
		
		slli	t1, t1, 8	# t1 is now mask for upper 8 bits
		and		t2, t3,	t1	
        srli	t2, t2, 8
		mul		t5, t4, t2	#multiplying b and upper half of a
		and		t5, t5, t0	
        slli 	t5, t5, 8
		add		t6, t6, t5	#adding result to t6
		
					


	

# End of your code
####################
		
finish: addi    a0, x0, 1
        addi    a1, t6, 0
        ecall # print integer ecall
        addi    a0, x0, 10
        ecall # terminate ecall