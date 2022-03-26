int handleCombatStart(int interactedEntity) {
  enemyCount = 0
  
  combatHead = load(0x134D4C) // head combat data
  combatMode = readPStat(250) // 0 = normal fight, 1 = enemies defined per pstat
  
  store(combatHead + 0x66C, 1)
  store(combatHead + 0x670, 0)
  store(0x134D7C, isTriggerSet(1)) // non-runnable fight
  store(0x134E84, combatMode)
  
  if(combatMode == 1) {
    for(i = 0; i < 3; i++) {
      definedEnemy = readPStat(251 + i)
      store(stack + 0x30 + i, definedEnemy)
      
      if(definedEnemy != -1) {
        0x000E7D9C(definedEnemy, 0)
        enemyCount++
        store(combatHead + 0x66C + enemyCount, definedEnemy)
      }
    }
    
    for(i = 2; i < 10; i++) {
      for(count = 0; count < 3; count++) 
        if(load(stack + 0x30 + count) == i)
          break
      
      if(count != 3)
        continue
        
      entityPtr = load(0x12F344 + 4 * i)
      isOnScreen = load(entityPtr + 0x35) 
      
      if(isOnScreen == 0)
        store(entityPtr + 0x34, 0) // set isOnMap to false
        
      if(isInvisible(entityPtr) != 0)
        continue
        
      0x000E7D9C(entityPtr, 1)
    }
    
    return enemyCount
  }
  else {
    enemyCount++
    store(combatHead + 0x66C + enemyCount, interactedEntity)
    s6 = isScreenConcave()
    
    for(i = 2; i < 10; i++) {
      entityPtr = load(0x12F344 + 4 * i)
      
      if(entityPtr == 0)
        continue
        
      isOnMap = load(entityPtr + 0x34)
      
      if(isOnMap == 0)
        continue
      
      if(i == interactedEntity) {
        0x000E7D9C(i, 0)
        continue
      }
      else {
        isOnScreen = load(0x15578D + 0x68 * i)
        
        if(isOnScreen == 0) {
          store(0x15578C, 0) // set isOnMap to false
          continue
        }
        else if(enemyCount == 3) {
          0x000E7D9C(i, 1)
          continue
        }
        else if(s6 != 0) {
          a0, a1 = getEntityTileFromModel(load(0x12F344))
          a2, a3 = getEntityTileFromModel(entityPtr)
          
          if(isPathBetween(a0, a1, a2, a3) != 0) {
            0x000E7D9C(i, 1)
            continue
          }
          
          a0, a1 = getEntityTileFromModel(load(0x12F348))
          
          if(isPathBetween(a0, a1, a2, a3) != 0) {
            0x000E7D9C(i, 1)
            continue
          }
        }
        
        rolledValue = random(100)
        inventorySize = load(0x13D4CE) // inventory size
        hasRepel = 0
        hasBell = 0
        
        for(a0 = 0; a0 < inventorySize; a0++) {
          itemId = load(0x13D474 + a0)
          if(itemId == 35)
            hasBell = 1
          if(itemId == 36)
            hasRepel = 1
        }
        
        if(hasRepel == 1)
          rolledValue += 20
        else if(hasBell == 1)
          rolledValue -= 50
                
        if(load(0x134D7C) != 0) // is non-runnable fight
          rolledValue = 0
        
        ownDigimon = load(0x1557A8)
        runsAway = 1 // run away
        ownDigimonType = load(0x12CED0 + ownDigimonType * 52) - 1
        
        if(ownDigimonType != -1) {
          enemyDigimon = load(0x155758 + 0x68 * i)
          enemyDigimonType = load(0x12CED0 + enemyDigimon * 52) - 1
          
          chance = load(0x12BB14 + ownDigimonType * 3 + enemyDigimonType)
          
          if(rolledValue >= chance) {
            enemyCount++
            store(combatHead + 0x66C + enemyCount, i)
            runsAway = 0 // fight
          }
        }
        else {
          if(random(100) >= 80) {
            enemyCount++
            store(combatHead + 0x66C + enemyCount, i)
            runsAway = 0 // fight
          }
        }
        0x000E7D9C(i, runsAway)
      }
    }
  }
  
  return enemyCount
}


