boolean isScreenConcave() {
  a0 = load(0x134DA8) // current screen

  for(int v1 = 0; v1 < 18; v1++) {
    v0 = load(0x12BB20 + v1)
    
    if(a0 == v0)
      return 1
  }

  return 0
}

0x000e7484 lbu a0,-0x6d84(gp)
0x000e7488 beq r0,r0,0x000e74b8
0x000e748c addu v1,r0,r0
0x000e7490 lui v0,0x8013
0x000e7494 addiu v0,v0,0xbb20
0x000e7498 addu v0,v0,v1
0x000e749c lbu v0,0x0000(v0)
0x000e74a0 nop
0x000e74a4 bne a0,v0,0x000e74b4
0x000e74a8 nop
0x000e74ac beq r0,r0,0x000e74c8
0x000e74b0 addiu v0,r0,0x0001
0x000e74b4 addi v1,v1,0x0001
0x000e74b8 slti asmTemp,v1,0x0012
0x000e74bc bne asmTemp,r0,0x000e7490
0x000e74c0 nop
0x000e74c4 addu v0,r0,r0
0x000e74c8 jr ra
0x000e74cc nop
