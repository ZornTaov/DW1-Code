void aiPickTarget(entityPtr, combatPtr, currentTarget, value) {
  partnerEntityPtr = load(0x12F348)
  combatHead = load(0x134D4C)
  
  if(value != 0 || entityPtr != partnerEntityPtr) {
    if(currentTarget == -1) {
      store(combatPtr + 0x37, 0)
      return
    }
    
    if(partnerEntityPtr != entityPtr) {
      npcId = getNPCId(entityPtr)
      unknownValue = load(0x15588A + npcId * 0x68) // unknown value
      
      if(unknownValue == 1 || random(100) < 70) {
        store(combatPtr + 0x37, 0)
        return
      }
    }
    
    if(hasZeroHP(currentTarget) == 0)
      return
      
    flags = load(combatPtr + 0x34) | 0x0400 // set unknown flag
    
    store(combatPtr + 0x34, flags)
    store(combatPtr + 0x37, currentTarget)
    return
  }
  
  command = load(combatPtr + 0x064E) // command
  
  // change command, alive target
  if(command == 7 && currentTarget != -1 && !hasZeroHP(currentTarget))
    return
  
  brains = load(entityPtr + 0x3E)
  
  if(brains >= 300) {
    enemyArray, enemyCount = getStatusedEnemies(entityPtr)
    
    if(enemyCount > 0) {
      enemyId = enemyArray[random(enemyCount)]
      store(combatPtr + 0x37, enemyId)
      return
    }
    
    lastScore, bestEntity = getWeakestEnemy(entityPtr, combatPtr)
    
    if(currentTarget == -1 || hasZeroHP(currentTarget) == 1) {
      store(combatPtr + 0x37, bestEntity)
      return
    }
    
    if(bestEntity == -1)
      return
    
    entityId = load(combatHead + 0x066C + currentTarget)
    enemyScore = getWeaknessScore(entityPtr, load(0x12F344 + entityId * 4))
    
    if(enemyScore - lastScore < 40)
      store(combatPtr + 0x37, bestEntity)
  }
  else if(brains >= 150) {
    if(currentTarget != -1 && hasZeroHP(currentTarget) == 0)
      return
    
    lastScore, bestEntity = getWeakestEnemy(entityPtr, combatPtr)
    store(combatPtr + 0x37, bestEntity)
  }
  else {
    hostileMap = new int[4]
    for(i = 0; i < load(0x134D6C); i++)
      hostileMap[i] = 1
    
    closestEnemy = getClosestEnemy(entityPtr, hostileMap)
    store(combatPtr + 0x37, closestEnemy)
  }
}

