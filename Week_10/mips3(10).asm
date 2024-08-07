.eqv  HEADING    0xffff8010    	# Integer: An angle between 0 and 359
				# 0 : North (up)
				# 90: East (right)
				# 180: South (down)
				# 270: West  (left)
.eqv  MOVING     0xffff8050   	# Boolean: whether or not to move
.eqv  LEAVETRACK 0xffff8020    	# Boolean (0 or non-0):
				# whether or not to leave a track
.eqv  WHEREX     0xffff8030    	# Integer: Current x-location of MarsBot
.eqv  WHEREY     0xffff8040    	# Integer: Current y-location of MarsBot

.text
main:  
	addi $a0, $zero, 135 # Marsbot rotates 135* and start running
	jal ROTATE
	nop
	jal GO
	nop
	
sleep1: addi $v0, $zero, 32 # Keep running by sleeping in 5000 ms
	li $a0, 5000        
	syscall
	jal TRACK # And draw new track line
	
edge1: addi $a0, $zero, 150 # Marsbot rotates 150*
	jal ROTATE
	
sleep2: addi $v0, $zero, 32 # Keep running by sleeping in 5000 ms
	li $a0, 5000        
	syscall
	jal UNTRACK # Keep old track
	nop
	jal TRACK # And draw new track line
	nop
	
edge2: addi $a0, $zero, 270 # Marsbot rotates 270*  
	jal ROTATE
	
sleep3: addi $v0, $zero, 32 # Keep running by sleeping in 5000 ms
	li $a0, 5000        
	syscall
	jal UNTRACK # Keep old track
	nop
	jal TRACK # And draw new track line
	nop
	
edge3:  addi $a0, $zero, 30 # Marsbot rotates 30*  
	jal ROTATE    
	
sleep4: addi $v0, $zero, 32 # Keep running by sleeping in 5000 ms
	li $a0, 5000       
 	syscall    
 	jal UNTRACK # Keep old track
	jal STOP

exit:
	li $v0, 10
	syscall
	
end_main:
#-----------------------------------------------------------
# GO procedure, to start running
# param[in]    none
#-----------------------------------------------------------
GO:     li    	$at, MOVING     # change MOVING port
	addi  	$k0, $zero,1    # to  logic 1,
	sb    	$k0, 0($at)     # to start running
	jr    	$ra
#-----------------------------------------------------------
# STOP procedure, to stop running
# param[in]    none
#-----------------------------------------------------------
STOP:   li    	$at, MOVING     # change MOVING port to 0
	sb   	$zero, 0($at)   # to stop
	jr    	$ra
#-----------------------------------------------------------
# TRACK procedure, to start drawing line 
# param[in]    none
#-----------------------------------------------------------
TRACK:  li    	$at, LEAVETRACK # change LEAVETRACK port
	addi  	$k0, $zero,1    # to  logic 1,
	sb    	$k0, 0($at)     # to start tracking
	jr    	$ra
#-----------------------------------------------------------
# UNTRACK procedure, to stop drawing line
# param[in]    none
#-----------------------------------------------------------
UNTRACK:li    	$at, LEAVETRACK # change LEAVETRACK port to 0
	sb    	$zero, 0($at)   # to stop drawing tail
	jr    	$ra
#-----------------------------------------------------------
# ROTATE procedure, to rotate the robot
# param[in]    $a0, An angle between 0 and 359
#                   0 : North (up)
#                   90: East  (right)
#                  180: South (down)
#                  270: West  (left)
#-----------------------------------------------------------
ROTATE: li    	$at, HEADING    # change HEADING port
	sw    	$a0, 0($at)     # to rotate robot
	jr   	$ra
