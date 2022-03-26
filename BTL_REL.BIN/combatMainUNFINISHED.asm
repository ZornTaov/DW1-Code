void combatMain() {
  // defines the center of the area of combat in background image coordinates
  xCenter = 160 - load(0x134EC0) // screen offset X, top left corner of background image
  yCenter = 120 - load(0x134EC4) // screen offset Y, top left corner of background image
  store(0x134D8C, xCenter)
  store(0x134D88, yCenter)
  
  combatInit()
  combatInitEntityPositions()
  
  while(checkCombatEndCondition() == 0) {
    partnerAiTick()
    enemyAiTick()
    0x00058874()
    0x00058AA4()
    battleTickFrame()
    0x000E62D0()
    
    store(0x134D66, load(0x134D66) + 1) // frame count
  }
  
  0x000E642C()
  0x00058C68()
  
  combatHead = load(0x134D4C)
  
  if(load(0x1557F4) == 0) { // HP is 0
    store(combatHead + 0x064E, 0)
    return -1
  }
  
  if(load(combatHead + 0x064E) == 1) { // command is run away
    store(combatHead + 0x064E, 0)
    return 0
  }
  
  return 1
}

0x0005b5f4 addiu sp,sp,0xffe8
0x0005b5f8 lw v0,-0x6c6c(gp)
0x0005b5fc addiu v1,r0,0x00a0
0x0005b600 sub v0,v1,v0
0x0005b604 sw v0,-0x6da0(gp)
0x0005b608 lw v0,-0x6c68(gp)
0x0005b60c addiu v1,r0,0x0078
0x0005b610 sub v0,v1,v0
0x0005b614 sw ra,0x0010(sp)
0x0005b618 sw v0,-0x6da4(gp)
0x0005b61c jal 0x00056ca8
0x0005b620 nop
0x0005b624 jal 0x0005736c
0x0005b628 nop
0x0005b62c jal 0x00057920
0x0005b630 nop
0x0005b634 bne v0,r0,0x0005b680
0x0005b638 nop
0x0005b63c jal 0x00057bd0
0x0005b640 nop
0x0005b644 jal 0x00058394
0x0005b648 nop
0x0005b64c jal 0x00058874
0x0005b650 nop
0x0005b654 jal 0x00058aa4
0x0005b658 nop
0x0005b65c jal 0x0005dec4
0x0005b660 nop
0x0005b664 jal 0x000e62d0
0x0005b668 nop
0x0005b66c lh v0,-0x6dc6(gp)
0x0005b670 nop
0x0005b674 addi v0,v0,0x0001
0x0005b678 beq r0,r0,0x0005b62c
0x0005b67c sh v0,-0x6dc6(gp)
0x0005b680 jal 0x000e642c
0x0005b684 nop
0x0005b688 jal 0x00058c68
0x0005b68c nop
0x0005b690 lui asmTemp,0x8015
0x0005b694 lh v0,0x57f4(asmTemp)
0x0005b698 nop
0x0005b69c bne v0,r0,0x0005b6b8
0x0005b6a0 nop
0x0005b6a4 lw v0,-0x6de0(gp)
0x0005b6a8 nop
0x0005b6ac sb r0,0x064e(v0)
0x0005b6b0 beq r0,r0,0x0005b6dc
0x0005b6b4 addiu v0,r0,0xffff
0x0005b6b8 lw v1,-0x6de0(gp)
0x0005b6bc addiu asmTemp,r0,0x0001
0x0005b6c0 lbu v0,0x064e(v1)
0x0005b6c4 nop
0x0005b6c8 bne v0,asmTemp,0x0005b6dc
0x0005b6cc addiu v0,r0,0x0001
0x0005b6d0 sb r0,0x064e(v1)
0x0005b6d4 beq r0,r0,0x0005b6dc
0x0005b6d8 addu v0,r0,r0
0x0005b6dc lw ra,0x0010(sp)
0x0005b6e0 nop
0x0005b6e4 jr ra
0x0005b6e8 addiu sp,sp,0x0018