0x0005fea4 addiu sp,sp,0xffc8
0x0005fea8 sw ra,0x001c(sp)
0x0005feac sw s2,0x0018(sp)
0x0005feb0 sw s1,0x0014(sp)
0x0005feb4 sw s0,0x0010(sp)
0x0005feb8 addu s0,a0,r0
0x0005febc addu s1,a1,r0
0x0005fec0 beq a3,r0,0x0005fedc
0x0005fec4 addu s2,a2,r0
0x0005fec8 lui asmTemp,0x8013
0x0005fecc lw v0,-0x0cb8(asmTemp)
0x0005fed0 nop
0x0005fed4 beq s0,v0,0x0005fef0
0x0005fed8 nop
0x0005fedc lui asmTemp,0x8013
0x0005fee0 lw v0,-0x0cb8(asmTemp)
0x0005fee4 nop
0x0005fee8 beq s0,v0,0x0005ff94
0x0005feec nop
0x0005fef0 addiu asmTemp,r0,0x00ff
0x0005fef4 beq s2,asmTemp,0x0005ff8c
0x0005fef8 nop
0x0005fefc lui asmTemp,0x8013
0x0005ff00 lw v0,-0x0cb8(asmTemp)
0x0005ff04 nop
0x0005ff08 beq s0,v0,0x0005ff64
0x0005ff0c nop
0x0005ff10 jal 0x0005f4c4
0x0005ff14 addu a0,s0,r0
0x0005ff18 sll v1,v0,0x01
0x0005ff1c add v1,v1,v0
0x0005ff20 sll v1,v1,0x02
0x0005ff24 add v0,v1,v0
0x0005ff28 sll v1,v0,0x03
0x0005ff2c lui v0,0x8015
0x0005ff30 addiu v0,v0,0x588a
0x0005ff34 addu v0,v0,v1
0x0005ff38 lbu v0,0x0000(v0)
0x0005ff3c addiu asmTemp,r0,0x0001
0x0005ff40 beq v0,asmTemp,0x0005ff5c
0x0005ff44 nop
0x0005ff48 jal 0x000a36d4
0x0005ff4c addiu a0,r0,0x0064
0x0005ff50 slti asmTemp,v0,0x0047
0x0005ff54 bne asmTemp,r0,0x0005ff64
0x0005ff58 nop
0x0005ff5c beq r0,r0,0x00060194
0x0005ff60 sb r0,0x0037(s1)
0x0005ff64 jal 0x000601ac
0x0005ff68 addu a0,s2,r0
0x0005ff6c bne v0,r0,0x00060194
0x0005ff70 nop
0x0005ff74 lhu v0,0x0034(s1)
0x0005ff78 nop
0x0005ff7c ori v0,v0,0x0400
0x0005ff80 sh v0,0x0034(s1)
0x0005ff84 beq r0,r0,0x00060194
0x0005ff88 sb s2,0x0037(s1)
0x0005ff8c beq r0,r0,0x00060194
0x0005ff90 sb r0,0x0037(s1)
0x0005ff94 lw v0,-0x6de0(gp)
0x0005ff98 addiu asmTemp,r0,0x0007
0x0005ff9c lbu v0,0x064e(v0)
0x0005ffa0 nop
0x0005ffa4 bne v0,asmTemp,0x0005ffcc
0x0005ffa8 nop
0x0005ffac lbu v0,0x0037(s1)
0x0005ffb0 addiu asmTemp,r0,0x00ff
0x0005ffb4 beq v0,asmTemp,0x0005ffcc
0x0005ffb8 addu a0,v0,r0
0x0005ffbc jal 0x000601ac
0x0005ffc0 nop
0x0005ffc4 beq v0,r0,0x00060194
0x0005ffc8 nop
0x0005ffcc lh a2,-0x6dc0(gp)
0x0005ffd0 addu a0,r0,r0
0x0005ffd4 addu a1,r0,r0
0x0005ffd8 beq r0,r0,0x0005fff4
0x0005ffdc addu a3,a2,r0
0x0005ffe0 addu v0,sp,a1
0x0005ffe4 addiu v1,r0,0xffff
0x0005ffe8 sh v1,0x0020(v0)
0x0005ffec addi a0,a0,0x0001
0x0005fff0 addi a1,a1,0x0002
0x0005fff4 slt asmTemp,a2,a0
0x0005fff8 beq asmTemp,r0,0x0005ffe0
0x0005fffc nop
0x00060000 lh v0,0x003e(s0)
0x00060004 nop
0x00060008 slti asmTemp,v0,0x012c
0x0006000c bne asmTemp,r0,0x00060110
0x00060010 nop
0x00060014 addu a0,s0,r0
0x00060018 addiu a1,sp,0x0020
0x0006001c jal 0x0005f51c
0x00060020 addiu a2,sp,0x0036
0x00060024 lh a0,0x0036(sp)
0x00060028 nop
0x0006002c slti asmTemp,a0,0x0002
0x00060030 bne asmTemp,r0,0x00060054
0x00060034 nop
0x00060038 jal 0x000a36d4
0x0006003c nop
0x00060040 sll v0,v0,0x01
0x00060044 addu v0,sp,v0
0x00060048 lh v0,0x0020(v0)
0x0006004c beq r0,r0,0x00060194
0x00060050 sb v0,0x0037(s1)
0x00060054 addiu asmTemp,r0,0x0001
0x00060058 bne a0,asmTemp,0x0006006c
0x0006005c addu a0,s0,r0
0x00060060 lh v0,0x0020(sp)
0x00060064 beq r0,r0,0x00060194
0x00060068 sb v0,0x0037(s1)
0x0006006c addu a1,s1,r0
0x00060070 addiu a2,sp,0x0032
0x00060074 jal 0x0005f61c
0x00060078 addiu a3,sp,0x0034
0x0006007c lbu v0,0x0037(s1)
0x00060080 addiu asmTemp,r0,0x00ff
0x00060084 beq v0,asmTemp,0x0006009c
0x00060088 addu a0,v0,r0
0x0006008c jal 0x000601ac
0x00060090 nop
0x00060094 beq v0,r0,0x000600a8
0x00060098 nop
0x0006009c lh v0,0x0034(sp)
0x000600a0 beq r0,r0,0x00060194
0x000600a4 sb v0,0x0037(s1)
0x000600a8 lbu v1,0x0037(s1)
0x000600ac lw v0,-0x6de0(gp)
0x000600b0 nop
0x000600b4 addu v0,v0,v1
0x000600b8 lbu v0,0x066c(v0)
0x000600bc nop
0x000600c0 sll v1,v0,0x02
0x000600c4 lui v0,0x8013
0x000600c8 addiu v0,v0,0xf344
0x000600cc addu v0,v0,v1
0x000600d0 lw a1,0x0000(v0)
0x000600d4 jal 0x0005f764
0x000600d8 addu a0,s0,r0
0x000600dc sll a0,v0,0x10
0x000600e0 lh v1,0x0034(sp)
0x000600e4 addiu asmTemp,r0,0x00ff
0x000600e8 beq v1,asmTemp,0x00060194
0x000600ec sra a0,a0,0x10
0x000600f0 lh v0,0x0032(sp)
0x000600f4 nop
0x000600f8 sub v0,a0,v0
0x000600fc slti asmTemp,v0,0x0028
0x00060100 bne asmTemp,r0,0x00060194
0x00060104 nop
0x00060108 beq r0,r0,0x00060194
0x0006010c sb v1,0x0037(s1)
0x00060110 slti asmTemp,v0,0x0096
0x00060114 bne asmTemp,r0,0x0006015c
0x00060118 addu a0,r0,r0
0x0006011c lbu v0,0x0037(s1)
0x00060120 addiu asmTemp,r0,0x00ff
0x00060124 beq v0,asmTemp,0x0006013c
0x00060128 addu a0,v0,r0
0x0006012c jal 0x000601ac
0x00060130 nop
0x00060134 beq v0,r0,0x00060194
0x00060138 nop
0x0006013c addu a0,s0,r0
0x00060140 addu a1,s1,r0
0x00060144 addiu a2,sp,0x0032
0x00060148 jal 0x0005f61c
0x0006014c addiu a3,sp,0x0034
0x00060150 lh v0,0x0034(sp)
0x00060154 beq r0,r0,0x00060194
0x00060158 sb v0,0x0037(s1)
0x0006015c beq r0,r0,0x00060178
0x00060160 addu a1,r0,r0
0x00060164 addu v0,sp,a1
0x00060168 addiu v1,r0,0x0001
0x0006016c sh v1,0x0028(v0)
0x00060170 addi a0,a0,0x0001
0x00060174 addi a1,a1,0x0002
0x00060178 slt asmTemp,a3,a0
0x0006017c beq asmTemp,r0,0x00060164
0x00060180 nop
0x00060184 addu a0,s0,r0
0x00060188 jal 0x00060218
0x0006018c addiu a1,sp,0x0028
0x00060190 sb v0,0x0037(s1)
0x00060194 lw ra,0x001c(sp)
0x00060198 lw s2,0x0018(sp)
0x0006019c lw s1,0x0014(sp)
0x000601a0 lw s0,0x0010(sp)
0x000601a4 jr ra
0x000601a8 addiu sp,sp,0x0038