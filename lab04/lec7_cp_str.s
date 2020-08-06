# copy string p to q
# p -> s0, q -> s1 (char* pointers)
Loop: 	lb		t0, 0(s0)		# t0 = *p
		sb		t0, 0(s1)		# *q = t0
		addi 	s0, s0, 1		# p = p + 1
		addi 	s1, s1, 1		# q = q + 1
		beq		t0, x0, Exit	# if *p == 0, go to Exit
		j		Loop			# go to Loop
Exit:
