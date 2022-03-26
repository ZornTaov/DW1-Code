void partnerYourCallSelectMove(entityPtr, combatPtr, combatId) {
  moveArray = short[4] // sp + 0x60
  powerArray = int[4] // sp + 0x3C
  rankingArray = int[4] // sp + 0x54
  
  moveSlotArray = { 0, 1, 2 } // sp + 0x48
  prioArray = { 0, 0, 0 } // sp + 0x68
  
  if(hasAffordableMoves(moveArray, combatId) == 0) {
    setCooldown(entityPtr, combatPtr)
    return
  }
  
  aiMode = load(entityPtr + 0x56) // attack type
  
  if(aiMode == 0) {
    for(s0 = 0; s0 < 3; s0++) {
      if(moveArray[s0] == 0)
        powerArray[s0] = -1
      else {
        moveId = load(entityPtr + 0x44 + s0)
        techId = getTechFromMove(entityPtr, moveId)
        powerArray[s0] = load(0x126240 + techId * 0x10)
      }
    }
    
    sortMoveArrayDescending(powerArray, moveSlotArray, rankingArray, 3)
    
    for(s0 = 0; s0 < 3; s0++) {
      moveSlot = moveSlotArray[s0]
      
      if(load(entityPtr + 0x44 + moveSlot) == -1) // has no move equipped
        prioArray[moveSlot] = prioArray[moveSlot] + 5
      else if(moveArray[moveSlot] != 0) { // is move usable
        prioValue = load(0x1346EC + rankingArray[moveSlot])
        prioArray[moveSlot] = prioValue
      }
    }
  }
  else if(aiMode == 1) {
    for(s0 = 0; s0 < 3; s0++) {
      if(load(entityPtr + 0x44 + s0) == -1)
        prioArray[s0] = prioArray[s0] + 5
      else if(moveArray[s0] != 0) // is move usable
        prioArray[s0] = prioArray[s0] + 20
    }
  }
  else if(aiMode == 2) {
    for(s0 = 0; s0 < 3; s0++) {
      if(moveArray[s0] == 0)
        powerArray[s0] = 10000
      else {
        moveId = load(entityPtr + 0x44 + s0)
        techId = getTechFromMove(entityPtr, moveId)
        powerArray[s0] = load(0x126242 + techId * 0x10) * 3
      }
    }
    
    sortMoveArrayAscending(powerArray, moveSlotArray, rankingArray, 3)
    
    for(s0 = 0; s0 < 3; s0++) {
      moveSlot = moveSlotArray[s0]
      
      if(load(entityPtr + 0x44 + moveSlot) == -1) // has no move equipped
        prioArray[moveSlot] = prioArray[moveSlot] + 5
      else if(moveArray[moveSlot] != 0) { // is move usable
        prioValue = load(0x1346F0 + rankingArray[moveSlot])
        prioArray[moveSlot] = prioValue
      }
    }
  }
  
  for(s0 = 0; s0 < 3; s0++) {
    moveId = load(entityPtr + 0x44 + s0)
    
    if(moveId == -1)
      continue
    
    if(moveArray[s0] == 0) {
      store(sp + 0x68 + s0 * 2, 0)
      continue
    }
    
    techId = getTechFromMove(entityPtr, moveId)
    range = load(0x126244 + techId * 0x10)
    
    if(range == 4) {
      moveSpec = load(0x126245 + techId * 0x10)
      digimonType = load(entityPtr)
      digimonSpec = load(0x12CEB4 + digimonType * 0x34 + 0x1E)
      
      typePriority = getTypeFactorPriority(moveSpec, digimonSpec)
      buffPrio = load(combatPtr + 0x3A) // self buff prio timer
      
      prioArray[s0] = prioArray[s0] + buffPrio + typePriority
      continue
    }
    
    moveSpec = load(0x126245 + techId * 0x10)
    currentTarget = load(combatPtr + 0x37)
    
    combatHead = load(0x134D4C) // combat head
    
    combatId = load(combatHead + 0x066C + currentTarget)
    entityPtr = load(0x12F344 + combatId * 4) // entityPtr
    enemyType = load(entityPtr)
    
    enemySpec = load(0x12CEB4 + enemyType * 0x34 + 0x1E)
    typePriority = getTypeFactorPriority(moveSpec, enemySpec)
    prioArray[s0] = prioArray[s0] + typePriority
    
    v0 = load(0x126244 + techId * 0x10)
    
    if(v0 != 3)
      continue
    
    aliveEnemies = getNumAliveNPCs()
    
    if(aiMode == 0) {
      brains = load(entityPtr + 0x3E)
      
      if(brains < 200 || aliveEnemies < 2)
        continue
      
      prioArray[s0] = prioArray[s0] + aliveEnemies * 10
      continue
    }
    else if(aiMode == 1){
      brains = load(entityPtr + 0x3E)
      
      if(brains < 200 || aliveEnemies < 2)
        continue
      
      prioArray[s0] = prioArray[s0] + aliveEnemies * 15
      continue
    }
    else if(aiMode == 2) {
      brains = load(entityPtr + 0x3E)
      
      if(brains >= 200 && aliveEnemies >= 2) {
        prioArray[s0] = prioArray[s0] + aliveEnemies * 15
        continue
      }
      else {
        currentHP = load(entityPtr + 0x4C) * 100
        maxHP = load(entityPtr + 0x48)
        
        v0 = currentHP / maxHP
        
        if(v0 > 30)
          continue
        
        for(s1 = 0; s1 < 3; s1++) {
          if(moveArray[s0] == 0)
            powerArray[s0] = -1
          else {
            moveId = load(entityPtr + 0x44 + s0)
            techId = getTechFromMove(entityPtr, moveId)
            powerArray[s0] = load(0x12623C + techId * 0x10)
          }
        }
        
        sortMoveArrayDescending(powerArray, moveSlotArray, rankingArray, 3)
        
        for(s0 = 0; s0 < 3; s0++) {
          if(load(entityPtr + 0x44 + s0) == -1)
            continue
          
          if(moveArray[s0] == 0)
            continue
          
          prioValue = load(0x1346F4 + rankingArray[s0])
          prioArray[moveSlotArray[s0]] = prioValue
        }
      }
    }
  }
  
  totalPrio = 0
  for(i = 0; i < 3; i++)
    totalPrio += prioArray[i]
  
  randomPrio = random(totalPrio)
  
  prioCounter = 0
  moveSlot = 0
  for(; moveSlot < 3; moveSlot++) {
    movePrio = prioArray[moveSlot]
    
    if(movePrio == 0)
      continue
    
    prioCounter += movePrio
    
    if(randomPrio < prioCounter)
      break
  }
  
  moveId = load(entityPtr + 0x44 + moveSlot)
  
  if(moveId != -1)
    setMoveAnim(entityPtr, combatPtr, value, moveSlot)
  else {
    store(combatPtr + 0x28, 0x50)
    v0 = load(combatPtr + 0x34) | 0x0800
    store(combatPtr + 0x34, v0)
  }
}

