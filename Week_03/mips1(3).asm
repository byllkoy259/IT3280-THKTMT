.data
.text
main:
li $s1,4 # i=4
li $s2,5 # j=5
li $t1,1 # x=1
li $t2,2 # y=2
li $t3,3 # z=3
slt $t0,$s2,$s1 # j<i
bne $t0,$zero,else # branch to else if j<i
addi $t1,$t1,1 # then part: x=x+1
addi $t3,$zero,1 # z=1
j endif # skip “else” part
else: 
addi $t2,$t2,-1 # begin else part: y=y-1
add $t3,$t3,$t3 # z=2*z
endif:
