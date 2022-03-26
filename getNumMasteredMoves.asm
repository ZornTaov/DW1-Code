int getNumMasteredMoves() {
  masteredMoves = 0
  
  for(i = 0; i < 2; i++) {
    moveData = load(0x155800 + i * 4)
    
    for(j = 0; j < 32; j++)
      if(moveData & 1 << j != 0)
        masteredMoves++
  }
  
  return masteredMoves
}

0x000e3510 addu v0,r0,r0
0x000e3514 addu a0,r0,r0
0x000e3518 beq r0,r0,0x000e3570
0x000e351c addu a3,r0,r0
0x000e3520 lui v1,0x8015
0x000e3524 addiu v1,v1,0x5800
0x000e3528 addu v1,v1,a3
0x000e352c lw a2,0x0000(v1)
0x000e3530 beq r0,r0,0x000e355c
0x000e3534 addu a1,r0,r0
0x000e3538 addiu v1,r0,0x0001
0x000e353c sllv v1,v1,a1
0x000e3540 and v1,a2,v1
0x000e3544 beq v1,r0,0x000e3558
0x000e3548 nop
0x000e354c addi v0,v0,0x0001
0x000e3550 sll v0,v0,0x18
0x000e3554 sra v0,v0,0x18
0x000e3558 addi a1,a1,0x0001
0x000e355c slti asmTemp,a1,0x0020
0x000e3560 bne asmTemp,r0,0x000e3538
0x000e3564 nop
0x000e3568 addi a0,a0,0x0001
0x000e356c addi a3,a3,0x0004
0x000e3570 slti asmTemp,a0,0x0002
0x000e3574 bne asmTemp,r0,0x000e3520
0x000e3578 nop
0x000e357c jr ra
0x000e3580 nop