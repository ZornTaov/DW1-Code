void enemyAiTick() {
  frameCount = load(0x134D66)
  
  combatHead = load(0x134D4C) // combat head
  partnerPtr = load(0x12F348) // partner ptr
  
  // self buff prio timer
  if(frameCount % 20 == 0) {
    for(combatId = 0; combatId < load(0x134D6C); combatId++) {
      combatPtr = combatId * 0x168 + combatHead
      selfBuffPrioTimer = load(combatPtr + 0x3A)
      
      if(selfBuffPrioTimer != 0)
        store(combatPtr + 0x3A, selfBuffPrioTimer - 1)
    }
  }
  
  for(combatId = 1; combatId < load(0x134D6C); combatId++) {
    combatPtr = combatHead + combatId * 0x168
    combatHead = load(0x134D4C)
    statusFlagPtr = combatPtr + 0x34
    entityId = load(combatHead + 0x66C + combatId) // entityId
    entityPtr = load(0x12F344 + entityId * 4)
    statsPtr = entityPtr + 0x38
    noAiFlag = load(0x134D74)
    
    // dumbness effect code
    if(noAiFlag == 0) {
      currentHP = load(statsPtr + 0x14)
      remainingDamage = load(combatPtr + 0x2E)
      brains = load(statsPtr + 0x06)
      
      if(remainingDamage < currentHP
        && brains < 301
        && frameCount % (brains / 2 + 1) * 20 == 0
        && random(100) < (300 - brains) / 4) {
        
        store(statusFlagPtr, load(statusFlagPtr) | 0x2000) // set stupid
        store(combatPtr + 0x2A, 100)
      }
      
      if(load(statusFlagPtr) & 0x2000 == 0)
        increaseSpeedBuffer(combatPtr, statsPtr)
      
      cooldown = load(combatPtr + 0x28)
      
      if(cooldown >= 2)
        store(combatPtr + 0x28, cooldown - 1)
    }
    
    statusFlag = load(statusFlagPtr)
    
    if(statusFlag & 0x80B0 != 0) // dead, knocked down, attacking, blocking
      continue
      
    currentHP = load(statsPtr + 0x14)
    remainingDamage = load(combatPtr + 0x2E)
    
    if(currentHP == 0) {
      handleDeath(entityPtr, combatPtr, combatId)
      continue
    }
    
    // is dead
    if(remainingDamage >= currentHP) {
      handleBattleIdle(entityPtr, statsPtr)
      
      store(combatPtr + 0x36, -1)
      resetFlatten(combatId)
      removeEffectSprites(entityPtr, combatPtr)
      
      store(combatPtr + 0x34, load(combatPtr + 0x34) & 0xFFF0) // unset poisoned, confused, stunned, flat
      continue
    }
    
    partnerCurrentHP = load(partnerPtr + 0x4C)
    
    // partner is ded
    if(partnerCurrentHP == 0) {
      handleBattleIdle(entityPtr, statsPtr)
      
      resetFlatten(combatId)
      
      store(statusFlagPtr, load(statusFlagPtr) & 0xFF4F) // unset knocked back, attacking, blocking
      store(statusFlagPtr, load(statusFlagPtr) | 0x0040) // set transforming
      store(combatPtr + 0x36, -1)
      
      continue
    }
    
    if(noAiFlag != 0)
      return
    
    if(statusFlag & 0x0040 != 0) // transforming
      continue
    
    if(statusFlag & 0x0008 != 0) { // is flattened
      store(combatPtr + 0x36, 2) // moves range
      store(combatPtr + 0x37, 0) // target ID
      store(combatPtr + 0x38, 0) // animID?
      
      startAnimation(entityPtr, 0x23)
      
      store(entityPtr + 0x36, 0) // unknown
      store(combatPtr + 0x34, load(combatPtr + 0x34) | 0x0040) // set transforming/fleeing?
      
      continue
    }
    
    if(statusFlag & 0x0004 != 0) // stunned
      continue
    
    if(statusFlag & 0x0002 != 0) { // confused
      handleConfusion(entityPtr, combatPtr, combatId)
      continue
    }
    
    if(statusFlag & 0x2000 != 0) // stupid
      continue
    if(statusFlag & 0x8000 != 0) // dead
      continue
    if(statusFlag & 0x1000 != 0) // on cooldown
      continue
    
    moveId = load(entityPtr + 0x47)
    techId = getTechFromMove(entityPtr, moveId)
    
    // use finisher if possible
    if(statusFlag & 0x980E == 0 // not confused, stunned, flattened, on chargeup, on cooldown or dead
       && load(combatPtr + 0x22) == 0 // flattened timer
       && moveId != -1
       && techId >= 0x3A && techId < 0x71 // is finisher
       && load(combatPtr + 0x1A) == load(combatPtr + 0x18)) { // finisher progress is done
       
      store(combatPtr + 0x37)
      setMoveAnim(entityPtr, combatPtr, combatId, 3)
      store(combatPtr + 0x1A, 0)
      continue
    }
    
    if(load(statusFlagPtr) & 0x0400 == 0) // unknown value
      store(combatPtr + 0x37, 0) // targetId
    
    setTransformationMatrix(0x136F84)
    
    positionPtr = load(entityPtr + 0x04) + 0xBC
    
    xPos = load(positionPtr + 0x14)
    yPos = load(positionPtr + 0x18)
    zPos = load(positionPtr + 0x1C)
    
    // perspective transformation, done on GTE, using gte_registers
    ir1 = (gte_trx * 0x1000 + gte_rt11 * xPos + gte_rt12 * yPos + gte_rt13 * zPos) >> 12
    ir2 = (gte_try * 0x1000 + gte_rt21 * xPos + gte_rt22 * yPos + gte_rt23 * zPos) >> 12
    ir3 = (gte_trz * 0x1000 + gte_rt31 * xPos + gte_rt32 * yPos + gte_rt33 * zPos) >> 12
    
    sx2 = ((((gte_cr26 * 0x20000 / ir3) + 1) / 2) * ir1 + gte_cr24) / 0x10000
    sy2 = ((((gte_cr26 * 0x20000 / ir3) + 1) / 2) * ir2 + gte_cr25) / 0x10000
    
    screenCoords = { sy2, sx2 }
    
    // ai mode?
    if(isOffScreen(screenCoords, 200, 160) == 1)
      store(statsPtr + 0x1E, 2)
    else
      store(statsPtr + 0x1E, random(2))
    
    enemySelectMove(entityPtr, combatPtr, combatId)
  }
}