0x00060618 addiu sp,sp,0xff90
0x0006061c sw ra,0x0030(sp)
0x00060620 sw s7,0x002c(sp)
0x00060624 sw s6,0x0028(sp)
0x00060628 sw s5,0x0024(sp)
0x0006062c sw s4,0x0020(sp)
0x00060630 sw s3,0x001c(sp)
0x00060634 sw s2,0x0018(sp)
0x00060638 sw s1,0x0014(sp)
0x0006063c addu s4,a0,r0
0x00060640 addu s6,a1,r0
0x00060644 addu s7,a2,r0
0x00060648 sw s0,0x0010(sp)
0x0006064c addiu a0,sp,0x0060
0x00060650 jal 0x0005ee58
0x00060654 addu a1,s7,r0
0x00060658 bne v0,r0,0x00060674
0x0006065c addu s0,r0,r0
0x00060660 addu a0,s4,r0
0x00060664 jal 0x0005ef3c
0x00060668 addu a1,s6,r0
0x0006066c beq r0,r0,0x00060e28
0x00060670 lw ra,0x0030(sp)
0x00060674 addu v1,r0,r0
0x00060678 beq r0,r0,0x0006069c
0x0006067c addu a0,r0,r0
0x00060680 addu v0,sp,v1
0x00060684 sh r0,0x0068(v0)
0x00060688 addu v0,sp,a0
0x0006068c sw s0,0x0048(v0)
0x00060690 addi s0,s0,0x0001
0x00060694 addi a0,a0,0x0004
0x00060698 addi v1,v1,0x0002
0x0006069c slti asmTemp,s0,0x0003
0x000606a0 bne asmTemp,r0,0x00060680
0x000606a4 nop
0x000606a8 addiu s3,s4,0x0038
0x000606ac lbu v0,0x001e(s3)
0x000606b0 addiu asmTemp,r0,0x0002
0x000606b4 beq v0,asmTemp,0x0006086c
0x000606b8 addu s0,r0,r0
0x000606bc addiu asmTemp,r0,0x0001
0x000606c0 beq v0,asmTemp,0x000607fc
0x000606c4 addu s0,r0,r0
0x000606c8 bne v0,r0,0x00060998
0x000606cc nop
0x000606d0 addu s0,r0,r0
0x000606d4 addu s2,r0,r0
0x000606d8 beq r0,r0,0x00060744
0x000606dc addu s1,r0,r0
0x000606e0 addu v0,sp,s2
0x000606e4 lh v0,0x0060(v0)
0x000606e8 nop
0x000606ec bne v0,r0,0x00060704
0x000606f0 nop
0x000606f4 addiu v1,r0,0xffff
0x000606f8 addu v0,sp,s1
0x000606fc beq r0,r0,0x00060738
0x00060700 sw v1,0x003c(v0)
0x00060704 addu v0,s3,s0
0x00060708 lbu a1,0x000c(v0)
0x0006070c jal 0x000e6000
0x00060710 addu a0,s4,r0
0x00060714 sll v0,v0,0x10
0x00060718 sra v0,v0,0x10
0x0006071c sll v1,v0,0x04
0x00060720 lui v0,0x8012
0x00060724 addiu v0,v0,0x6240
0x00060728 addu v0,v0,v1
0x0006072c lh v1,0x0000(v0)
0x00060730 addu v0,sp,s1
0x00060734 sw v1,0x003c(v0)
0x00060738 addi s0,s0,0x0001
0x0006073c addi s1,s1,0x0004
0x00060740 addi s2,s2,0x0002
0x00060744 slti asmTemp,s0,0x0003
0x00060748 bne asmTemp,r0,0x000606e0
0x0006074c nop
0x00060750 addiu a0,sp,0x003c
0x00060754 addiu a1,sp,0x0048
0x00060758 addiu a2,sp,0x0054
0x0006075c jal 0x0005f8e0
0x00060760 addiu a3,r0,0x0003
0x00060764 addu s0,r0,r0
0x00060768 beq r0,r0,0x000607e8
0x0006076c addu v0,r0,r0
0x00060770 addu a0,sp,v0
0x00060774 lw v1,0x0048(a0)
0x00060778 addiu asmTemp,r0,0x00ff
0x0006077c addu a1,v1,r0
0x00060780 addu v1,v1,s3
0x00060784 lbu v1,0x000c(v1)
0x00060788 nop
0x0006078c bne v1,asmTemp,0x000607b0
0x00060790 nop
0x00060794 sll v1,a1,0x01
0x00060798 addu a0,sp,v1
0x0006079c lh v1,0x0068(a0)
0x000607a0 nop
0x000607a4 addi v1,v1,0x0005
0x000607a8 beq r0,r0,0x000607e0
0x000607ac sh v1,0x0068(a0)
0x000607b0 sll v1,a1,0x01
0x000607b4 addu a1,sp,v1
0x000607b8 lh v1,0x0060(a1)
0x000607bc nop
0x000607c0 beq v1,r0,0x000607e0
0x000607c4 nop
0x000607c8 lw a0,0x0054(a0)
0x000607cc addiu v1,gp,0x8bc0
0x000607d0 addu v1,v1,a0
0x000607d4 lbu v1,0x0000(v1)
0x000607d8 nop
0x000607dc sh v1,0x0068(a1)
0x000607e0 addi s0,s0,0x0001
0x000607e4 addi v0,v0,0x0004
0x000607e8 slti asmTemp,s0,0x0003
0x000607ec bne asmTemp,r0,0x00060770
0x000607f0 nop
0x000607f4 beq r0,r0,0x00060998
0x000607f8 nop
0x000607fc beq r0,r0,0x00060858
0x00060800 addu a0,r0,r0
0x00060804 addu v0,s0,s3
0x00060808 lbu v0,0x000c(v0)
0x0006080c addiu asmTemp,r0,0x00ff
0x00060810 bne v0,asmTemp,0x0006082c
0x00060814 nop
0x00060818 addu v1,sp,a0
0x0006081c lh v0,0x0068(v1)
0x00060820 nop
0x00060824 addi v0,v0,0x0005
0x00060828 sh v0,0x0068(v1)
0x0006082c addu v1,sp,a0
0x00060830 lh v0,0x0060(v1)
0x00060834 nop
0x00060838 beq v0,r0,0x00060850
0x0006083c nop
0x00060840 lh v0,0x0068(v1)
0x00060844 nop
0x00060848 addi v0,v0,0x0014
0x0006084c sh v0,0x0068(v1)
0x00060850 addi s0,s0,0x0001
0x00060854 addi a0,a0,0x0002
0x00060858 slti asmTemp,s0,0x0003
0x0006085c bne asmTemp,r0,0x00060804
0x00060860 nop
0x00060864 beq r0,r0,0x00060998
0x00060868 nop
0x0006086c addu s2,r0,r0
0x00060870 beq r0,r0,0x000608e8
0x00060874 addu s1,r0,r0
0x00060878 addu v0,sp,s2
0x0006087c lh v0,0x0060(v0)
0x00060880 nop
0x00060884 bne v0,r0,0x0006089c
0x00060888 nop
0x0006088c addiu v1,r0,0x2710
0x00060890 addu v0,sp,s1
0x00060894 beq r0,r0,0x000608dc
0x00060898 sw v1,0x003c(v0)
0x0006089c addu v0,s3,s0
0x000608a0 lbu a1,0x000c(v0)
0x000608a4 jal 0x000e6000
0x000608a8 addu a0,s4,r0
0x000608ac sll v0,v0,0x10
0x000608b0 sra v0,v0,0x10
0x000608b4 sll v1,v0,0x04
0x000608b8 lui v0,0x8012
0x000608bc addiu v0,v0,0x6242
0x000608c0 addu v0,v0,v1
0x000608c4 lbu v1,0x0000(v0)
0x000608c8 nop
0x000608cc sll v0,v1,0x01
0x000608d0 add v1,v0,v1
0x000608d4 addu v0,sp,s1
0x000608d8 sw v1,0x003c(v0)
0x000608dc addi s0,s0,0x0001
0x000608e0 addi s1,s1,0x0004
0x000608e4 addi s2,s2,0x0002
0x000608e8 slti asmTemp,s0,0x0003
0x000608ec bne asmTemp,r0,0x00060878
0x000608f0 nop
0x000608f4 addiu a0,sp,0x003c
0x000608f8 addiu a1,sp,0x0048
0x000608fc addiu a2,sp,0x0054
0x00060900 jal 0x0005f9d8
0x00060904 addiu a3,r0,0x0003
0x00060908 addu s0,r0,r0
0x0006090c beq r0,r0,0x0006098c
0x00060910 addu v0,r0,r0
0x00060914 addu a0,sp,v0
0x00060918 lw v1,0x0048(a0)
0x0006091c addiu asmTemp,r0,0x00ff
0x00060920 addu a1,v1,r0
0x00060924 addu v1,v1,s3
0x00060928 lbu v1,0x000c(v1)
0x0006092c nop
0x00060930 bne v1,asmTemp,0x00060954
0x00060934 nop
0x00060938 sll v1,a1,0x01
0x0006093c addu a0,sp,v1
0x00060940 lh v1,0x0068(a0)
0x00060944 nop
0x00060948 addi v1,v1,0x0005
0x0006094c beq r0,r0,0x00060984
0x00060950 sh v1,0x0068(a0)
0x00060954 sll v1,a1,0x01
0x00060958 addu a1,sp,v1
0x0006095c lh v1,0x0060(a1)
0x00060960 nop
0x00060964 beq v1,r0,0x00060984
0x00060968 nop
0x0006096c lw a0,0x0054(a0)
0x00060970 addiu v1,gp,0x8bc4
0x00060974 addu v1,v1,a0
0x00060978 lbu v1,0x0000(v1)
0x0006097c nop
0x00060980 sh v1,0x0068(a1)
0x00060984 addi s0,s0,0x0001
0x00060988 addi v0,v0,0x0004
0x0006098c slti asmTemp,s0,0x0003
0x00060990 bne asmTemp,r0,0x00060914
0x00060994 nop
0x00060998 beq r0,r0,0x00060d50
0x0006099c addu s0,r0,r0
0x000609a0 addu a0,s0,s3
0x000609a4 lbu a1,0x000c(a0)
0x000609a8 addiu asmTemp,r0,0x00ff
0x000609ac beq a1,asmTemp,0x00060d4c
0x000609b0 nop
0x000609b4 sll v0,s0,0x01
0x000609b8 addu s1,v0,r0
0x000609bc addu v1,sp,v0
0x000609c0 lh v0,0x0060(v1)
0x000609c4 nop
0x000609c8 bne v0,r0,0x000609d8
0x000609cc nop
0x000609d0 beq r0,r0,0x00060d4c
0x000609d4 sh r0,0x0068(v1)
0x000609d8 jal 0x000e6000
0x000609dc addu a0,s4,r0
0x000609e0 sll v0,v0,0x10
0x000609e4 sra v0,v0,0x10
0x000609e8 sll v1,v0,0x04
0x000609ec lui v0,0x8012
0x000609f0 addiu v0,v0,0x6244
0x000609f4 addu v0,v0,v1
0x000609f8 lbu v0,0x0000(v0)
0x000609fc addiu asmTemp,r0,0x0004
0x00060a00 bne v0,asmTemp,0x00060a74
0x00060a04 addu s2,v1,r0
0x00060a08 lui v0,0x8012
0x00060a0c addiu v0,v0,0x623c
0x00060a10 addu v0,v0,s2
0x00060a14 lbu a0,0x0009(v0)
0x00060a18 lw v1,0x0000(s4)
0x00060a1c nop
0x00060a20 sll v0,v1,0x01
0x00060a24 add v0,v0,v1
0x00060a28 sll v0,v0,0x02
0x00060a2c add v0,v0,v1
0x00060a30 sll v1,v0,0x02
0x00060a34 lui v0,0x8013
0x00060a38 addiu v0,v0,0xceb4
0x00060a3c addu v0,v0,v1
0x00060a40 lbu a1,0x001e(v0)
0x00060a44 jal 0x0005fad0
0x00060a48 nop
0x00060a4c lbu v1,0x003a(s6)
0x00060a50 nop
0x00060a54 add v0,v1,v0
0x00060a58 sll a0,v0,0x10
0x00060a5c addu v1,sp,s1
0x00060a60 lh v0,0x0068(v1)
0x00060a64 sra a0,a0,0x10
0x00060a68 add v0,v0,a0
0x00060a6c beq r0,r0,0x00060d4c
0x00060a70 sh v0,0x0068(v1)
0x00060a74 lui v0,0x8012
0x00060a78 addiu v0,v0,0x623c
0x00060a7c addu v0,v0,s2
0x00060a80 lbu a0,0x0009(v0)
0x00060a84 lbu v1,0x0037(s6)
0x00060a88 lw v0,-0x6de0(gp)
0x00060a8c nop
0x00060a90 addu v0,v0,v1
0x00060a94 lbu v0,0x066c(v0)
0x00060a98 nop
0x00060a9c sll v1,v0,0x02
0x00060aa0 lui v0,0x8013
0x00060aa4 addiu v0,v0,0xf344
0x00060aa8 addu v0,v0,v1
0x00060aac lw v0,0x0000(v0)
0x00060ab0 nop
0x00060ab4 lw v1,0x0000(v0)
0x00060ab8 nop
0x00060abc sll v0,v1,0x01
0x00060ac0 add v0,v0,v1
0x00060ac4 sll v0,v0,0x02
0x00060ac8 add v0,v0,v1
0x00060acc sll v1,v0,0x02
0x00060ad0 lui v0,0x8013
0x00060ad4 addiu v0,v0,0xceb4
0x00060ad8 addu v0,v0,v1
0x00060adc lbu a1,0x001e(v0)
0x00060ae0 jal 0x0005fad0
0x00060ae4 nop
0x00060ae8 addu a0,sp,s1
0x00060aec lh v1,0x0068(a0)
0x00060af0 addiu asmTemp,r0,0x0003
0x00060af4 add v0,v1,v0
0x00060af8 sh v0,0x0068(a0)
0x00060afc lui v0,0x8012
0x00060b00 addiu v0,v0,0x6244
0x00060b04 addu v0,v0,s2
0x00060b08 lbu v0,0x0000(v0)
0x00060b0c nop
0x00060b10 bne v0,asmTemp,0x00060d4c
0x00060b14 nop
0x00060b18 jal 0x0005fb54
0x00060b1c nop
0x00060b20 lbu v1,0x0056(s4)
0x00060b24 addiu asmTemp,r0,0x0002
0x00060b28 beq v1,asmTemp,0x00060bd0
0x00060b2c nop
0x00060b30 addiu asmTemp,r0,0x0001
0x00060b34 beq v1,asmTemp,0x00060b8c
0x00060b38 nop
0x00060b3c bne v1,r0,0x00060d4c
0x00060b40 nop
0x00060b44 lh v1,0x0006(s3)
0x00060b48 nop
0x00060b4c slti asmTemp,v1,0x00c8
0x00060b50 bne asmTemp,r0,0x00060d4c
0x00060b54 nop
0x00060b58 slti asmTemp,v0,0x0002
0x00060b5c bne asmTemp,r0,0x00060d4c
0x00060b60 nop
0x00060b64 sll v1,v0,0x02
0x00060b68 add v0,v1,v0
0x00060b6c sll v0,v0,0x01
0x00060b70 sll a0,v0,0x10
0x00060b74 addu v1,sp,s1
0x00060b78 lh v0,0x0068(v1)
0x00060b7c sra a0,a0,0x10
0x00060b80 add v0,v0,a0
0x00060b84 beq r0,r0,0x00060d4c
0x00060b88 sh v0,0x0068(v1)
0x00060b8c lh v1,0x0006(s3)
0x00060b90 nop
0x00060b94 slti asmTemp,v1,0x00c8
0x00060b98 bne asmTemp,r0,0x00060d4c
0x00060b9c nop
0x00060ba0 slti asmTemp,v0,0x0002
0x00060ba4 bne asmTemp,r0,0x00060d4c
0x00060ba8 nop
0x00060bac sll v1,v0,0x04
0x00060bb0 sub v0,v1,v0
0x00060bb4 sll a0,v0,0x10
0x00060bb8 addu v1,sp,s1
0x00060bbc lh v0,0x0068(v1)
0x00060bc0 sra a0,a0,0x10
0x00060bc4 add v0,v0,a0
0x00060bc8 beq r0,r0,0x00060d4c
0x00060bcc sh v0,0x0068(v1)
0x00060bd0 lh v1,0x0006(s3)
0x00060bd4 nop
0x00060bd8 slti asmTemp,v1,0x00c8
0x00060bdc bne asmTemp,r0,0x00060c14
0x00060be0 nop
0x00060be4 slti asmTemp,v0,0x0002
0x00060be8 bne asmTemp,r0,0x00060c14
0x00060bec nop
0x00060bf0 sll v1,v0,0x04
0x00060bf4 sub v0,v1,v0
0x00060bf8 sll a0,v0,0x10
0x00060bfc addu v1,sp,s1
0x00060c00 lh v0,0x0068(v1)
0x00060c04 sra a0,a0,0x10
0x00060c08 add v0,v0,a0
0x00060c0c beq r0,r0,0x00060d4c
0x00060c10 sh v0,0x0068(v1)
0x00060c14 lh v1,0x0014(s3)
0x00060c18 nop
0x00060c1c sll v0,v1,0x02
0x00060c20 add v1,v0,v1
0x00060c24 sll v0,v1,0x02
0x00060c28 add v1,v1,v0
0x00060c2c lh v0,0x0010(s3)
0x00060c30 sll v1,v1,0x02
0x00060c34 div v1,v0
0x00060c38 mflo v0
0x00060c3c slti asmTemp,v0,0x001f
0x00060c40 beq asmTemp,r0,0x00060d4c
0x00060c44 nop
0x00060c48 addu s1,r0,r0
0x00060c4c sll s5,s0,0x01
0x00060c50 beq r0,r0,0x00060cb4
0x00060c54 sll s2,s0,0x02
0x00060c58 addu v0,sp,s5
0x00060c5c lh v0,0x0060(v0)
0x00060c60 nop
0x00060c64 bne v0,r0,0x00060c7c
0x00060c68 nop
0x00060c6c addiu v1,r0,0xffff
0x00060c70 addu v0,sp,s2
0x00060c74 beq r0,r0,0x00060cb0
0x00060c78 sw v1,0x003c(v0)
0x00060c7c addu v0,s3,s0
0x00060c80 lbu a1,0x000c(v0)
0x00060c84 jal 0x000e6000
0x00060c88 addu a0,s4,r0
0x00060c8c sll v0,v0,0x10
0x00060c90 sra v0,v0,0x10
0x00060c94 sll v1,v0,0x04
0x00060c98 lui v0,0x8012
0x00060c9c addiu v0,v0,0x623c
0x00060ca0 addu v0,v0,v1
0x00060ca4 lw v1,0x0000(v0)
0x00060ca8 addu v0,sp,s2
0x00060cac sw v1,0x003c(v0)
0x00060cb0 addi s1,s1,0x0001
0x00060cb4 slti asmTemp,s1,0x0003
0x00060cb8 bne asmTemp,r0,0x00060c58
0x00060cbc nop
0x00060cc0 addiu a0,sp,0x003c
0x00060cc4 addiu a1,sp,0x0048
0x00060cc8 addiu a2,sp,0x0054
0x00060ccc jal 0x0005f8e0
0x00060cd0 addiu a3,r0,0x0003
0x00060cd4 addu s0,r0,r0
0x00060cd8 addu a1,r0,r0
0x00060cdc beq r0,r0,0x00060d40
0x00060ce0 addu a2,r0,r0
0x00060ce4 addu v0,s0,s3
0x00060ce8 lbu v0,0x000c(v0)
0x00060cec addiu asmTemp,r0,0x00ff
0x00060cf0 beq v0,asmTemp,0x00060d34
0x00060cf4 nop
0x00060cf8 addu v0,sp,a1
0x00060cfc lh v0,0x0060(v0)
0x00060d00 nop
0x00060d04 beq v0,r0,0x00060d34
0x00060d08 nop
0x00060d0c addu a0,sp,a2
0x00060d10 lw v1,0x0054(a0)
0x00060d14 addiu v0,gp,0x8bc8
0x00060d18 addu v0,v0,v1
0x00060d1c lbu v1,0x0000(v0)
0x00060d20 lw v0,0x0048(a0)
0x00060d24 nop
0x00060d28 sll v0,v0,0x01
0x00060d2c addu v0,sp,v0
0x00060d30 sh v1,0x0068(v0)
0x00060d34 addi s0,s0,0x0001
0x00060d38 addi a2,a2,0x0004
0x00060d3c addi a1,a1,0x0002
0x00060d40 slti asmTemp,s0,0x0003
0x00060d44 bne asmTemp,r0,0x00060ce4
0x00060d48 nop
0x00060d4c addi s0,s0,0x0001
0x00060d50 slti asmTemp,s0,0x0003
0x00060d54 bne asmTemp,r0,0x000609a0
0x00060d58 nop
0x00060d5c addu a0,r0,r0
0x00060d60 addu s0,r0,r0
0x00060d64 beq r0,r0,0x00060d80
0x00060d68 addu v1,r0,r0
0x00060d6c addu v0,sp,v1
0x00060d70 lh v0,0x0068(v0)
0x00060d74 addi s0,s0,0x0001
0x00060d78 add a0,a0,v0
0x00060d7c addi v1,v1,0x0002
0x00060d80 slti asmTemp,s0,0x0003
0x00060d84 bne asmTemp,r0,0x00060d6c
0x00060d88 nop
0x00060d8c jal 0x000a36d4
0x00060d90 nop
0x00060d94 addu a0,r0,r0
0x00060d98 addu s0,r0,r0
0x00060d9c beq r0,r0,0x00060dd0
0x00060da0 addu a1,r0,r0
0x00060da4 addu v1,sp,a1
0x00060da8 lh v1,0x0068(v1)
0x00060dac nop
0x00060db0 beq v1,r0,0x00060dc8
0x00060db4 addu a2,v1,r0
0x00060db8 add a0,a0,a2
0x00060dbc slt asmTemp,v0,a0
0x00060dc0 bne asmTemp,r0,0x00060ddc
0x00060dc4 nop
0x00060dc8 addi s0,s0,0x0001
0x00060dcc addi a1,a1,0x0002
0x00060dd0 slti asmTemp,s0,0x0003
0x00060dd4 bne asmTemp,r0,0x00060da4
0x00060dd8 nop
0x00060ddc addu v0,s0,s4
0x00060de0 lbu v0,0x0044(v0)
0x00060de4 addiu asmTemp,r0,0x00ff
0x00060de8 beq v0,asmTemp,0x00060e0c
0x00060dec nop
0x00060df0 andi a3,s0,0x00ff
0x00060df4 addu a0,s4,r0
0x00060df8 addu a1,s6,r0
0x00060dfc jal 0x0005d658
0x00060e00 addu a2,s7,r0
0x00060e04 beq r0,r0,0x00060e28
0x00060e08 lw ra,0x0030(sp)
0x00060e0c addiu v0,r0,0x0050
0x00060e10 sh v0,0x0028(s6)
0x00060e14 lhu v0,0x0034(s6)
0x00060e18 nop
0x00060e1c ori v0,v0,0x0800
0x00060e20 sh v0,0x0034(s6)
0x00060e24 lw ra,0x0030(sp)
0x00060e28 lw s7,0x002c(sp)
0x00060e2c lw s6,0x0028(sp)
0x00060e30 lw s5,0x0024(sp)
0x00060e34 lw s4,0x0020(sp)
0x00060e38 lw s3,0x001c(sp)
0x00060e3c lw s2,0x0018(sp)
0x00060e40 lw s1,0x0014(sp)
0x00060e44 lw s0,0x0010(sp)
0x00060e48 jr ra
0x00060e4c addiu sp,sp,0x0070