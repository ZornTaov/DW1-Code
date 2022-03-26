0x00059508(entityPtr, enemyPtr, combatId) {
  if(load(entityPtr + 0x30) & 1 == 0) {
    animTarget = load(entityPtr + 0x1E) // anim frame target
    animCurrent = load(entityPtr + 0x1C) // anim frame current
    
    // is attacking someone who is countering them?
    if(animTarget != animCurrent) {
      combatHead = load(0x134D4C)
      numEnemies = load(0x134D6C)
      
      for(i = 0; i < numEnemies; i++) {
        if(i == combatId)
          continue
        
        entitiyId = load(combatHead + 0x66C + i)
        entityPtr = load(0x12F344 + entitiyId * 4)
        entityType = load(entityPtr)
        activeMove = load(entityPtr + 0x2E) - 0x2E
        attackId = load(0x12CED7 + entityType * 0x34 + activeMove)
        
        if(attackId != 0x2D) // counter
          continue
        
        targetId = load(combatHead + i * 0x168 + 0x37)
        
        if(combatId == targetId)
          return
      }
      
      store(entityPtr + 0x30, load(entityPtr + 0x30) | 1)
    }
  }
  
  0x0005A9F8(combatId)
}

0x00059508 addiu sp,sp,0xffe8
0x0005950c sw ra,0x0010(sp)
0x00059510 lbu v0,0x0030(a0)
0x00059514 nop
0x00059518 andi v0,v0,0x0001
0x0005951c bne v0,r0,0x000595f0
0x00059520 nop
0x00059524 lh v1,0x001e(a0)
0x00059528 lh v0,0x001c(a0)
0x0005952c nop
0x00059530 beq v1,v0,0x000595f0
0x00059534 nop
0x00059538 lw a1,-0x6de0(gp)
0x0005953c lh a3,-0x6dc0(gp)
0x00059540 addu v0,r0,r0
0x00059544 beq r0,r0,0x000595d4
0x00059548 addu v1,r0,r0
0x0005954c beq v0,a2,0x000595cc
0x00059550 nop
0x00059554 addu t0,v0,a1
0x00059558 lbu t0,0x066c(t0)
0x0005955c addiu asmTemp,r0,0x002d
0x00059560 sll t1,t0,0x02
0x00059564 lui t0,0x8013
0x00059568 addiu t0,t0,0xf344
0x0005956c addu t0,t0,t1
0x00059570 lw t1,0x0000(t0)
0x00059574 nop
0x00059578 lbu t0,0x002e(t1)
0x0005957c lw t1,0x0000(t1)
0x00059580 addi t2,t0,-0x002e
0x00059584 sll t0,t1,0x01
0x00059588 add t0,t0,t1
0x0005958c sll t0,t0,0x02
0x00059590 add t0,t0,t1
0x00059594 sll t1,t0,0x02
0x00059598 lui t0,0x8013
0x0005959c addiu t0,t0,0xced7
0x000595a0 addu t0,t0,t1
0x000595a4 addu t0,t2,t0
0x000595a8 lbu t0,0x0000(t0)
0x000595ac nop
0x000595b0 bne t0,asmTemp,0x000595cc
0x000595b4 nop
0x000595b8 addu t0,v1,a1
0x000595bc lbu t0,0x0037(t0)
0x000595c0 nop
0x000595c4 beq a2,t0,0x000595f8
0x000595c8 nop
0x000595cc addi v0,v0,0x0001
0x000595d0 addi v1,v1,0x0168
0x000595d4 slt asmTemp,a3,v0
0x000595d8 beq asmTemp,r0,0x0005954c
0x000595dc nop
0x000595e0 lbu v0,0x0030(a0)
0x000595e4 nop
0x000595e8 ori v0,v0,0x0001
0x000595ec sb v0,0x0030(a0)
0x000595f0 jal 0x0005a9f8
0x000595f4 addu a0,a2,r0
0x000595f8 lw ra,0x0010(sp)
0x000595fc nop
0x00059600 jr ra
0x00059604 addiu sp,sp,0x0018
