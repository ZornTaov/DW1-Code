void battleStatsGainsAndDrops(itemDropArray) {
  // clear stats gain table
  for(i = 0; i < 6; i++)
    store(0x13D468 + i * 2, 0)
  
  // calculate stats gain per stat
  for(statId = 0; statId < 6; statId++) {
    enemyStat = load(0x13D61C + statId * 2) // enemy stat
    enemyCount = load(0x134D6C)
    
    partnerStat = load(0x13D610 + statId * 2) // partner stat
    
    for(enemyId = 1; enemyId < enemyCount; enemyId++) {
      localStat = load(0x13D610 + enemyId * 0x0C + statId * 2)
      if(enemyStat < localStat)
        enemyStat = localStat
    }
    
    partnerStatFactor = partnerStat * 10
    
    if(partnerStatFactor == 0)
      partnerStatFactor = 10
    
    enemyCountFactor = load(0x1344D0 + enemyCount - 1)
    
    if(enemyStat >= partnerStat) {
      statGain = 1 + (enemyStat * enemyCountFactor - 1) / partnerStatFactor
      store(0x13D468 + statId * 2, statGain)
    }
    else {
      chance = enemyStat * enemyCountFactor * 100 / partnerStatFactor
      
      if(random(100) < chance)
        store(0x13D468 + statId * 2, 1)
    }
  }
  
  // calculate extra stats gain conditions that may set it to 1
  for(statId = 0; statId < 6; statId++) {
    combatPtr = load(0x134D4C)
    
    if(load(0x13D468 + statId * 2) != 0)
      continue
    
    // combatPtr + 0x0640 -> attacks done
    // combatPtr + 0x0642 -> attacks blocked
    // combatPtr + 0x0646 -> heavy hits taken (>= 20% of max HP)
    // combatPtr + 0x0648 -> start HP
    
    switch(statId) {
      case 0: // 0x000ED0E4
        startHP = load(combatPtr + 0x0648)
        currentHP = load(0x1557F4)
        
        lostHP = (startHP - currentHP)
        maxHP = load(0x1557F0)
        
        chance = 100 * lostHP / maxHP
        break
      case 1: // 0x000ED128
      case 2: // 0x000ED128
        chance = load(combatPtr + 0x0640) * 10
        break
      case 3: // 0x000ED148
        chance = load(combatPtr + 0x0646) * 10
        break
      case 4: // 0x000ED168
        currentHP = load(0x1557F4)
        startHP = load(combatPtr + 0x0648)
        lostHP = startHP - currentHP
        maxHP = load(0x1557F0)
        
        chance = 50 * (lostHP / maxHP) + (load(combatPtr + 0x0642) * 10)
        break
      case 5: // 0x000ED1B8
        chance = load(combatPtr + 0x0640) * 5 + load(combatPtr + 0x0646) * 5
    }
    
    if(random(100) >= chance)
      continue
    
    store(0x13D468 + statId * 2, 1)
  }
  
  // calculate item drops
  for(enemyId = 0; enemyId < 3; enemyId++) {
    enemyCount = load(0x134D6C)
    
    if(enemyCount <= enemyId || load(0x134DA8) == 0x008F)
      itemDropArray[enemyId] = -1
    else {
      entityId = load(combatPtr + 0x066D + enemyId)
      entityPtr = load(0x12F344 + entityId * 4)
      entityType = load(entityPtr)
      
      dropChance = load(0x12CED6 + entityType * 52)
      dropItem = random(100) < dropChance ? load(0x12CED5 + entityType * 52) : -1
      itemDropArray[enemyId] = dropItem
    }
  }
}