0x00058394 addiu sp,sp,0xffc0
0x00058398 sw ra,0x002c(sp)
0x0005839c sw s6,0x0028(sp)
0x000583a0 sw s5,0x0024(sp)
0x000583a4 sw s4,0x0020(sp)
0x000583a8 sw s3,0x001c(sp)
0x000583ac sw s2,0x0018(sp)
0x000583b0 lui asmTemp,0x8013
0x000583b4 sw s1,0x0014(sp)
0x000583b8 lh v1,-0x6dc6(gp)
0x000583bc addiu v0,r0,0x0014
0x000583c0 div v1,v0
0x000583c4 lw a0,-0x6de0(gp)
0x000583c8 lw s6,-0x0cb8(asmTemp)
0x000583cc mfhi v0
0x000583d0 bne v0,r0,0x0005841c
0x000583d4 sw s0,0x0010(sp)
0x000583d8 addu s3,r0,r0
0x000583dc beq r0,r0,0x00058408
0x000583e0 addu a1,r0,r0
0x000583e4 addu v1,a1,a0
0x000583e8 lbu v0,0x003a(v1)
0x000583ec nop
0x000583f0 beq v0,r0,0x00058400
0x000583f4 nop
0x000583f8 addiu v0,v0,0xffff
0x000583fc sb v0,0x003a(v1)
0x00058400 addi s3,s3,0x0001
0x00058404 addi a1,a1,0x0168
0x00058408 lh v0,-0x6dc0(gp)
0x0005840c nop
0x00058410 slt asmTemp,v0,s3
0x00058414 beq asmTemp,r0,0x000583e4
0x00058418 nop
0x0005841c addiu s3,r0,0x0001
0x00058420 beq r0,r0,0x00058838
0x00058424 addiu s0,a0,0x0168
0x00058428 lw v0,-0x6de0(gp)
0x0005842c addiu s2,s0,0x0034
0x00058430 addu v0,s3,v0
0x00058434 lbu v0,0x066c(v0)
0x00058438 nop
0x0005843c sll v1,v0,0x02
0x00058440 lui v0,0x8013
0x00058444 addiu v0,v0,0xf344
0x00058448 addu v0,v0,v1
0x0005844c lw s1,0x0000(v0)
0x00058450 lw v0,-0x6db8(gp)
0x00058454 nop
0x00058458 bne v0,r0,0x00058548
0x0005845c addiu s4,s1,0x0038
0x00058460 lh v1,0x0014(s4)
0x00058464 lh v0,0x002e(s0)
0x00058468 nop
0x0005846c slt asmTemp,v0,v1
0x00058470 beq asmTemp,r0,0x0005850c
0x00058474 nop
0x00058478 lh v0,0x0006(s4)
0x0005847c nop
0x00058480 slti asmTemp,v0,0x012d
0x00058484 beq asmTemp,r0,0x0005850c
0x00058488 addu v1,v0,r0
0x0005848c bgez v1,0x0005849c
0x00058490 sra t9,v1,0x01
0x00058494 addiu v0,v1,0x0001
0x00058498 sra t9,v0,0x01
0x0005849c addi v1,t9,0x0001
0x000584a0 sll v0,v1,0x02
0x000584a4 add v1,v0,v1
0x000584a8 lh v0,-0x6dc6(gp)
0x000584ac sll v1,v1,0x02
0x000584b0 div v0,v1
0x000584b4 mfhi v0
0x000584b8 bne v0,r0,0x0005850c
0x000584bc nop
0x000584c0 lh v1,0x0006(s4)
0x000584c4 addiu v0,r0,0x012c
0x000584c8 sub v0,v0,v1
0x000584cc bgez v0,0x000584dc
0x000584d0 sra t9,v0,0x02
0x000584d4 addiu v0,v0,0x0003
0x000584d8 sra t9,v0,0x02
0x000584dc addu s5,t9,r0
0x000584e0 jal 0x000a36d4
0x000584e4 addiu a0,r0,0x0064
0x000584e8 slt asmTemp,v0,s5
0x000584ec beq asmTemp,r0,0x0005850c
0x000584f0 nop
0x000584f4 lhu v0,0x0000(s2)
0x000584f8 nop
0x000584fc ori v0,v0,0x2000
0x00058500 sh v0,0x0000(s2)
0x00058504 addiu v0,r0,0x0064
0x00058508 sh v0,0x002a(s0)
0x0005850c lhu v0,0x0000(s2)
0x00058510 nop
0x00058514 andi v0,v0,0x2000
0x00058518 bne v0,r0,0x0005852c
0x0005851c nop
0x00058520 addu a0,s0,r0
0x00058524 jal 0x0005af44
0x00058528 addu a1,s4,r0
0x0005852c lh v0,0x0028(s0)
0x00058530 nop
0x00058534 slti asmTemp,v0,0x0002
0x00058538 bne asmTemp,r0,0x00058548
0x0005853c nop
0x00058540 addi v0,v0,-0x0001
0x00058544 sh v0,0x0028(s0)
0x00058548 lhu v0,0x0000(s2)
0x0005854c nop
0x00058550 addu a2,v0,r0
0x00058554 andi v0,v0,0x80b0
0x00058558 bne v0,r0,0x00058830
0x0005855c nop
0x00058560 lh v0,0x0014(s4)
0x00058564 nop
0x00058568 bne v0,r0,0x0005858c
0x0005856c addu v1,v0,r0
0x00058570 sll a2,s3,0x10
0x00058574 sra a2,a2,0x10
0x00058578 addu a0,s1,r0
0x0005857c jal 0x0005afd8
0x00058580 addu a1,s0,r0
0x00058584 beq r0,r0,0x00058834
0x00058588 addi s3,s3,0x0001
0x0005858c lh v0,0x002e(s0)
0x00058590 nop
0x00058594 slt asmTemp,v0,v1
0x00058598 bne asmTemp,r0,0x000585e0
0x0005859c nop
0x000585a0 addu a0,s1,r0
0x000585a4 jal 0x000e7d40
0x000585a8 addu a1,s4,r0
0x000585ac addiu v0,r0,0xffff
0x000585b0 sll a0,s3,0x10
0x000585b4 sb v0,0x0036(s0)
0x000585b8 jal 0x00059078
0x000585bc sra a0,a0,0x10
0x000585c0 addu a0,s1,r0
0x000585c4 jal 0x0005ec7c
0x000585c8 addu a1,s0,r0
0x000585cc lhu v0,0x0034(s0)
0x000585d0 nop
0x000585d4 andi v0,v0,0xfff0
0x000585d8 beq r0,r0,0x00058830
0x000585dc sh v0,0x0034(s0)
0x000585e0 lh v0,0x004c(s6)
0x000585e4 nop
0x000585e8 bne v0,r0,0x00058634
0x000585ec nop
0x000585f0 addu a0,s1,r0
0x000585f4 jal 0x000e7d40
0x000585f8 addu a1,s4,r0
0x000585fc sll a0,s3,0x10
0x00058600 jal 0x00059078
0x00058604 sra a0,a0,0x10
0x00058608 lhu v0,0x0000(s2)
0x0005860c nop
0x00058610 andi v0,v0,0xff4f
0x00058614 sh v0,0x0000(s2)
0x00058618 lhu v0,0x0000(s2)
0x0005861c nop
0x00058620 ori v0,v0,0x0040
0x00058624 sh v0,0x0000(s2)
0x00058628 addiu v0,r0,0xffff
0x0005862c beq r0,r0,0x00058830
0x00058630 sb v0,0x0036(s0)
0x00058634 lw v0,-0x6db8(gp)
0x00058638 nop
0x0005863c bne v0,r0,0x0005884c
0x00058640 nop
0x00058644 andi v0,a2,0x0040
0x00058648 bne v0,r0,0x00058830
0x0005864c nop
0x00058650 andi v0,a2,0x0008
0x00058654 beq v0,r0,0x00058690
0x00058658 nop
0x0005865c sb r0,0x0038(s0)
0x00058660 sb r0,0x0037(s0)
0x00058664 addiu v0,r0,0x0002
0x00058668 sb v0,0x0036(s0)
0x0005866c addu a0,s1,r0
0x00058670 jal 0x000c1a04
0x00058674 addiu a1,r0,0x0023
0x00058678 sb r0,0x0036(s1)
0x0005867c lhu v0,0x0034(s0)
0x00058680 nop
0x00058684 ori v0,v0,0x0040
0x00058688 beq r0,r0,0x00058830
0x0005868c sh v0,0x0034(s0)
0x00058690 andi v0,a2,0x0004
0x00058694 bne v0,r0,0x00058830
0x00058698 nop
0x0005869c andi v0,a2,0x0002
0x000586a0 beq v0,r0,0x000586c0
0x000586a4 nop
0x000586a8 addu a0,s1,r0
0x000586ac addu a1,s0,r0
0x000586b0 jal 0x0005fc18
0x000586b4 addu a2,s3,r0
0x000586b8 beq r0,r0,0x00058834
0x000586bc addi s3,s3,0x0001
0x000586c0 andi v0,a2,0x2000
0x000586c4 bne v0,r0,0x00058830
0x000586c8 nop
0x000586cc andi v0,a2,0x0800
0x000586d0 bne v0,r0,0x00058830
0x000586d4 nop
0x000586d8 andi v0,a2,0x1000
0x000586dc bne v0,r0,0x00058830
0x000586e0 nop
0x000586e4 andi v0,a2,0x980e
0x000586e8 bne v0,r0,0x00058778
0x000586ec nop
0x000586f0 lh v0,0x0022(s0)
0x000586f4 nop
0x000586f8 bne v0,r0,0x00058778
0x000586fc nop
0x00058700 lbu v0,0x0047(s1)
0x00058704 addiu asmTemp,r0,0x00ff
0x00058708 sll a1,v0,0x10
0x0005870c sra a1,a1,0x10
0x00058710 beq a1,asmTemp,0x00058778
0x00058714 nop
0x00058718 jal 0x000e6000
0x0005871c addu a0,s1,r0
0x00058720 sll a1,v0,0x10
0x00058724 sra a1,a1,0x10
0x00058728 slti asmTemp,a1,0x003a
0x0005872c bne asmTemp,r0,0x00058778
0x00058730 nop
0x00058734 slti asmTemp,a1,0x0071
0x00058738 beq asmTemp,r0,0x00058778
0x0005873c nop
0x00058740 lh v1,0x001a(s0)
0x00058744 lh v0,0x0018(s0)
0x00058748 nop
0x0005874c bne v1,v0,0x00058778
0x00058750 nop
0x00058754 sll a2,s3,0x10
0x00058758 sb r0,0x0037(s0)
0x0005875c sra a2,a2,0x10
0x00058760 addu a0,s1,r0
0x00058764 addu a1,s0,r0
0x00058768 jal 0x0005d658
0x0005876c addiu a3,r0,0x0003
0x00058770 beq r0,r0,0x00058830
0x00058774 sh r0,0x001a(s0)
0x00058778 lhu v0,0x0000(s2)
0x0005877c nop
0x00058780 andi v0,v0,0x0400
0x00058784 bne v0,r0,0x00058790
0x00058788 nop
0x0005878c sb r0,0x0037(s0)
0x00058790 lui a0,0x8013
0x00058794 jal 0x00097dd8
0x00058798 addiu a0,a0,0x6f84
0x0005879c lw v0,0x0004(s1)
0x000587a0 addiu a0,sp,0x0038
0x000587a4 addiu v1,v0,0x00bc
0x000587a8 lw v0,0x0014(v1)
0x000587ac nop
0x000587b0 sh v0,0x0038(sp)
0x000587b4 lw v0,0x0018(v1)
0x000587b8 nop
0x000587bc sh v0,0x003a(sp)
0x000587c0 lw v0,0x001c(v1)
0x000587c4 nop
0x000587c8 sh v0,0x003c(sp)
0x000587cc lwc2 gtedr00_vxy0,0x0000(a0)
0x000587d0 lwc2 gtedr01_vz0,0x0004(a0)
0x000587d4 nop
0x000587d8 nop
0x000587dc rtps
0x000587e0 addiu v0,sp,0x0034
0x000587e4 addu a0,v0,r0
0x000587e8 swc2 gtedr14_sxy2,0x0000(a0)
0x000587ec addiu a1,r0,0x00c8
0x000587f0 jal 0x000d5608
0x000587f4 addiu a2,r0,0x00a0
0x000587f8 addiu asmTemp,r0,0x0001
0x000587fc bne v0,asmTemp,0x00058810
0x00058800 nop
0x00058804 addiu v0,r0,0x0002
0x00058808 beq r0,r0,0x0005881c
0x0005880c sb v0,0x001e(s4)
0x00058810 jal 0x000a36d4
0x00058814 addiu a0,r0,0x0002
0x00058818 sb v0,0x001e(s4)
0x0005881c sll a2,s3,0x10
0x00058820 sra a2,a2,0x10
0x00058824 addu a0,s1,r0
0x00058828 jal 0x00060324
0x0005882c addu a1,s0,r0
0x00058830 addi s3,s3,0x0001
0x00058834 addi s0,s0,0x0168
0x00058838 lh v0,-0x6dc0(gp)
0x0005883c nop
0x00058840 slt asmTemp,v0,s3
0x00058844 beq asmTemp,r0,0x00058428
0x00058848 nop
0x0005884c lw ra,0x002c(sp)
0x00058850 lw s6,0x0028(sp)
0x00058854 lw s5,0x0024(sp)
0x00058858 lw s4,0x0020(sp)
0x0005885c lw s3,0x001c(sp)
0x00058860 lw s2,0x0018(sp)
0x00058864 lw s1,0x0014(sp)
0x00058868 lw s0,0x0010(sp)
0x0005886c jr ra
0x00058870 addiu sp,sp,0x0040