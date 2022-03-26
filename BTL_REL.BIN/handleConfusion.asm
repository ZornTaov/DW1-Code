void handleConfusion(entityPtr, combatPtr, combatId) {
  if(random(10) < 7)
    store(combatPtr + 0x37, -1)
  else {
    enemyList, enemyCount = getRemainingEnemies(entityPtr)
    store(combatPtr + 0x37, enemyList[random(enemyCount)])
  }
  
  moveArray = short[4]
  numAffordableMoves = hasAffordableMoves(moveArray, combatId)
  
  if(numAffordableMoves == 0) 
    setCooldown(entityPtr, combatPtr)
  else {
    moveId = selectRandomMove(moveArray)
    setMoveAnim(entityPtr, combatPtr, combatId, moveId)
  }
}

0x0005fc18 addiu sp,sp,0xffc8
0x0005fc1c sw ra,0x001c(sp)
0x0005fc20 sw s2,0x0018(sp)
0x0005fc24 sw s1,0x0014(sp)
0x0005fc28 sw s0,0x0010(sp)
0x0005fc2c addu s1,a0,r0
0x0005fc30 addu s0,a1,r0
0x0005fc34 addu s2,a2,r0
0x0005fc38 jal 0x000a36d4
0x0005fc3c addiu a0,r0,0x000a
0x0005fc40 slti asmTemp,v0,0x0007
0x0005fc44 beq asmTemp,r0,0x0005fc58
0x0005fc48 addu a0,s1,r0
0x0005fc4c addiu v0,r0,0x00ff
0x0005fc50 beq r0,r0,0x0005fc84
0x0005fc54 sb v0,0x0037(s0)
0x0005fc58 addiu a1,sp,0x002c
0x0005fc5c jal 0x0005fce8
0x0005fc60 addiu a2,sp,0x0036
0x0005fc64 lh a0,0x0036(sp)
0x0005fc68 jal 0x000a36d4
0x0005fc6c nop
0x0005fc70 sll v0,v0,0x01
0x0005fc74 addu v0,sp,v0
0x0005fc78 lh v0,0x002c(v0)
0x0005fc7c nop
0x0005fc80 sb v0,0x0037(s0)
0x0005fc84 sll a1,s2,0x10
0x0005fc88 sra a1,a1,0x10
0x0005fc8c jal 0x0005ee58
0x0005fc90 addiu a0,sp,0x0024
0x0005fc94 bne v0,r0,0x0005fcb0
0x0005fc98 nop
0x0005fc9c addu a0,s1,r0
0x0005fca0 jal 0x0005ef3c
0x0005fca4 addu a1,s0,r0
0x0005fca8 beq r0,r0,0x0005fcd4
0x0005fcac lw ra,0x001c(sp)
0x0005fcb0 jal 0x0005ef58
0x0005fcb4 addiu a0,sp,0x0024
0x0005fcb8 sll a2,s2,0x10
0x0005fcbc andi a3,v0,0x00ff
0x0005fcc0 sra a2,a2,0x10
0x0005fcc4 addu a0,s1,r0
0x0005fcc8 jal 0x0005d658
0x0005fccc addu a1,s0,r0
0x0005fcd0 lw ra,0x001c(sp)
0x0005fcd4 lw s2,0x0018(sp)
0x0005fcd8 lw s1,0x0014(sp)
0x0005fcdc lw s0,0x0010(sp)
0x0005fce0 jr ra
0x0005fce4 addiu sp,sp,0x0038