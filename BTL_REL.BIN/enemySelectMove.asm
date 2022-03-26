void enemySelectMove(entityPtr, combatPtr, combatId) {
  moveArray = int[4]
  priorityArray = int[4]
  
  numMoves = hasAffordableMoves(moveArray, combatId)
  
  if(numMoves == 0) {
    store(entityPtr + 0x56, 2)
    setCooldown(entityPtr, combatPtr)
  }
  
  for(i = 0; i < 4; i++)
    priorityArray[i] = load(entityPtr + 0x40 + i)
  
  for(i = 0; i < 4; i++) {
    moveId = load(entityPtr + 0x44 + i)
    
    if(moveId != -1) {
      if(moveArray[i] != 0) {
        techId = getTechFromMove(entityPtr, moveId)
        numEnemies = load(0x134D6C)
        combatHead = load(0x134D4C)
        
        for(enemyCounter = 1; enemyCounter < numEnemies; enemyCounter++) {
          if(enemyCounter == combatId)
            continue
          
          entityId = load(combatHead + 0x66C + enemyCounter)
          entityPtr = load(0x12F344 + entityId * 4)
          currentHP = load(entityPtr + 0x4C)
          remainingDamage = load(combatHead + enemyCounter * 0x168 + 0x2E)
          
          if(currentHP - remainingDamage > 0)
            break
        }
        
        if(enemyCounter != numEnemies + 1) { // an NPC died already
          entityId = getNPCId(entityPtr)
          someValue = load(0x15588A + entityId * 0x68)
          
          if(someValue == 0 && load(0x126244 + techId * 16) == 3) // attack type, all range
            priorityArray[i] = priorityArray[i] + 20
        }
        
        if(load(0x126244 + techId * 16) == 4) // attack type, buff
          priorityArray[i] = priorityArray[i] + load(combatPtr + 0x3A) // buff prio
      }
      else
        priorityArray[i] = 0
    }
  }
  
  totalPrio = 0
  
  for(i = 0; i < 4; i++) 
    totalPrio = totalPrio + priorityArray[i]
  
  rolledValue = random(totalPrio)
  prioSum = 0
  
  for(moveId = 0; moveId < 4; moveId++) {
    prio = priorityArray[moveId]
    
    if(prio == 0)
      continue
    
    prioSum += prio
    
    if(rolledValue < prioSum)
      break
  }
  
  if(load(entityPtr + 0x44 + moveId) != -1) // found move
    setMoveAnim(entityPtr, combatPtr, combatId, moveId)
  else {
    store(combatPtr + 0x28, 80)
    store(combatPtr + 0x34, load(combatPtr + 0x34) | 0x0800) // chargeup flag
  }
}