0x000e847c addiu sp,sp,0xffc8
0x000e8480 sw ra,0x002c(sp)
0x000e8484 sw s6,0x0028(sp)
0x000e8488 sw s5,0x0024(sp)
0x000e848c sw s4,0x0020(sp)
0x000e8490 sw s3,0x001c(sp)
0x000e8494 sw s2,0x0018(sp)
0x000e8498 sw s1,0x0014(sp)
0x000e849c addu s5,a0,r0
0x000e84a0 lw v0,-0x6de0(gp)
0x000e84a4 sw s0,0x0010(sp)
0x000e84a8 addiu a0,r0,0x0001
0x000e84ac sb a0,0x066c(v0)
0x000e84b0 lw v0,-0x6de0(gp)
0x000e84b4 nop
0x000e84b8 sb r0,0x0670(v0)
0x000e84bc jal 0x0010643c
0x000e84c0 addu s2,r0,r0
0x000e84c4 sw v0,-0x6db0(gp)
0x000e84c8 jal 0x001062e0
0x000e84cc addiu a0,r0,0x00fa
0x000e84d0 sb v0,-0x6ca8(gp)
0x000e84d4 lbu v0,-0x6ca8(gp)
0x000e84d8 addiu asmTemp,r0,0x0001
0x000e84dc bne v0,asmTemp,0x000e85fc
0x000e84e0 nop
0x000e84e4 addu s0,r0,r0
0x000e84e8 beq r0,r0,0x000e8538
0x000e84ec addiu s3,r0,0x00fb
0x000e84f0 jal 0x001062e0
0x000e84f4 andi a0,s3,0x00ff
0x000e84f8 addu v1,sp,s0
0x000e84fc sb v0,0x0030(v1)
0x000e8500 lbu v0,0x0030(v1)
0x000e8504 addiu asmTemp,r0,0x00ff
0x000e8508 beq v0,asmTemp,0x000e8530
0x000e850c addu s1,v0,r0
0x000e8510 addu a0,s1,r0
0x000e8514 jal 0x000e7d9c
0x000e8518 addu a1,r0,r0
0x000e851c addi v0,s2,0x0001
0x000e8520 lw v1,-0x6de0(gp)
0x000e8524 addu s2,v0,r0
0x000e8528 addu v0,v0,v1
0x000e852c sb s1,0x066c(v0)
0x000e8530 addi s0,s0,0x0001
0x000e8534 addi s3,s3,0x0001
0x000e8538 slti asmTemp,s0,0x0003
0x000e853c bne asmTemp,r0,0x000e84f0
0x000e8540 nop
0x000e8544 addiu s0,r0,0x0002
0x000e8548 beq r0,r0,0x000e85e8
0x000e854c addiu s1,r0,0x0008
0x000e8550 beq r0,r0,0x000e8570
0x000e8554 addu a0,r0,r0
0x000e8558 addu v0,sp,a0
0x000e855c lbu v0,0x0030(v0)
0x000e8560 nop
0x000e8564 beq v0,s0,0x000e857c
0x000e8568 nop
0x000e856c addi a0,a0,0x0001
0x000e8570 slti asmTemp,a0,0x0003
0x000e8574 bne asmTemp,r0,0x000e8558
0x000e8578 nop
0x000e857c addiu asmTemp,r0,0x0003
0x000e8580 bne a0,asmTemp,0x000e85e0
0x000e8584 nop
0x000e8588 lui v0,0x8013
0x000e858c addiu v0,v0,0xf344
0x000e8590 addu v0,v0,s1
0x000e8594 lw v1,0x0000(v0)
0x000e8598 nop
0x000e859c lb v0,0x0035(v1)
0x000e85a0 nop
0x000e85a4 bne v0,r0,0x000e85b0
0x000e85a8 nop
0x000e85ac sb r0,0x0034(v1)
0x000e85b0 lui v0,0x8013
0x000e85b4 addiu v0,v0,0xf344
0x000e85b8 addu v0,v0,s1
0x000e85bc lw a0,0x0000(v0)
0x000e85c0 jal 0x000e61ac
0x000e85c4 nop
0x000e85c8 bne v0,r0,0x000e85e0
0x000e85cc nop
0x000e85d0 sll a0,s0,0x10
0x000e85d4 sra a0,a0,0x10
0x000e85d8 jal 0x000e7d9c
0x000e85dc addiu a1,r0,0x0001
0x000e85e0 addi s0,s0,0x0001
0x000e85e4 addi s1,s1,0x0004
0x000e85e8 slti asmTemp,s0,0x000a
0x000e85ec bne asmTemp,r0,0x000e8550
0x000e85f0 nop
0x000e85f4 beq r0,r0,0x000e8948
0x000e85f8 addu v0,s2,r0
0x000e85fc addi v0,s2,0x0001
0x000e8600 lw v1,-0x6de0(gp)
0x000e8604 addu s2,v0,r0
0x000e8608 addu v0,v0,v1
0x000e860c sb s5,0x066c(v0)
0x000e8610 jal 0x000e7484
0x000e8614 nop
0x000e8618 addu s6,v0,r0
0x000e861c addiu s0,r0,0x0002
0x000e8620 addiu s4,r0,0x0008
0x000e8624 beq r0,r0,0x000e8938
0x000e8628 addiu s3,r0,0x00d0
0x000e862c lui v0,0x8013
0x000e8630 addiu v0,v0,0xf344
0x000e8634 addu v0,v0,s4
0x000e8638 lw v0,0x0000(v0)
0x000e863c nop
0x000e8640 beq v0,r0,0x000e892c
0x000e8644 addu v1,v0,r0
0x000e8648 lb v0,0x0034(v1)
0x000e864c nop
0x000e8650 beq v0,r0,0x000e892c
0x000e8654 nop
0x000e8658 bne s0,s5,0x000e8678
0x000e865c nop
0x000e8660 sll a0,s0,0x10
0x000e8664 sra a0,a0,0x10
0x000e8668 jal 0x000e7d9c
0x000e866c addu a1,r0,r0
0x000e8670 beq r0,r0,0x000e8930
0x000e8674 addi s0,s0,0x0001
0x000e8678 lui v0,0x8015
0x000e867c addiu v0,v0,0x578d
0x000e8680 addu v0,v0,s3
0x000e8684 lb v0,0x0000(v0)
0x000e8688 nop
0x000e868c bne v0,r0,0x000e86a8
0x000e8690 nop
0x000e8694 lui v0,0x8015
0x000e8698 addiu v0,v0,0x578c
0x000e869c addu v0,v0,s3
0x000e86a0 beq r0,r0,0x000e892c
0x000e86a4 sb r0,0x0000(v0)
0x000e86a8 addiu asmTemp,r0,0x0003
0x000e86ac bne s2,asmTemp,0x000e86cc
0x000e86b0 nop
0x000e86b4 sll a0,s0,0x10
0x000e86b8 sra a0,a0,0x10
0x000e86bc jal 0x000e7d9c
0x000e86c0 addiu a1,r0,0x0001
0x000e86c4 beq r0,r0,0x000e8930
0x000e86c8 addi s0,s0,0x0001
0x000e86cc beq s6,r0,0x000e8788
0x000e86d0 nop
0x000e86d4 lui asmTemp,0x8013
0x000e86d8 lw a0,-0x0cbc(asmTemp)
0x000e86dc addiu a1,sp,0x0034
0x000e86e0 jal 0x000d3aec
0x000e86e4 addiu a2,sp,0x0035
0x000e86e8 lui v0,0x8013
0x000e86ec addiu v0,v0,0xf344
0x000e86f0 addu v0,v0,s4
0x000e86f4 lw a0,0x0000(v0)
0x000e86f8 addiu a1,sp,0x0036
0x000e86fc jal 0x000d3aec
0x000e8700 addiu a2,sp,0x0037
0x000e8704 lb a0,0x0034(sp)
0x000e8708 lb a1,0x0035(sp)
0x000e870c lb a2,0x0036(sp)
0x000e8710 lb a3,0x0037(sp)
0x000e8714 jal 0x000d3c70
0x000e8718 nop
0x000e871c beq v0,r0,0x000e873c
0x000e8720 nop
0x000e8724 sll a0,s0,0x10
0x000e8728 sra a0,a0,0x10
0x000e872c jal 0x000e7d9c
0x000e8730 addiu a1,r0,0x0001
0x000e8734 beq r0,r0,0x000e8930
0x000e8738 addi s0,s0,0x0001
0x000e873c lui asmTemp,0x8013
0x000e8740 lw a0,-0x0cb8(asmTemp)
0x000e8744 addiu a1,sp,0x0034
0x000e8748 jal 0x000d3aec
0x000e874c addiu a2,sp,0x0035
0x000e8750 lb a0,0x0034(sp)
0x000e8754 lb a1,0x0035(sp)
0x000e8758 lb a2,0x0036(sp)
0x000e875c lb a3,0x0037(sp)
0x000e8760 jal 0x000d3c70
0x000e8764 nop
0x000e8768 beq v0,r0,0x000e8788
0x000e876c nop
0x000e8770 sll a0,s0,0x10
0x000e8774 sra a0,a0,0x10
0x000e8778 jal 0x000e7d9c
0x000e877c addiu a1,r0,0x0001
0x000e8780 beq r0,r0,0x000e8930
0x000e8784 addi s0,s0,0x0001
0x000e8788 jal 0x000a36d4
0x000e878c addiu a0,r0,0x0064
0x000e8790 lui asmTemp,0x8014
0x000e8794 lbu a3,-0x2b32(asmTemp)
0x000e8798 addu a2,r0,r0
0x000e879c addu a1,r0,r0
0x000e87a0 beq r0,r0,0x000e87dc
0x000e87a4 addu a0,r0,r0
0x000e87a8 lui v1,0x8014
0x000e87ac addiu v1,v1,0xd474
0x000e87b0 addu v1,v1,a0
0x000e87b4 lbu v1,0x0000(v1)
0x000e87b8 addiu asmTemp,r0,0x0023
0x000e87bc bne v1,asmTemp,0x000e87c8
0x000e87c0 addu t0,v1,r0
0x000e87c4 addiu a1,r0,0x0001
0x000e87c8 addiu asmTemp,r0,0x0024
0x000e87cc bne t0,asmTemp,0x000e87d8
0x000e87d0 nop
0x000e87d4 addiu a2,r0,0x0001
0x000e87d8 addi a0,a0,0x0001
0x000e87dc slt asmTemp,a0,a3
0x000e87e0 bne asmTemp,r0,0x000e87a8
0x000e87e4 nop
0x000e87e8 addiu asmTemp,r0,0x0001
0x000e87ec beq a1,asmTemp,0x000e8800
0x000e87f0 nop
0x000e87f4 addiu asmTemp,r0,0x0001
0x000e87f8 bne a2,asmTemp,0x000e8818
0x000e87fc nop
0x000e8800 addiu asmTemp,r0,0x0001
0x000e8804 bne a2,asmTemp,0x000e8814
0x000e8808 nop
0x000e880c beq r0,r0,0x000e8818
0x000e8810 addi v0,v0,-0x0032
0x000e8814 addi v0,v0,0x0014
0x000e8818 lw v1,-0x6db0(gp)
0x000e881c nop
0x000e8820 beq v1,r0,0x000e882c
0x000e8824 nop
0x000e8828 addu v0,r0,r0
0x000e882c lui asmTemp,0x8015
0x000e8830 addiu v1,r0,0x0001
0x000e8834 lw a0,0x57a8(asmTemp)
0x000e8838 sll s1,v1,0x10
0x000e883c sll v1,a0,0x01
0x000e8840 add v1,v1,a0
0x000e8844 sll v1,v1,0x02
0x000e8848 add v1,v1,a0
0x000e884c sll a0,v1,0x02
0x000e8850 lui v1,0x8013
0x000e8854 addiu v1,v1,0xced0
0x000e8858 addu a0,v1,a0
0x000e885c lbu a1,0x0000(a0)
0x000e8860 sra s1,s1,0x10
0x000e8864 addiu asmTemp,r0,0x00ff
0x000e8868 beq a1,asmTemp,0x000e88f0
0x000e886c addu a0,a1,r0
0x000e8870 lui a1,0x8015
0x000e8874 addiu a1,a1,0x5758
0x000e8878 addu a1,a1,s3
0x000e887c lw a2,0x0000(a1)
0x000e8880 addi a0,a0,-0x0001
0x000e8884 sll a1,a2,0x01
0x000e8888 add a1,a1,a2
0x000e888c sll a1,a1,0x02
0x000e8890 add a1,a1,a2
0x000e8894 sll a1,a1,0x02
0x000e8898 addu v1,v1,a1
0x000e889c lbu v1,0x0000(v1)
0x000e88a0 nop
0x000e88a4 addi a1,v1,-0x0001
0x000e88a8 sll v1,a0,0x01
0x000e88ac add a0,v1,a0
0x000e88b0 lui v1,0x8013
0x000e88b4 addiu v1,v1,0xbb14
0x000e88b8 addu v1,v1,a0
0x000e88bc addu v1,a1,v1
0x000e88c0 lbu v1,0x0000(v1)
0x000e88c4 nop
0x000e88c8 slt asmTemp,v0,v1
0x000e88cc beq asmTemp,r0,0x000e891c
0x000e88d0 nop
0x000e88d4 addi v0,s2,0x0001
0x000e88d8 lw v1,-0x6de0(gp)
0x000e88dc addu s2,v0,r0
0x000e88e0 addu v0,v0,v1
0x000e88e4 sb s0,0x066c(v0)
0x000e88e8 beq r0,r0,0x000e891c
0x000e88ec addu s1,r0,r0
0x000e88f0 jal 0x000a36d4
0x000e88f4 addiu a0,r0,0x0064
0x000e88f8 slti asmTemp,v0,0x0046
0x000e88fc beq asmTemp,r0,0x000e891c
0x000e8900 nop
0x000e8904 addi v0,s2,0x0001
0x000e8908 lw v1,-0x6de0(gp)
0x000e890c addu s2,v0,r0
0x000e8910 addu v0,v0,v1
0x000e8914 sb s0,0x066c(v0)
0x000e8918 addu s1,r0,r0
0x000e891c sll a0,s0,0x10
0x000e8920 sra a0,a0,0x10
0x000e8924 jal 0x000e7d9c
0x000e8928 addu a1,s1,r0
0x000e892c addi s0,s0,0x0001
0x000e8930 addi s3,s3,0x0068
0x000e8934 addi s4,s4,0x0004
0x000e8938 slti asmTemp,s0,0x000a
0x000e893c bne asmTemp,r0,0x000e862c
0x000e8940 nop
0x000e8944 addu v0,s2,r0
0x000e8948 lw ra,0x002c(sp)
0x000e894c lw s6,0x0028(sp)
0x000e8950 lw s5,0x0024(sp)
0x000e8954 lw s4,0x0020(sp)
0x000e8958 lw s3,0x001c(sp)
0x000e895c lw s2,0x0018(sp)
0x000e8960 lw s1,0x0014(sp)
0x000e8964 lw s0,0x0010(sp)
0x000e8968 jr ra
0x000e896c addiu sp,sp,0x0038
