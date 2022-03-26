void 0x00059CF0(entityPtr = a0, enemyPtr = a1, combatPtr = a2, combatId = a3) {
  if(load(0x134F54) != 0 && load(0x134D60) != entityPtr) {
    handleBattleIdle(entityPtr, entityPtr + 0x38, load(combatPtr + 0x34))
    return
  }
  
  if(0x00059E54(entityPtr, enemyPtr, combatPtr) != 0)
    return
  
  moveRange = load(combatPtr + 0x36)
  
  if(moveRange == 1) {
    if(0x0005A06C(entityPtr, enemyPtr, combatPtr, combatId) == 0)
      return
    
    0x000D4884(enemyPtr, entityPtr, 280, 200)
    return
  }
  else if(moveRange == 2 || moveRange == 3) {
    moveId = load(combatPtr + 0x38) - 0x2E
    entityType = load(entityPtr)
    techId = load(0x12CEB4 + entityType * 52 + moveId + 0x23)
    
    0x0005A37C(entityPtr, enemyPtr, combatPtr, techId)
  }
  else if(moveRange == 4) {
    handleBattleIdle(entityPtr, entityPtr + 0x38, load(combatPtr + 0x34))
    0x0005D79C(entityPtr, enemyPtr, combatPtr)
  }
}

0x00059cf0 addiu sp,sp,0xffd8
0x00059cf4 sw ra,0x0020(sp)
0x00059cf8 sw s3,0x001c(sp)
0x00059cfc sw s2,0x0018(sp)
0x00059d00 sw s1,0x0014(sp)
0x00059d04 sw s0,0x0010(sp)
0x00059d08 lw v0,-0x6db8(gp)
0x00059d0c addu s0,a0,r0
0x00059d10 addu s2,a1,r0
0x00059d14 addu s1,a2,r0
0x00059d18 beq v0,r0,0x00059d44
0x00059d1c addu s3,a3,r0
0x00059d20 lw v0,-0x6dcc(gp)
0x00059d24 nop
0x00059d28 beq v0,s0,0x00059d44
0x00059d2c nop
0x00059d30 lhu a2,0x0034(s1)
0x00059d34 jal 0x000e7d40
0x00059d38 addiu a1,s0,0x0038
0x00059d3c beq r0,r0,0x00059e3c
0x00059d40 lw ra,0x0020(sp)
0x00059d44 addu a0,s0,r0
0x00059d48 addu a1,s2,r0
0x00059d4c jal 0x00059e54
0x00059d50 addu a2,s1,r0
0x00059d54 bne v0,r0,0x00059e38
0x00059d58 nop
0x00059d5c lb v0,0x0036(s1)
0x00059d60 addiu asmTemp,r0,0x0004
0x00059d64 beq v0,asmTemp,0x00059e18
0x00059d68 nop
0x00059d6c addiu asmTemp,r0,0x0003
0x00059d70 beq v0,asmTemp,0x00059dcc
0x00059d74 nop
0x00059d78 addiu asmTemp,r0,0x0002
0x00059d7c beq v0,asmTemp,0x00059dcc
0x00059d80 nop
0x00059d84 addiu asmTemp,r0,0x0001
0x00059d88 bne v0,asmTemp,0x00059e38
0x00059d8c nop
0x00059d90 sll a3,s3,0x10
0x00059d94 sra a3,a3,0x10
0x00059d98 addu a0,s0,r0
0x00059d9c addu a1,s2,r0
0x00059da0 jal 0x0005a06c
0x00059da4 addu a2,s1,r0
0x00059da8 beq v0,r0,0x00059e38
0x00059dac nop
0x00059db0 addu a0,s2,r0
0x00059db4 addu a1,s0,r0
0x00059db8 addiu a2,r0,0x0118
0x00059dbc jal 0x000d4884
0x00059dc0 addiu a3,r0,0x00c8
0x00059dc4 beq r0,r0,0x00059e3c
0x00059dc8 lw ra,0x0020(sp)
0x00059dcc lbu v0,0x0038(s1)
0x00059dd0 lw v1,0x0000(s0)
0x00059dd4 addi a0,v0,-0x002e
0x00059dd8 sll v0,v1,0x01
0x00059ddc add v0,v0,v1
0x00059de0 sll v0,v0,0x02
0x00059de4 add v0,v0,v1
0x00059de8 sll v1,v0,0x02
0x00059dec lui v0,0x8013
0x00059df0 addiu v0,v0,0xceb4
0x00059df4 addu v0,v0,v1
0x00059df8 addu v0,a0,v0
0x00059dfc lbu a3,0x0023(v0)
0x00059e00 addu a0,s0,r0
0x00059e04 addu a1,s2,r0
0x00059e08 jal 0x0005a37c
0x00059e0c addu a2,s1,r0
0x00059e10 beq r0,r0,0x00059e3c
0x00059e14 lw ra,0x0020(sp)
0x00059e18 lhu a2,0x0034(s1)
0x00059e1c addu a0,s0,r0
0x00059e20 jal 0x000e7d40
0x00059e24 addiu a1,s0,0x0038
0x00059e28 addu a0,s0,r0
0x00059e2c addu a1,s2,r0
0x00059e30 jal 0x0005d79c
0x00059e34 addu a2,s1,r0
0x00059e38 lw ra,0x0020(sp)
0x00059e3c lw s3,0x001c(sp)
0x00059e40 lw s2,0x0018(sp)
0x00059e44 lw s1,0x0014(sp)
0x00059e48 lw s0,0x0010(sp)
0x00059e4c jr ra
0x00059e50 addiu sp,sp,0x0028