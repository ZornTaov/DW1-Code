/**
 * Gets the weakest enemy and returns it alongside the weakness score 
 * of the last checked Digimon.
 *
 * This function is probably bugged. It's probably supposed to return
 * the best Digimon's score, as opposed to the last one's.
 * Also see getWeaknessScore(), which is probably bugged as well.
 */
int, int getWeakestEnemy(entityPtr, combatPtr) {
  bestScore = 1000
  lastScore = 0
  bestEntity = -1
  
  combatHead = load(0x134D4C)
  
  for(combatId = 0; combatId <= load(0x134D6C); combatId++) {
    entityId = load(combatHead + 0x66C + combatId)
    localEntityPtr = load(0x12F344 + entityId * 4)
    
    if(localEntityPtr == entityPtr)
      continue
    
    if(hasZeroHP(combatId))
      continue
    
    currentTarget = load(combatPtr + 0x37)
    
    // is current target
    if(currentTarget != -1) {
      entityId = load(combatHead + 0x66C + currentTarget)
      targetEntityPtr = load(0x12F344 + entityId * 4)
      
      if(localEntityPtr == targetEntityPtr)
        continue
    }
    
    lastScore = getWeaknessScore(entityPtr, localEntityPtr)
    
    if(lastScore >= bestScore)
      continue
    
    bestScore = lastScore
    bestEntity = combatId
  }
  
  return lastScore, bestEntity
}

0x0005f61c addiu sp,sp,0xffd0
0x0005f620 sw ra,0x002c(sp)
0x0005f624 sw s6,0x0028(sp)
0x0005f628 sw s5,0x0024(sp)
0x0005f62c sw s4,0x0020(sp)
0x0005f630 sw s3,0x001c(sp)
0x0005f634 sw s2,0x0018(sp)
0x0005f638 sw s1,0x0014(sp)
0x0005f63c addiu v0,r0,0x03e8
0x0005f640 sll s1,v0,0x10
0x0005f644 sw s0,0x0010(sp)
0x0005f648 addu s5,a3,r0
0x0005f64c addiu v0,r0,0x00ff
0x0005f650 addu s4,a0,r0
0x0005f654 addu s6,a1,r0
0x0005f658 addu s3,a2,r0
0x0005f65c sra s1,s1,0x10
0x0005f660 sh v0,0x0000(s5)
0x0005f664 beq r0,r0,0x0005f728
0x0005f668 addu s0,r0,r0
0x0005f66c lw v0,-0x6de0(gp)
0x0005f670 nop
0x0005f674 addu v0,s0,v0
0x0005f678 lbu v0,0x066c(v0)
0x0005f67c nop
0x0005f680 sll v1,v0,0x02
0x0005f684 lui v0,0x8013
0x0005f688 addiu v0,v0,0xf344
0x0005f68c addu v0,v0,v1
0x0005f690 lw s2,0x0000(v0)
0x0005f694 nop
0x0005f698 beq s2,s4,0x0005f724
0x0005f69c nop
0x0005f6a0 jal 0x000601ac
0x0005f6a4 andi a0,s0,0x00ff
0x0005f6a8 bne v0,r0,0x0005f724
0x0005f6ac nop
0x0005f6b0 lbu v0,0x0037(s6)
0x0005f6b4 addiu asmTemp,r0,0x00ff
0x0005f6b8 beq v0,asmTemp,0x0005f6f4
0x0005f6bc addu v1,v0,r0
0x0005f6c0 lw v0,-0x6de0(gp)
0x0005f6c4 nop
0x0005f6c8 addu v0,v1,v0
0x0005f6cc lbu v0,0x066c(v0)
0x0005f6d0 nop
0x0005f6d4 sll v1,v0,0x02
0x0005f6d8 lui v0,0x8013
0x0005f6dc addiu v0,v0,0xf344
0x0005f6e0 addu v0,v0,v1
0x0005f6e4 lw v0,0x0000(v0)
0x0005f6e8 nop
0x0005f6ec beq s2,v0,0x0005f724
0x0005f6f0 nop
0x0005f6f4 addu a0,s4,r0
0x0005f6f8 jal 0x0005f764
0x0005f6fc addu a1,s2,r0
0x0005f700 sh v0,0x0000(s3)
0x0005f704 lh v0,0x0000(s3)
0x0005f708 nop
0x0005f70c slt asmTemp,v0,s1
0x0005f710 beq asmTemp,r0,0x0005f724
0x0005f714 addu v1,v0,r0
0x0005f718 sll s1,v1,0x10
0x0005f71c sra s1,s1,0x10
0x0005f720 sh s0,0x0000(s5)
0x0005f724 addi s0,s0,0x0001
0x0005f728 lh v0,-0x6dc0(gp)
0x0005f72c nop
0x0005f730 slt asmTemp,v0,s0
0x0005f734 beq asmTemp,r0,0x0005f66c
0x0005f738 nop
0x0005f73c lw ra,0x002c(sp)
0x0005f740 lw s6,0x0028(sp)
0x0005f744 lw s5,0x0024(sp)
0x0005f748 lw s4,0x0020(sp)
0x0005f74c lw s3,0x001c(sp)
0x0005f750 lw s2,0x0018(sp)
0x0005f754 lw s1,0x0014(sp)
0x0005f758 lw s0,0x0010(sp)
0x0005f75c jr ra
0x0005f760 addiu sp,sp,0x0030