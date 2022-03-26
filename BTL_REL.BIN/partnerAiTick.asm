void partnerAiTick() {
  combatPtr = load(0x134D4C) // 0x13D640
  entityPtr = load(0x12F348)
  statsPtr = entityPtr + 0x38
  statusFlagPtr = combatPtr + 0x34
  
  // Update Command Procedure
  unkTimer = load(combatPtr + 0x64A) // timer that prevents command updates, set points unknown
  
  if(unkTimer == 0) {
    newCommand = load(combatPtr + 0x650)
    store(combatPtr + 0x64E, newCommand)
  } 
  else {
    flags = load(statusFlagPtr) & 0x800E // confused, stunned, flattened, dead
    flattenedTimer = load(combatPtr + 0x22)
    
    if(flags == 0 && flattenedTimer == 0)
      store(combatPtr + 0x64A, unkTimer - 1)
  }
  
  // "Dumb" status code
  noAiFlag = load(0x134D74) // no AI flag?
  if(noAiFlag != 0) {
    currentHP = load(statsPtr + 0x14)
    remainingDamage = load(combatPtr + 0x2E)
    brains = load(statsPtr + 0x06)
    checkInterval = (brains / 2 + 1) * 20
    frameCount = load(0x134D66)
    discipline = load(0x138488) // discipline
    
    if(remainingDamage < currentHP 
      && brains < 301 
      && frameCount % checkInterval == 0
      && random(100) < 70 - discipline) {
      
      store(statusFlagPtr, load(statusFlagPtr) | 0x2000) // set dumb flag
      store(combatPtr + 0x2A, 100) // set dumb timer
    }
    
    cooldown = load(combatPtr + 0x28)
    if(cooldown >= 2)
      store(combatPtr + 0x28, cooldown - 1)
    
    flags = load(statusFlagPtr) & 0x2000
    
    if(flags == 0) // if not stupid
      increaseSpeedBuffer(combatPtr, statsPtr)
  }
  
  flags = load(statusFlagPtr) & 0x80B0
  if(flags != 0) // is knocked back, attacking, blocking, or dead
    return
  
  if(load(statsPtr + 0x14) == 0) { // current HP
    handleDeath(entityPtr, combatPtr, 0)
    return
  }
  
  enemyList, enemyCount = getRemainingEnemies(entityPtr)
  
  if(enemyCount == 0) {
    flags = load(statusFlagPtr)
    handleBattleIdle(entityPtr, statsPtr, flags)
    
    store(combatPtr + 0x36, -1)
    resetFlatten(0)
    removeEffectSprites(entityPtr, combatPtr)
    
    store(statusFlagPtr, 0x0040)
    return
  }
  
  if(noAiFlag != 0)
    return
  
  flags = load(statusFlagPtr) & 0x800E // confused, stunned, flattened, dead
  flattenTimer = load(combatPtr + 0x22)
  
  if(flags == 0 && flattenTimer == 0) {
    v1 = load(combatPtr + 0x64E) - 7 // command
    
    switch(v1) {
      default: break; // when v1 > 4
      case 0: // 0x57E40, change command
      
        currentTarget = load(combatPtr + 0x37)
        if(currentTarget == 0x00FF)
          break;
        
        if(load(combatPtr + 0x674) != 1) // should change target
          break;
        
        if(enemyCount == 2) {
          if(currentTarget == enemyList[0]) 
            store(combatPtr + 0x37, enemyList[1]) //load(sp + 0x2C)
          else
            store(combatPtr + 0x37, enemyList[0])
        }
        else if(enemyCount == 3) {
          if(load(combatPtr + 0x671) == 0x00FF && load(combatPtr + 0x672) == 0x00FF) {
            hostileMap = { 1, 1, 1 ,1 }
            
            closestEnemy = getClosestEnemy(entityPtr, hostileMap)
            store(combatPtr + 0x37, closestEnemy)
            
            v0 = load(combatPtr + 0x673)
            store(combatPtr + 0x671 + v0, closestEnemy)
            store(combatPtr + 0x673, v0 ^ 1)
          }
          else {
            selectedTarget = 1
            for(; selectedTarget < 4; i++) {
              
              if(selectedTarget == currentTarget)
                continue
              
              previousTarget = load(combatPtr + 0x671 + load(combatPtr + 0x673) ^ 1)
                
              if(selectedTarget != previousTarget)
                break
            }
              
            store(combatPtr + 0x671 + load(combatPtr + 0x673), currentTarget)
            store(combatPtr + 0x673, load(combatPtr + 0x673) ^ 1)
            store(combatPtr + 0x37, selectedTarget)
          }
        }
        
        store(combatPtr + 0x674, 0)
        return;
      case 1:
      case 2:
      case 3: // 0x57FB4, attack 1-3 command
        if(getMPCost(entityPtr, combatPtr, v1 - 1) == 0)
          break
        
        currentTarget = load(combatPtr + 0x37)
        if(currentTarget != -1 && hasZeroHP(currentTarget))
          aiPickTarget(entityPtr, combatPtr, currentTarget, 0)
        
        attackId = load(combatPtr + 0x64E) - 8 // command
        animId = load(entityPtr + 0x44 + attackId)
        activeAnimId = load(combatPtr + 0x38)
        
        if(animId != activeAnimId || load(combatPtr + 0x36) <= 0)
          setMoveAnim(entityPtr, combatPtr, 0, attackId)
        
        activeMoveId = load(combatPtr + 0x38) - 0x2E // gets changed by previous call
        digimonType = load(entityPtr)
        
        techId = load(0x12CED7 + digimonType * 0x34 + activeMoveId)
        
        setChargeupFlag(entityPtr, combatPtr, techId)
        return
      case 4: // 0x580A4, finisher command
        currentTarget = load(combatPtr + 0x37)
        
        if(currentTarget != 0 && hasZeroHP(currentTarget))
          aiPickTarget(entityPtr, combatPtr, currentTarget, 0)
        
        finisherMove = load(entityPtr + 0x47)
        activeAnimId = load(combatPtr + 0x38)
        activeRange = load(combatPtr + 0x36)
        
        if(finisherMove != activeAnimId || activeRange <= 0)
          setMoveAnim(entityPtr, combatPtr, 0, 3)
        
        return
    }
    
    command = load(combatPtr + 0x64E)
    if(command != 2 && command != 4) {
      aiMode = load(0x135078)
      store(entityPtr + 0x56, aiMode)
    }
  }
  
  //0x58148, randomly change target every 5 seconds when flattened
  if(load(statusFlagPtr) & 0x0008 != 0 && load(0x134D66) % 100 == 0) 
    store(combatPtr + 0x37, enemyList[random(enemyCount)])
  
  //0x58194, stop if this flag is set
  if(load(statusFlagPtr) & 0x0040 != 0)
    return
  
  command = load(combatPtr + 0x64E)
  
  if(command == 1) { // running away
    store(combatPtr + 0x36, 1)
    flags = load(statusFlagPtr) | 0x0040
    store(statusFlagPtr, flags)
  }
  
  flags = load(statusFlagPtr)
  
  if(flags & 0x0008 != 0) { // flattened
    aiPickTarget(entityPtr, combatPtr, load(combatPtr + 0x37), 0)
    flags = load(statusFlagPtr) // flags get changed by aiPickTarget
    
    store(entityPtr + 0x36, 0) // flatten sprite
    
    store(combatPtr + 0x38, 0)
    store(combatPtr + 0x36, 2) // range
    store(combatPtr + 0x34, flags | 0x0040)
    return
  }
  
  if(flags & 0x0004 != 0) // stunned
    return
  
  if(flags & 0x0002 != 0) { // confused
    handleConfusion(entityPtr, combatPtr, 0)
    return
  }
  
  if(flags & 0x0800 != 0) // is on chargeup
    return
  
  if(flags & 0x1000 != 0) // is on cooldown
    return
  
  if(flags & 0x2000 != 0) // is in dumb state
    return
  
  if(flags & 0x0400 == 0) { // is in unknown state
    currentTarget = load(combatPtr + 0x37)
    aiPickTarget(entityPtr, combatPtr, currentTarget, 0)
  }
  
  command = load(combatPtr + 0x64E)
  selectedMove = -1
  
  if(command == 2) { // attack command
    moveArray = short[4]
    hasMove = hasAffordableMoves(moveArray, 0)
    
    if(hasMove == 0) { // set cooldown
      store(combatPtr + 0x28, 0x50)
      flags = load(combatPtr + 0x34) | 0x0800
      store(combatPtr + 0x34, flags)
      return
    }
    
    selectedMove = getMoveCommandAttack(0, moveArray)
    store(entityPtr + 0x56, 0)
  }
  else if(command == 4) { // moderate command
    moveArray = short[4]
    hasMove = hasAffordableMoves(moveArray, 0)
    
    if(hasMove == 0) { // set cooldown
      store(combatPtr + 0x28, 0x50)
      flags = load(combatPtr + 0x34) | 0x0800
      store(combatPtr + 0x34, flags)
      return
    }
    
    selectedMove = getMoveCommandModerate(0, moveArray)
    store(entityPtr + 0x56, 2)
  }
  
  if(selectedMove == -1)
    partnerYourCallSelectMove(entityPtr, combatPtr, 0)
  else
    setMoveAnim(entityPtr, combatPtr, 0, selectedMove)
}

