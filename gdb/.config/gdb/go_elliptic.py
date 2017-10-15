#!/usr/bin/env python

def print_value(name, value):
	printf "%7s %16lx" % (name, value)

defile values():
	print_value("acc0", 




define values
     printf "acc0  %16lx   acc1  %16lx   acc2  %16lx   acc3  %16lx\n", $r7, $r8, $r9, $r10
     printf "acc4  %16lx   acc5  %16lx   acc6  %16lx   acc7  %16lx\n", $r22, $r23, $r5, $r6
     printf "a_ptr %16lx   b_ptr %16lx   res_ptr %16lx\n", $r4, $r5, $r3
     printf "a0    %16lx   a1    %16lx   a2    %16lx   a3    %16lx\n", $r24, $r25, $r26, $r27
     printf "t0    %16lx   t1    %16lx   t2    %16lx   t3    %16lx\n", $r28, $r29, $r2, $r31
     printf "bi    %16lx   idx   %16lx   poly1 %16lx   poly3 %16lx\n", $r6, $r5, $r11, $r12
 end