0x000ecee8 addiu sp,sp,0xffd8
0x000eceec sw ra,0x0024(sp)
0x000ecef0 sw s4,0x0020(sp)
0x000ecef4 sw s3,0x001c(sp)
0x000ecef8 sw s2,0x0018(sp)
0x000ecefc sw s1,0x0014(sp)
0x000ecf00 sw s0,0x0010(sp)
0x000ecf04 addu s4,a0,r0
0x000ecf08 addu s0,r0,r0
0x000ecf0c beq r0,r0,0x000ecf2c
0x000ecf10 addu v1,r0,r0
0x000ecf14 lui v0,0x8014
0x000ecf18 addiu v0,v0,0xd468
0x000ecf1c addu v0,v0,v1
0x000ecf20 sh r0,0x0000(v0)
0x000ecf24 addi s0,s0,0x0001
0x000ecf28 addi v1,v1,0x0002
0x000ecf2c slti asmTemp,s0,0x0006
0x000ecf30 bne asmTemp,r0,0x000ecf14
0x000ecf34 nop
0x000ecf38 addu s3,r0,r0
0x000ecf3c beq r0,r0,0x000ed084
0x000ecf40 addu s1,r0,r0
0x000ecf44 lui v0,0x8014
0x000ecf48 addiu v0,v0,0xd61c
0x000ecf4c addu v0,v0,s1
0x000ecf50 lh a0,0x0000(v0)
0x000ecf54 lh t0,-0x6dc0(gp)
0x000ecf58 lui v0,0x8014
0x000ecf5c addiu v0,v0,0xd610
0x000ecf60 addu v0,v0,s1
0x000ecf64 lh v1,0x0000(v0)
0x000ecf68 addiu s0,r0,0x0001
0x000ecf6c addiu a2,r0,0x000c
0x000ecf70 sll a3,s3,0x01
0x000ecf74 beq r0,r0,0x000ecfac
0x000ecf78 addu a1,t0,r0
0x000ecf7c lui v0,0x8014
0x000ecf80 addiu v0,v0,0xd610
0x000ecf84 addu v0,v0,a2
0x000ecf88 addu v0,a3,v0
0x000ecf8c lh v0,0x0000(v0)
0x000ecf90 nop
0x000ecf94 slt asmTemp,a0,v0
0x000ecf98 beq asmTemp,r0,0x000ecfa4
0x000ecf9c addu t1,v0,r0
0x000ecfa0 addu a0,t1,r0
0x000ecfa4 addi s0,s0,0x0001
0x000ecfa8 addi a2,a2,0x000c
0x000ecfac slt asmTemp,t0,s0
0x000ecfb0 beq asmTemp,r0,0x000ecf7c
0x000ecfb4 nop
0x000ecfb8 sll v0,v1,0x02
0x000ecfbc add v0,v0,v1
0x000ecfc0 sll v0,v0,0x01
0x000ecfc4 bne v0,r0,0x000ecfd0
0x000ecfc8 nop
0x000ecfcc addiu v0,r0,0x000a
0x000ecfd0 slt asmTemp,a0,v1
0x000ecfd4 bne asmTemp,r0,0x000ed01c
0x000ecfd8 nop
0x000ecfdc addi a1,a1,-0x0001
0x000ecfe0 addiu v1,gp,0x89a4
0x000ecfe4 addu v1,v1,a1
0x000ecfe8 lb v1,0x0000(v1)
0x000ecfec nop
0x000ecff0 mult a0,v1
0x000ecff4 mflo v1
0x000ecff8 add v1,v0,v1
0x000ecffc addi v1,v1,-0x0001
0x000ed000 div v1,v0
0x000ed004 lui v0,0x8014
0x000ed008 addiu v0,v0,0xd468
0x000ed00c mflo v1
0x000ed010 addu v0,v0,s1
0x000ed014 beq r0,r0,0x000ed07c
0x000ed018 sh v1,0x0000(v0)
0x000ed01c addi a1,a1,-0x0001
0x000ed020 addiu v1,gp,0x89a4
0x000ed024 addu v1,v1,a1
0x000ed028 lb v1,0x0000(v1)
0x000ed02c nop
0x000ed030 mult a0,v1
0x000ed034 mflo a0
0x000ed038 sll v1,a0,0x02
0x000ed03c add a0,v1,a0
0x000ed040 sll v1,a0,0x02
0x000ed044 add v1,a0,v1
0x000ed048 sll v1,v1,0x02
0x000ed04c div v1,v0
0x000ed050 mflo s2
0x000ed054 jal 0x000a36d4
0x000ed058 addiu a0,r0,0x0064
0x000ed05c slt asmTemp,v0,s2
0x000ed060 beq asmTemp,r0,0x000ed07c
0x000ed064 nop
0x000ed068 lui v0,0x8014
0x000ed06c addiu v0,v0,0xd468
0x000ed070 addiu v1,r0,0x0001
0x000ed074 addu v0,v0,s1
0x000ed078 sh v1,0x0000(v0)
0x000ed07c addi s3,s3,0x0001
0x000ed080 addi s1,s1,0x0002
0x000ed084 slti asmTemp,s3,0x0006
0x000ed088 bne asmTemp,r0,0x000ecf44
0x000ed08c nop
0x000ed090 addu s0,r0,r0
0x000ed094 beq r0,r0,0x000ed210
0x000ed098 addu s1,r0,r0
0x000ed09c lui v0,0x8014
0x000ed0a0 addiu v0,v0,0xd468
0x000ed0a4 addu v0,v0,s1
0x000ed0a8 lh v0,0x0000(v0)
0x000ed0ac nop
0x000ed0b0 bne v0,r0,0x000ed208
0x000ed0b4 nop
0x000ed0b8 sltiu asmTemp,s0,0x0006
0x000ed0bc beq asmTemp,r0,0x000ed1e0
0x000ed0c0 nop
0x000ed0c4 lui v1,0x8011
0x000ed0c8 addiu v1,v1,0x51e8
0x000ed0cc sll v0,s0,0x02
0x000ed0d0 addu v0,v0,v1
0x000ed0d4 lw v0,0x0000(v0)
0x000ed0d8 nop
0x000ed0dc jr v0
0x000ed0e0 nop
0x000ed0e4 lw v0,-0x6de0(gp)
0x000ed0e8 lui asmTemp,0x8015
0x000ed0ec lh v1,0x0648(v0)
0x000ed0f0 lh v0,0x57f4(asmTemp)
0x000ed0f4 nop
0x000ed0f8 sub v1,v1,v0
0x000ed0fc sll v0,v1,0x02
0x000ed100 add v1,v0,v1
0x000ed104 sll v0,v1,0x02
0x000ed108 add v1,v1,v0
0x000ed10c lui asmTemp,0x8015
0x000ed110 lh v0,0x57f0(asmTemp)
0x000ed114 sll v1,v1,0x02
0x000ed118 div v1,v0
0x000ed11c mflo s2
0x000ed120 beq r0,r0,0x000ed1e0
0x000ed124 nop
0x000ed128 lw v0,-0x6de0(gp)
0x000ed12c nop
0x000ed130 lhu v1,0x0640(v0)
0x000ed134 nop
0x000ed138 sll v0,v1,0x02
0x000ed13c add v0,v0,v1
0x000ed140 beq r0,r0,0x000ed1e0
0x000ed144 sll s2,v0,0x01
0x000ed148 lw v0,-0x6de0(gp)
0x000ed14c nop
0x000ed150 lhu v1,0x0646(v0)
0x000ed154 nop
0x000ed158 sll v0,v1,0x02
0x000ed15c add v0,v0,v1
0x000ed160 beq r0,r0,0x000ed1e0
0x000ed164 sll s2,v0,0x01
0x000ed168 lw a1,-0x6de0(gp)
0x000ed16c lui asmTemp,0x8015
0x000ed170 lh v0,0x57f4(asmTemp)
0x000ed174 lh v1,0x0648(a1)
0x000ed178 lui asmTemp,0x8015
0x000ed17c sub v1,v1,v0
0x000ed180 sll v0,v1,0x02
0x000ed184 add v1,v0,v1
0x000ed188 sll v0,v1,0x02
0x000ed18c add v1,v1,v0
0x000ed190 sll a0,v1,0x01
0x000ed194 lh v0,0x57f0(asmTemp)
0x000ed198 lhu v1,0x0642(a1)
0x000ed19c div a0,v0
0x000ed1a0 sll v0,v1,0x02
0x000ed1a4 add v0,v0,v1
0x000ed1a8 mflo a0
0x000ed1ac sll v0,v0,0x01
0x000ed1b0 beq r0,r0,0x000ed1e0
0x000ed1b4 add s2,v0,a0
0x000ed1b8 lw v1,-0x6de0(gp)
0x000ed1bc nop
0x000ed1c0 lhu a0,0x0640(v1)
0x000ed1c4 nop
0x000ed1c8 sll v0,a0,0x02
0x000ed1cc lhu v1,0x0646(v1)
0x000ed1d0 add a0,v0,a0
0x000ed1d4 sll v0,v1,0x02
0x000ed1d8 add v0,v0,v1
0x000ed1dc add s2,a0,v0
0x000ed1e0 jal 0x000a36d4
0x000ed1e4 addiu a0,r0,0x0064
0x000ed1e8 slt asmTemp,v0,s2
0x000ed1ec beq asmTemp,r0,0x000ed208
0x000ed1f0 nop
0x000ed1f4 lui v0,0x8014
0x000ed1f8 addiu v0,v0,0xd468
0x000ed1fc addiu v1,r0,0x0001
0x000ed200 addu v0,v0,s1
0x000ed204 sh v1,0x0000(v0)
0x000ed208 addi s0,s0,0x0001
0x000ed20c addi s1,s1,0x0002
0x000ed210 slti asmTemp,s0,0x0006
0x000ed214 bne asmTemp,r0,0x000ed09c
0x000ed218 nop
0x000ed21c beq r0,r0,0x000ed2f0
0x000ed220 addu s0,r0,r0
0x000ed224 lh v0,-0x6dc0(gp)
0x000ed228 nop
0x000ed22c slt asmTemp,s0,v0
0x000ed230 beq asmTemp,r0,0x000ed2e0
0x000ed234 nop
0x000ed238 lbu v0,-0x6d84(gp)
0x000ed23c addiu asmTemp,r0,0x008f
0x000ed240 bne v0,asmTemp,0x000ed258
0x000ed244 nop
0x000ed248 addiu v1,r0,0x00ff
0x000ed24c addu v0,s4,s0
0x000ed250 beq r0,r0,0x000ed2ec
0x000ed254 sb v1,0x0000(v0)
0x000ed258 lw v0,-0x6de0(gp)
0x000ed25c addiu a0,r0,0x0064
0x000ed260 addu v0,s0,v0
0x000ed264 lbu v0,0x066d(v0)
0x000ed268 nop
0x000ed26c sll v1,v0,0x02
0x000ed270 lui v0,0x8013
0x000ed274 addiu v0,v0,0xf344
0x000ed278 addu v0,v0,v1
0x000ed27c lw v0,0x0000(v0)
0x000ed280 nop
0x000ed284 lw v1,0x0000(v0)
0x000ed288 nop
0x000ed28c sll v0,v1,0x01
0x000ed290 add v0,v0,v1
0x000ed294 sll v0,v0,0x02
0x000ed298 add v0,v0,v1
0x000ed29c sll v1,v0,0x02
0x000ed2a0 lui v0,0x8013
0x000ed2a4 addiu v0,v0,0xced6
0x000ed2a8 addu v0,v0,v1
0x000ed2ac lbu s2,0x0000(v0)
0x000ed2b0 jal 0x000a36d4
0x000ed2b4 addu s1,v1,r0
0x000ed2b8 slt asmTemp,v0,s2
0x000ed2bc beq asmTemp,r0,0x000ed2e0
0x000ed2c0 nop
0x000ed2c4 lui v0,0x8013
0x000ed2c8 addiu v0,v0,0xced5
0x000ed2cc addu v0,v0,s1
0x000ed2d0 lbu v1,0x0000(v0)
0x000ed2d4 addu v0,s4,s0
0x000ed2d8 beq r0,r0,0x000ed2ec
0x000ed2dc sb v1,0x0000(v0)
0x000ed2e0 addiu v1,r0,0x00ff
0x000ed2e4 addu v0,s4,s0
0x000ed2e8 sb v1,0x0000(v0)
0x000ed2ec addi s0,s0,0x0001
0x000ed2f0 slti asmTemp,s0,0x0003
0x000ed2f4 bne asmTemp,r0,0x000ed224
0x000ed2f8 nop
0x000ed2fc lw ra,0x0024(sp)
0x000ed300 lw s4,0x0020(sp)
0x000ed304 lw s3,0x001c(sp)
0x000ed308 lw s2,0x0018(sp)
0x000ed30c lw s1,0x0014(sp)
0x000ed310 lw s0,0x0010(sp)
0x000ed314 jr ra
0x000ed318 addiu sp,sp,0x0028