0x00057bd0 addiu sp,sp,0xffb8
0x00057bd4 sw ra,0x0024(sp)
0x00057bd8 sw s4,0x0020(sp)
0x00057bdc sw s3,0x001c(sp)
0x00057be0 sw s2,0x0018(sp)
0x00057be4 sw s1,0x0014(sp)
0x00057be8 sw s0,0x0010(sp)
0x00057bec lw s0,-0x6de0(gp)
0x00057bf0 lui asmTemp,0x8013
0x00057bf4 addu a0,s0,r0
0x00057bf8 lw s1,-0x0cb8(asmTemp)
0x00057bfc lh v1,0x064a(a0)
0x00057c00 addiu s3,s1,0x0038
0x00057c04 bne v1,r0,0x00057c18
0x00057c08 addiu s2,a0,0x0034
0x00057c0c lbu v0,0x0650(a0)
0x00057c10 beq r0,r0,0x00057c44
0x00057c14 sb v0,0x064e(a0)
0x00057c18 lhu v0,0x0000(s2)
0x00057c1c nop
0x00057c20 andi v0,v0,0x800e
0x00057c24 bne v0,r0,0x00057c44
0x00057c28 nop
0x00057c2c lh v0,0x0022(s0)
0x00057c30 nop
0x00057c34 bne v0,r0,0x00057c44
0x00057c38 nop
0x00057c3c addi v0,v1,-0x0001
0x00057c40 sh v0,0x064a(a0)
0x00057c44 lw v0,-0x6db8(gp)
0x00057c48 nop
0x00057c4c bne v0,r0,0x00057d2c
0x00057c50 nop
0x00057c54 lh v1,0x0014(s3)
0x00057c58 lh v0,0x002e(s0)
0x00057c5c nop
0x00057c60 slt asmTemp,v0,v1
0x00057c64 beq asmTemp,r0,0x00057cf0
0x00057c68 nop
0x00057c6c lh v0,0x0006(s3)
0x00057c70 nop
0x00057c74 slti asmTemp,v0,0x012d
0x00057c78 beq asmTemp,r0,0x00057cf0
0x00057c7c addu v1,v0,r0
0x00057c80 bgez v1,0x00057c90
0x00057c84 sra t9,v1,0x01
0x00057c88 addiu v0,v1,0x0001
0x00057c8c sra t9,v0,0x01
0x00057c90 addi v1,t9,0x0001
0x00057c94 sll v0,v1,0x02
0x00057c98 add v1,v0,v1
0x00057c9c lh v0,-0x6dc6(gp)
0x00057ca0 sll v1,v1,0x02
0x00057ca4 div v0,v1
0x00057ca8 mfhi v0
0x00057cac bne v0,r0,0x00057cf0
0x00057cb0 nop
0x00057cb4 lui asmTemp,0x8014
0x00057cb8 lh v1,-0x7b78(asmTemp)
0x00057cbc addiu v0,r0,0x0046
0x00057cc0 sub s4,v0,v1
0x00057cc4 jal 0x000a36d4
0x00057cc8 addiu a0,r0,0x0064
0x00057ccc slt asmTemp,v0,s4
0x00057cd0 beq asmTemp,r0,0x00057cf0
0x00057cd4 nop
0x00057cd8 lhu v0,0x0000(s2)
0x00057cdc nop
0x00057ce0 ori v0,v0,0x2000
0x00057ce4 sh v0,0x0000(s2)
0x00057ce8 addiu v0,r0,0x0064
0x00057cec sh v0,0x002a(s0)
0x00057cf0 lh v0,0x0028(s0)
0x00057cf4 nop
0x00057cf8 slti asmTemp,v0,0x0002
0x00057cfc bne asmTemp,r0,0x00057d0c
0x00057d00 nop
0x00057d04 addi v0,v0,-0x0001
0x00057d08 sh v0,0x0028(s0)
0x00057d0c lhu v0,0x0000(s2)
0x00057d10 nop
0x00057d14 andi v0,v0,0x2000
0x00057d18 bne v0,r0,0x00057d2c
0x00057d1c nop
0x00057d20 addu a0,s0,r0
0x00057d24 jal 0x0005af44
0x00057d28 addu a1,s3,r0
0x00057d2c lhu v0,0x0000(s2)
0x00057d30 nop
0x00057d34 andi v0,v0,0x80b0
0x00057d38 bne v0,r0,0x00058374
0x00057d3c nop
0x00057d40 lh v0,0x0014(s3)
0x00057d44 nop
0x00057d48 bne v0,r0,0x00057d68
0x00057d4c addu a0,s1,r0
0x00057d50 addu a0,s1,r0
0x00057d54 addu a1,s0,r0
0x00057d58 jal 0x0005afd8
0x00057d5c addu a2,r0,r0
0x00057d60 beq r0,r0,0x00058378
0x00057d64 lw ra,0x0024(sp)
0x00057d68 addiu a1,sp,0x002c
0x00057d6c jal 0x0005fce8
0x00057d70 addiu a2,sp,0x0046
0x00057d74 lh a1,0x0046(sp)
0x00057d78 nop
0x00057d7c bne a1,r0,0x00057dc8
0x00057d80 nop
0x00057d84 lhu a2,0x0000(s2)
0x00057d88 addu a0,s1,r0
0x00057d8c jal 0x000e7d40
0x00057d90 addu a1,s3,r0
0x00057d94 addiu v0,r0,0xffff
0x00057d98 sb v0,0x0036(s0)
0x00057d9c jal 0x00059078
0x00057da0 addu a0,r0,r0
0x00057da4 addu a0,s1,r0
0x00057da8 jal 0x0005ec7c
0x00057dac addu a1,s0,r0
0x00057db0 sh r0,0x0000(s2)
0x00057db4 lhu v0,0x0000(s2)
0x00057db8 nop
0x00057dbc ori v0,v0,0x0040
0x00057dc0 beq r0,r0,0x00058374
0x00057dc4 sh v0,0x0000(s2)
0x00057dc8 lw v0,-0x6db8(gp)
0x00057dcc nop
0x00057dd0 bne v0,r0,0x00058374
0x00057dd4 nop
0x00057dd8 lhu v0,0x0000(s2)
0x00057ddc nop
0x00057de0 andi v0,v0,0x800e
0x00057de4 bne v0,r0,0x00058148
0x00057de8 nop
0x00057dec lh v0,0x0022(s0)
0x00057df0 nop
0x00057df4 bne v0,r0,0x00058148
0x00057df8 nop
0x00057dfc lw v0,-0x6de0(gp)
0x00057e00 nop
0x00057e04 lbu v1,0x064e(v0)
0x00057e08 nop
0x00057e0c addu a2,v1,r0
0x00057e10 addi v1,v1,-0x0007
0x00057e14 sltiu asmTemp,v1,0x0005
0x00057e18 beq asmTemp,r0,0x00058118
0x00057e1c nop
0x00057e20 lui a0,0x8007
0x00057e24 addiu a0,a0,0x2d60
0x00057e28 sll v1,v1,0x02
0x00057e2c addu v1,v1,a0
0x00057e30 lw v1,0x0000(v1)
0x00057e34 nop
0x00057e38 jr v1
0x00057e3c nop
0x00057e40 lbu a0,0x0037(s0)
0x00057e44 addiu asmTemp,r0,0x00ff
0x00057e48 beq a0,asmTemp,0x00058118
0x00057e4c addu v1,a0,r0
0x00057e50 lbu a0,0x0674(v0)
0x00057e54 addiu asmTemp,r0,0x0001
0x00057e58 bne a0,asmTemp,0x00058118
0x00057e5c nop
0x00057e60 addiu asmTemp,r0,0x0003
0x00057e64 beq a1,asmTemp,0x00057e9c
0x00057e68 nop
0x00057e6c addiu asmTemp,r0,0x0002
0x00057e70 bne a1,asmTemp,0x00057fa8
0x00057e74 nop
0x00057e78 lh v0,0x002c(sp)
0x00057e7c nop
0x00057e80 bne v1,v0,0x00057e94
0x00057e84 nop
0x00057e88 lh v0,0x002e(sp)
0x00057e8c beq r0,r0,0x00057fa8
0x00057e90 sb v0,0x0037(s0)
0x00057e94 beq r0,r0,0x00057fa8
0x00057e98 sb v0,0x0037(s0)
0x00057e9c lbu a0,0x0671(v0)
0x00057ea0 addiu asmTemp,r0,0x00ff
0x00057ea4 bne a0,asmTemp,0x00057f30
0x00057ea8 nop
0x00057eac lbu a0,0x0672(v0)
0x00057eb0 addiu asmTemp,r0,0x00ff
0x00057eb4 bne a0,asmTemp,0x00057f30
0x00057eb8 nop
0x00057ebc addiu a1,r0,0x0001
0x00057ec0 beq r0,r0,0x00057edc
0x00057ec4 addiu a0,r0,0x0002
0x00057ec8 addu v0,sp,a0
0x00057ecc addiu v1,r0,0x0001
0x00057ed0 sh v1,0x003c(v0)
0x00057ed4 addi a1,a1,0x0001
0x00057ed8 addi a0,a0,0x0002
0x00057edc slti asmTemp,a1,0x0004
0x00057ee0 bne asmTemp,r0,0x00057ec8
0x00057ee4 nop
0x00057ee8 addu a0,s1,r0
0x00057eec jal 0x00060218
0x00057ef0 addiu a1,sp,0x003c
0x00057ef4 sb v0,0x0037(s0)
0x00057ef8 lw a0,-0x6de0(gp)
0x00057efc lbu v1,0x0037(s0)
0x00057f00 lbu v0,0x0673(a0)
0x00057f04 nop
0x00057f08 addu v0,v0,a0
0x00057f0c sb v1,0x0671(v0)
0x00057f10 lw v1,-0x6de0(gp)
0x00057f14 nop
0x00057f18 lbu v0,0x0673(v1)
0x00057f1c nop
0x00057f20 addi v0,v0,0x0001
0x00057f24 andi v0,v0,0x0001
0x00057f28 beq r0,r0,0x00057fa8
0x00057f2c sb v0,0x0673(v1)
0x00057f30 lw a2,-0x6de0(gp)
0x00057f34 beq r0,r0,0x00057f6c
0x00057f38 addiu a1,r0,0x0001
0x00057f3c beq v1,a1,0x00057f68
0x00057f40 nop
0x00057f44 lbu a0,0x0673(a2)
0x00057f48 nop
0x00057f4c addi a0,a0,0x0001
0x00057f50 andi a0,a0,0x0001
0x00057f54 addu a0,a0,a2
0x00057f58 lbu a0,0x0671(a0)
0x00057f5c nop
0x00057f60 bne a0,a1,0x00057f78
0x00057f64 nop
0x00057f68 addi a1,a1,0x0001
0x00057f6c slti asmTemp,a1,0x0004
0x00057f70 bne asmTemp,r0,0x00057f3c
0x00057f74 nop
0x00057f78 lbu a0,0x0673(v0)
0x00057f7c nop
0x00057f80 addu v0,a0,v0
0x00057f84 sb v1,0x0671(v0)
0x00057f88 lw v1,-0x6de0(gp)
0x00057f8c nop
0x00057f90 lbu v0,0x0673(v1)
0x00057f94 nop
0x00057f98 addi v0,v0,0x0001
0x00057f9c andi v0,v0,0x0001
0x00057fa0 sb v0,0x0673(v1)
0x00057fa4 sb a1,0x0037(s0)
0x00057fa8 lw v0,-0x6de0(gp)
0x00057fac beq r0,r0,0x00058374
0x00057fb0 sb r0,0x0674(v0)
0x00057fb4 addi v0,a2,-0x0008
0x00057fb8 sll a2,v0,0x10
0x00057fbc sra a2,a2,0x10
0x00057fc0 addu a0,s1,r0
0x00057fc4 jal 0x0005d374
0x00057fc8 addu a1,s0,r0
0x00057fcc beq v0,r0,0x00058118
0x00057fd0 nop
0x00057fd4 lbu v0,0x0037(s0)
0x00057fd8 addiu asmTemp,r0,0x00ff
0x00057fdc beq v0,asmTemp,0x00058008
0x00057fe0 addu a0,v0,r0
0x00057fe4 jal 0x000601ac
0x00057fe8 nop
0x00057fec beq v0,r0,0x00058008
0x00057ff0 nop
0x00057ff4 lbu a2,0x0037(s0)
0x00057ff8 addu a0,s1,r0
0x00057ffc addu a1,s0,r0
0x00058000 jal 0x0005fea4
0x00058004 addu a3,r0,r0
0x00058008 lw v0,-0x6de0(gp)
0x0005800c nop
0x00058010 lbu v0,0x064e(v0)
0x00058014 nop
0x00058018 addi v0,v0,-0x0008
0x0005801c addu a0,v0,r0
0x00058020 addu v0,v0,s1
0x00058024 lbu v1,0x0044(v0)
0x00058028 lbu v0,0x0038(s0)
0x0005802c nop
0x00058030 bne v1,v0,0x00058048
0x00058034 nop
0x00058038 lb v0,0x0036(s0)
0x0005803c nop
0x00058040 bgtz v0,0x0005805c
0x00058044 nop
0x00058048 andi a3,a0,0x00ff
0x0005804c addu a0,s1,r0
0x00058050 addu a1,s0,r0
0x00058054 jal 0x0005d658
0x00058058 addu a2,r0,r0
0x0005805c lbu v0,0x0038(s0)
0x00058060 lw v1,0x0000(s1)
0x00058064 addi a0,v0,-0x002e
0x00058068 sll v0,v1,0x01
0x0005806c add v0,v0,v1
0x00058070 sll v0,v0,0x02
0x00058074 add v0,v0,v1
0x00058078 sll v1,v0,0x02
0x0005807c lui v0,0x8013
0x00058080 addiu v0,v0,0xceb4
0x00058084 addu v0,v0,v1
0x00058088 addu v0,a0,v0
0x0005808c lbu a2,0x0023(v0)
0x00058090 addu a0,s1,r0
0x00058094 jal 0x0005d6e0
0x00058098 addu a1,s0,r0
0x0005809c beq r0,r0,0x00058378
0x000580a0 lw ra,0x0024(sp)
0x000580a4 lbu v0,0x0037(s0)
0x000580a8 nop
0x000580ac beq v0,r0,0x000580d8
0x000580b0 addu a0,v0,r0
0x000580b4 jal 0x000601ac
0x000580b8 nop
0x000580bc beq v0,r0,0x000580d8
0x000580c0 nop
0x000580c4 lbu a2,0x0037(s0)
0x000580c8 addu a0,s1,r0
0x000580cc addu a1,s0,r0
0x000580d0 jal 0x0005fea4
0x000580d4 addu a3,r0,r0
0x000580d8 lbu v1,0x0047(s1)
0x000580dc lbu v0,0x0038(s0)
0x000580e0 nop
0x000580e4 bne v1,v0,0x000580fc
0x000580e8 nop
0x000580ec lb v0,0x0036(s0)
0x000580f0 nop
0x000580f4 bgtz v0,0x00058374
0x000580f8 nop
0x000580fc addu a0,s1,r0
0x00058100 addu a1,s0,r0
0x00058104 addu a2,r0,r0
0x00058108 jal 0x0005d658
0x0005810c addiu a3,r0,0x0003
0x00058110 beq r0,r0,0x00058378
0x00058114 lw ra,0x0024(sp)
0x00058118 lw v0,-0x6de0(gp)
0x0005811c addiu asmTemp,r0,0x0002
0x00058120 lbu v0,0x064e(v0)
0x00058124 nop
0x00058128 beq v0,asmTemp,0x00058148
0x0005812c addu v1,v0,r0
0x00058130 addiu asmTemp,r0,0x0004
0x00058134 beq v1,asmTemp,0x00058148
0x00058138 nop
0x0005813c lbu v0,-0x6ab4(gp)
0x00058140 nop
0x00058144 sb v0,0x0056(s1)
0x00058148 lhu v0,0x0000(s2)
0x0005814c nop
0x00058150 andi v0,v0,0x0008
0x00058154 beq v0,r0,0x00058194
0x00058158 nop
0x0005815c lh v1,-0x6dc6(gp)
0x00058160 addiu v0,r0,0x0064
0x00058164 div v1,v0
0x00058168 mfhi v0
0x0005816c bne v0,r0,0x00058194
0x00058170 nop
0x00058174 lh a0,0x0046(sp)
0x00058178 jal 0x000a36d4
0x0005817c nop
0x00058180 sll v0,v0,0x01
0x00058184 addu v0,sp,v0
0x00058188 lh v0,0x002c(v0)
0x0005818c nop
0x00058190 sb v0,0x0037(s0)
0x00058194 lhu v0,0x0000(s2)
0x00058198 nop
0x0005819c andi v0,v0,0x0040
0x000581a0 bne v0,r0,0x00058374
0x000581a4 nop
0x000581a8 lw v0,-0x6de0(gp)
0x000581ac addiu asmTemp,r0,0x0001
0x000581b0 lbu v0,0x064e(v0)
0x000581b4 nop
0x000581b8 bne v0,asmTemp,0x000581d8
0x000581bc nop
0x000581c0 addiu v0,r0,0x0001
0x000581c4 sb v0,0x0036(s0)
0x000581c8 lhu v0,0x0000(s2)
0x000581cc nop
0x000581d0 ori v0,v0,0x0040
0x000581d4 sh v0,0x0000(s2)
0x000581d8 lhu v0,0x0000(s2)
0x000581dc nop
0x000581e0 addu v1,v0,r0
0x000581e4 andi v0,v0,0x0008
0x000581e8 beq v0,r0,0x00058228
0x000581ec nop
0x000581f0 sb r0,0x0038(s0)
0x000581f4 lbu a2,0x0037(s0)
0x000581f8 addu a0,s1,r0
0x000581fc addu a1,s0,r0
0x00058200 jal 0x0005fea4
0x00058204 addu a3,r0,r0
0x00058208 addiu v0,r0,0x0002
0x0005820c sb v0,0x0036(s0)
0x00058210 sb r0,0x0036(s1)
0x00058214 lhu v0,0x0034(s0)
0x00058218 nop
0x0005821c ori v0,v0,0x0040
0x00058220 beq r0,r0,0x00058374
0x00058224 sh v0,0x0034(s0)
0x00058228 andi v0,v1,0x0004
0x0005822c bne v0,r0,0x00058374
0x00058230 nop
0x00058234 andi v0,v1,0x0002
0x00058238 beq v0,r0,0x00058258
0x0005823c nop
0x00058240 addu a0,s1,r0
0x00058244 addu a1,s0,r0
0x00058248 jal 0x0005fc18
0x0005824c addu a2,r0,r0
0x00058250 beq r0,r0,0x00058378
0x00058254 lw ra,0x0024(sp)
0x00058258 andi v0,v1,0x0800
0x0005825c bne v0,r0,0x00058374
0x00058260 nop
0x00058264 andi v0,v1,0x1000
0x00058268 bne v0,r0,0x00058374
0x0005826c nop
0x00058270 andi v0,v1,0x2000
0x00058274 bne v0,r0,0x00058374
0x00058278 nop
0x0005827c andi v0,v1,0x0400
0x00058280 bne v0,r0,0x0005829c
0x00058284 nop
0x00058288 lbu a2,0x0037(s0)
0x0005828c addu a0,s1,r0
0x00058290 addu a1,s0,r0
0x00058294 jal 0x0005fea4
0x00058298 addu a3,r0,r0
0x0005829c lw v1,-0x6de0(gp)
0x000582a0 nop
0x000582a4 lbu v1,0x064e(v1)
0x000582a8 addiu asmTemp,r0,0x0004
0x000582ac beq v1,asmTemp,0x00058300
0x000582b0 addiu v0,r0,0xffff
0x000582b4 addiu asmTemp,r0,0x0002
0x000582b8 bne v1,asmTemp,0x00058340
0x000582bc nop
0x000582c0 addiu a0,sp,0x0034
0x000582c4 jal 0x0005b070
0x000582c8 addu a1,r0,r0
0x000582cc bne v0,r0,0x000582f0
0x000582d0 addu a0,r0,r0
0x000582d4 addiu v0,r0,0x0050
0x000582d8 sh v0,0x0028(s0)
0x000582dc lhu v0,0x0034(s0)
0x000582e0 nop
0x000582e4 ori v0,v0,0x0800
0x000582e8 beq r0,r0,0x00058374
0x000582ec sh v0,0x0034(s0)
0x000582f0 jal 0x0005fdb4
0x000582f4 addiu a1,sp,0x0034
0x000582f8 beq r0,r0,0x00058340
0x000582fc sb r0,0x0056(s1)
0x00058300 addiu a0,sp,0x0034
0x00058304 jal 0x0005b070
0x00058308 addu a1,r0,r0
0x0005830c bne v0,r0,0x00058330
0x00058310 addu a0,r0,r0
0x00058314 addiu v0,r0,0x0050
0x00058318 sh v0,0x0028(s0)
0x0005831c lhu v0,0x0034(s0)
0x00058320 nop
0x00058324 ori v0,v0,0x0800
0x00058328 beq r0,r0,0x00058374
0x0005832c sh v0,0x0034(s0)
0x00058330 jal 0x0005fe2c
0x00058334 addiu a1,sp,0x0034
0x00058338 addiu v1,r0,0x0002
0x0005833c sb v1,0x0056(s1)
0x00058340 addiu asmTemp,r0,0xffff
0x00058344 bne v0,asmTemp,0x00058364
0x00058348 andi a3,v0,0x00ff
0x0005834c addu a0,s1,r0
0x00058350 addu a1,s0,r0
0x00058354 jal 0x00060618
0x00058358 addu a2,r0,r0
0x0005835c beq r0,r0,0x00058378
0x00058360 lw ra,0x0024(sp)
0x00058364 addu a0,s1,r0
0x00058368 addu a1,s0,r0
0x0005836c jal 0x0005d658
0x00058370 addu a2,r0,r0
0x00058374 lw ra,0x0024(sp)
0x00058378 lw s4,0x0020(sp)
0x0005837c lw s3,0x001c(sp)
0x00058380 lw s2,0x0018(sp)
0x00058384 lw s1,0x0014(sp)
0x00058388 lw s0,0x0010(sp)
0x0005838c jr ra
0x00058390 addiu sp,sp,0x0048