0x00060324 addiu sp,sp,0xffc8
0x00060328 sw ra,0x0024(sp)
0x0006032c sw s4,0x0020(sp)
0x00060330 sw s3,0x001c(sp)
0x00060334 sw s2,0x0018(sp)
0x00060338 sw s1,0x0014(sp)
0x0006033c addu s2,a0,r0
0x00060340 addu s3,a1,r0
0x00060344 addu s4,a2,r0
0x00060348 sw s0,0x0010(sp)
0x0006034c addiu a0,sp,0x0028
0x00060350 jal 0x0005ee58
0x00060354 addu a1,s4,r0
0x00060358 bne v0,r0,0x0006037c
0x0006035c addu s0,r0,r0
0x00060360 addiu v0,r0,0x0002
0x00060364 sb v0,0x0056(s2)
0x00060368 addu a0,s2,r0
0x0006036c jal 0x0005ef3c
0x00060370 addu a1,s3,r0
0x00060374 beq r0,r0,0x000605fc
0x00060378 lw ra,0x0024(sp)
0x0006037c beq r0,r0,0x0006039c
0x00060380 addu a0,r0,r0
0x00060384 addu v0,s0,s2
0x00060388 lbu v1,0x0040(v0)
0x0006038c addi s0,s0,0x0001
0x00060390 addu v0,sp,a0
0x00060394 sh v1,0x0030(v0)
0x00060398 addi a0,a0,0x0002
0x0006039c slti asmTemp,s0,0x0004
0x000603a0 bne asmTemp,r0,0x00060384
0x000603a4 nop
0x000603a8 addu s0,r0,r0
0x000603ac beq r0,r0,0x00060524
0x000603b0 addu s1,r0,r0
0x000603b4 addu a0,s0,s2
0x000603b8 lbu a1,0x0044(a0)
0x000603bc addiu asmTemp,r0,0x00ff
0x000603c0 beq a1,asmTemp,0x0006051c
0x000603c4 nop
0x000603c8 addu v1,sp,s1
0x000603cc lh v0,0x0028(v1)
0x000603d0 nop
0x000603d4 bne v0,r0,0x000603e4
0x000603d8 nop
0x000603dc beq r0,r0,0x0006051c
0x000603e0 sh r0,0x0030(v1)
0x000603e4 jal 0x000e6000
0x000603e8 addu a0,s2,r0
0x000603ec sll t0,v0,0x10
0x000603f0 lh a2,-0x6dc0(gp)
0x000603f4 lw a1,-0x6de0(gp)
0x000603f8 sra t0,t0,0x10
0x000603fc addiu v0,r0,0x0001
0x00060400 addiu v1,r0,0x0168
0x00060404 addu a0,s4,r0
0x00060408 beq r0,r0,0x00060460
0x0006040c addu a3,a2,r0
0x00060410 beq v0,a0,0x00060458
0x00060414 nop
0x00060418 addu t1,v0,a1
0x0006041c lbu t1,0x066c(t1)
0x00060420 nop
0x00060424 sll t2,t1,0x02
0x00060428 lui t1,0x8013
0x0006042c addiu t1,t1,0xf344
0x00060430 addu t1,t1,t2
0x00060434 lw t1,0x0000(t1)
0x00060438 nop
0x0006043c lh t2,0x004c(t1)
0x00060440 addu t1,v1,a1
0x00060444 lh t1,0x002e(t1)
0x00060448 nop
0x0006044c sub t1,t2,t1
0x00060450 bgtz t1,0x0006046c
0x00060454 nop
0x00060458 addi v0,v0,0x0001
0x0006045c addi v1,v1,0x0168
0x00060460 slt asmTemp,a2,v0
0x00060464 beq asmTemp,r0,0x00060410
0x00060468 nop
0x0006046c addi v1,a3,0x0001
0x00060470 beq v0,v1,0x000604e4
0x00060474 nop
0x00060478 jal 0x0005f4c4
0x0006047c addu a0,s2,r0
0x00060480 sll v1,v0,0x01
0x00060484 add v1,v1,v0
0x00060488 sll v1,v1,0x02
0x0006048c add v0,v1,v0
0x00060490 sll v1,v0,0x03
0x00060494 lui v0,0x8015
0x00060498 addiu v0,v0,0x588a
0x0006049c addu v0,v0,v1
0x000604a0 lbu v0,0x0000(v0)
0x000604a4 nop
0x000604a8 bne v0,r0,0x000604e4
0x000604ac nop
0x000604b0 lui v0,0x8012
0x000604b4 sll v1,t0,0x04
0x000604b8 addiu v0,v0,0x6244
0x000604bc addu v0,v0,v1
0x000604c0 lbu v0,0x0000(v0)
0x000604c4 addiu asmTemp,r0,0x0003
0x000604c8 bne v0,asmTemp,0x000604e4
0x000604cc nop
0x000604d0 addu v1,sp,s1
0x000604d4 lh v0,0x0030(v1)
0x000604d8 nop
0x000604dc addi v0,v0,0x0014
0x000604e0 sh v0,0x0030(v1)
0x000604e4 lui v0,0x8012
0x000604e8 sll v1,t0,0x04
0x000604ec addiu v0,v0,0x6244
0x000604f0 addu v0,v0,v1
0x000604f4 lbu v0,0x0000(v0)
0x000604f8 addiu asmTemp,r0,0x0004
0x000604fc bne v0,asmTemp,0x0006051c
0x00060500 nop
0x00060504 addu v1,sp,s1
0x00060508 lbu a0,0x003a(s3)
0x0006050c lh v0,0x0030(v1)
0x00060510 nop
0x00060514 add v0,v0,a0
0x00060518 sh v0,0x0030(v1)
0x0006051c addi s0,s0,0x0001
0x00060520 addi s1,s1,0x0002
0x00060524 slti asmTemp,s0,0x0004
0x00060528 bne asmTemp,r0,0x000603b4
0x0006052c nop
0x00060530 addu a0,r0,r0
0x00060534 addu s0,r0,r0
0x00060538 beq r0,r0,0x00060554
0x0006053c addu v1,r0,r0
0x00060540 addu v0,sp,v1
0x00060544 lh v0,0x0030(v0)
0x00060548 addi s0,s0,0x0001
0x0006054c add a0,a0,v0
0x00060550 addi v1,v1,0x0002
0x00060554 slti asmTemp,s0,0x0004
0x00060558 bne asmTemp,r0,0x00060540
0x0006055c nop
0x00060560 jal 0x000a36d4
0x00060564 nop
0x00060568 addu a0,r0,r0
0x0006056c addu s0,r0,r0
0x00060570 beq r0,r0,0x000605a4
0x00060574 addu a1,r0,r0
0x00060578 addu v1,sp,a1
0x0006057c lh v1,0x0030(v1)
0x00060580 nop
0x00060584 beq v1,r0,0x0006059c
0x00060588 addu a2,v1,r0
0x0006058c add a0,a0,a2
0x00060590 slt asmTemp,v0,a0
0x00060594 bne asmTemp,r0,0x000605b0
0x00060598 nop
0x0006059c addi s0,s0,0x0001
0x000605a0 addi a1,a1,0x0002
0x000605a4 slti asmTemp,s0,0x0004
0x000605a8 bne asmTemp,r0,0x00060578
0x000605ac nop
0x000605b0 addu v0,s0,s2
0x000605b4 lbu v0,0x0044(v0)
0x000605b8 addiu asmTemp,r0,0x00ff
0x000605bc beq v0,asmTemp,0x000605e0
0x000605c0 nop
0x000605c4 andi a3,s0,0x00ff
0x000605c8 addu a0,s2,r0
0x000605cc addu a1,s3,r0
0x000605d0 jal 0x0005d658
0x000605d4 addu a2,s4,r0
0x000605d8 beq r0,r0,0x000605fc
0x000605dc lw ra,0x0024(sp)
0x000605e0 addiu v0,r0,0x0050
0x000605e4 sh v0,0x0028(s3)
0x000605e8 lhu v0,0x0034(s3)
0x000605ec nop
0x000605f0 ori v0,v0,0x0800
0x000605f4 sh v0,0x0034(s3)
0x000605f8 lw ra,0x0024(sp)
0x000605fc lw s4,0x0020(sp)
0x00060600 lw s3,0x001c(sp)
0x00060604 lw s2,0x0018(sp)
0x00060608 lw s1,0x0014(sp)
0x0006060c lw s0,0x0010(sp)
0x00060610 jr ra
0x00060614 addiu sp,sp,0x0038