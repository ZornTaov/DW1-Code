combatInitEntityPositions() {
  combatHead = load(0x134D4C)
  flags = load(combatHead + 0x34)
  
  startBattleIdleAnimation(0x1557A8, 0x1557E0, flags) // partner Digimon
  
  enemyId1 = load(combatHead + 0x066D) // enemy ID #1
  enemyPtr = load(0x12F344 + enemyId1 * 4)
  somePtr = load(enemyPtr + 0x04)
  
  entityLookAtLocation(0x1557A8, somePtr + 0x78) // partner Digimon to enemy Digimon #1
  initializeBattleText()
  
  playerPtr = load(0x12F344)
  partnerPtr = load(0x12F348)
  
  fleeingEnemyCount = 0
  fleeingEnemyArray = short[4]
  
  for(entityId = 2; entityId < 10; entityId++) {
    entitiyPtr = load(0x12F344 + entityId * 4)
    
    if(isInvisible(enemyPtr) != 0)
      continue
    
    enemyCount = load(0x134D6C)
    
    for(combatId = 1; combatId <= enemyCount; combatId++)
      if(load(combatHead + 0x066C + combatId) == entityId)
        break
    
    if(combatId != enemyCount + 1)
      continue
    
    // -> is fleeing
    startAnimation(entitiyPtr, 0x24) // fast walk animation
    
    store(entitiyPtr + 0x30, load(entitiyPtr + 0x30) | 0x0004)
    
    tempArray = short[4]
    tempArray[0] = load(entitiyPtr + 0x58)
    tempArray[1] = load(entitiyPtr + 0x5A)
    tempArray[2] = load(entitiyPtr + 0x5C)
    tempArray[3] = load(entitiyPtr + 0x5E)
    
    positionArray = int[3]
    positionArray[0] = tempArray[0]
    positionArray[1] = tempArray[1]
    positionArray[2] = tempArray[2]
    
    entityLookAtLocation(entitiyPtr, positionArray)
    
    fleeingEnemyArray[fleeingEnemyCount++] = entityId
    store(sp + 0x34 + fleeingEnemyCount++ * 2, entityId)
  }
  
  hasNoFleeingEnemies = fleeingEnemyCount == 0 ? 1 : 0 // has fleeing enemies
  
  waypointCount = load(0x134D53) - 1
  store(0x134D50, 0)
  
  startAnimation(0x15576C, 3) // set Hiro running
  playSound(0, 0x10)
  
  someValue = 0
  
  for(frameCount = 0; frameCount < 0xC8 || hasNoFleeingEnemies == 0 || someValue == 0; frameCount++) {
    
    // walk Hiro to combat position
    if(load(playerPtr + 0x2E) != 1) { // is not in battle idle animation
      locationPtr = load(playerPtr + 0x04) + 0x78
      
      tileX, tileY = getModelTile(locationPtr)
      
      if(waypointCount >= 0) { // has waypoints left
        lTileX = load(0x13D5B0 + waypointCount)
        lTileY = load(0x13D590 + waypointCount)
        
        entityLookAtTile(playerPtr, lTileX, lTileY)
        
        if(tileX == lTileX && tileX == lTileY) {
          waypointCount--
          store(0x134D53, load(0x134D53) - 1)
        }
        
        collisionResponse = entityCheckCollision(partnerPtr, playerPtr, 310, 230)
      }
      else {
        lTileX = load(0x134D52)
        lTileY = load(0x134D51)
        entityLookAtTile(playerPtr, lTileX, lTileY)
        
        if(tileX == lTileX && tileY == lTileY)
          collisionResponse = 11
        else
          collisionResponse = entityCheckCollision(partnerPtr, playerPtr, 300, 220)
      }
    }
    
    // pointless?
    if(waypointCount == -1) {
      enemyCount = load(0x134D6C) // enemy count
      
      for(i = 1; enemyCount < i; i++);
    }
    
    // Hiro is at his spot
    if(collisionResponse == 11 && load(playerPtr + 0x2E) != 1) {
      startAnimation(playerPtr, 1) // set him idle
      
      // make him look at the partner Digimon
      entityLookAtLocation(playerPtr, load(partnerPtr + 0x04) + 0x78)
      
      // tell the loop to come to an end
      frameCount = 0xC6
    }
    
    for(entityCounter = 0; entityCounter < fleeingEnemyCount; entityCounter++) {
      entityPtr = load(0x12F344 + fleeingEnemyArray[entityCounter] * 4)
      
      if(entityIsOffScreen(entityPtr, 320, 240) == 0)
        break
    }
    
    if(entityCounter == fleeingEnemyCount)
      hasNoFleeingEnemies = 1
      
    someValue = load(0x1350C0) // deferred via 0x00063EF0()
    0x000D4034() // TODO name, some waypoint stuff
    
    // let partner look at enemy #1
    enemyId = load(combatHead + 0x066D)
    enemyPtr = load(0x12F344 + enemyId * 4)
    locationPtr = load(enemyPtr + 0x04)
    entityLookAtLocation(0x1557A8, locationPtr + 0x78)
    battleTickFrame()
  }
  
  if(waypointCount != -1) {
    store(0x134D53, waypointCount + 1)
    store(0x134D50, load(0x134D53) - 1)
  }
  else
    clearWaypointCounter()
  
  if(load(playerPtr + 0x2E) != 1) { // active Animation
    startAnimation(playerPtr, 1)
    partnerLocPtr = load(partnerPtr + 0x04)
    entityLookAtLocation(playerPtr, partnerLocPtr + 0x78)
  }
  
  for(entityCounter = 0; entityCounter < fleeingEnemyCount; entityCounter++) {
    entityPtr = load(0x12F344 + fleeingEnemyArray[entityCounter] * 4)
    
    store(entityPtr + 0x34, 0)
    store(entityPtr + 0x30, load(v1 + 0x30) & 0xFB)
  }
  
  unsetObject(0x1A6, 0) // deferred via 0x00063A20()
  
  // deferred via 0x00063A2C()
  store(0x1350C0, 0)
  setObject(0x1A6, 0, 0, 0x63A48)
  //
  
  playSound(0, 0x11)
  
  while(load(0x1350C0) == 0) // deferred via 0x00063EF0()
    battleTickFrame()
  
  unsetObject(0x1A6, 0) // deferred via 0x00063EE4()
  store(0x134F0A, 1)
  
  return 1
}

0x0005736c addiu sp,sp,0xffa0
0x00057370 sw ra,0x002c(sp)
0x00057374 sw s6,0x0028(sp)
0x00057378 sw s5,0x0024(sp)
0x0005737c sw s4,0x0020(sp)
0x00057380 sw s3,0x001c(sp)
0x00057384 sw s2,0x0018(sp)
0x00057388 sw s1,0x0014(sp)
0x0005738c lui a0,0x8015
0x00057390 lui a1,0x8015
0x00057394 lw v0,-0x6de0(gp)
0x00057398 sw s0,0x0010(sp)
0x0005739c lhu a2,0x0034(v0)
0x000573a0 addiu a0,a0,0x57a8
0x000573a4 jal 0x000e8970
0x000573a8 addiu a1,a1,0x57e0
0x000573ac lw v0,-0x6de0(gp)
0x000573b0 lui a0,0x8015
0x000573b4 lbu v0,0x066d(v0)
0x000573b8 addiu a0,a0,0x57a8
0x000573bc sll v1,v0,0x02
0x000573c0 lui v0,0x8013
0x000573c4 addiu v0,v0,0xf344
0x000573c8 addu v0,v0,v1
0x000573cc lw v0,0x0000(v0)
0x000573d0 nop
0x000573d4 lw v0,0x0004(v0)
0x000573d8 jal 0x000d459c
0x000573dc addiu a1,v0,0x0078
0x000573e0 jal 0x00063170
0x000573e4 nop
0x000573e8 addu s2,r0,r0
0x000573ec addiu s0,r0,0x0002
0x000573f0 beq r0,r0,0x000574e0
0x000573f4 addiu s4,r0,0x0008
0x000573f8 lui v0,0x8013
0x000573fc addiu v0,v0,0xf344
0x00057400 addu v0,v0,s4
0x00057404 lw s1,0x0000(v0)
0x00057408 jal 0x000e61ac
0x0005740c addu a0,s1,r0
0x00057410 bne v0,r0,0x000574d8
0x00057414 nop
0x00057418 lh a1,-0x6dc0(gp)
0x0005741c lw a0,-0x6de0(gp)
0x00057420 addiu v1,r0,0x0001
0x00057424 beq r0,r0,0x00057444
0x00057428 addu a2,a1,r0
0x0005742c addu v0,v1,a0
0x00057430 lbu v0,0x066c(v0)
0x00057434 nop
0x00057438 beq v0,s0,0x00057450
0x0005743c nop
0x00057440 addi v1,v1,0x0001
0x00057444 slt asmTemp,a1,v1
0x00057448 beq asmTemp,r0,0x0005742c
0x0005744c nop
0x00057450 addi v0,a2,0x0001
0x00057454 bne v1,v0,0x000574d8
0x00057458 nop
0x0005745c addu a0,s1,r0
0x00057460 jal 0x000c1a04
0x00057464 addiu a1,r0,0x0024
0x00057468 lbu v0,0x0030(s1)
0x0005746c nop
0x00057470 ori v0,v0,0x0004
0x00057474 sb v0,0x0030(s1)
0x00057478 lh a1,0x0058(s1)
0x0005747c lh a0,0x005a(s1)
0x00057480 lh v1,0x005c(s1)
0x00057484 lh v0,0x005e(s1)
0x00057488 sh a1,0x0054(sp)
0x0005748c sh a0,0x0056(sp)
0x00057490 sh v1,0x0058(sp)
0x00057494 sh v0,0x005a(sp)
0x00057498 lh v0,0x0054(sp)
0x0005749c addu a0,s1,r0
0x000574a0 sw v0,0x0044(sp)
0x000574a4 lh v0,0x0056(sp)
0x000574a8 nop
0x000574ac sw v0,0x0048(sp)
0x000574b0 lh v0,0x0058(sp)
0x000574b4 nop
0x000574b8 sw v0,0x004c(sp)
0x000574bc jal 0x000d459c
0x000574c0 addiu a1,sp,0x0044
0x000574c4 addu v0,s2,r0
0x000574c8 addi s2,v0,0x0001
0x000574cc sll v0,v0,0x01
0x000574d0 addu v0,sp,v0
0x000574d4 sh s0,0x0034(v0)
0x000574d8 addi s0,s0,0x0001
0x000574dc addi s4,s4,0x0004
0x000574e0 slti asmTemp,s0,0x000a
0x000574e4 bne asmTemp,r0,0x000573f8
0x000574e8 nop
0x000574ec addu s5,r0,r0
0x000574f0 bne s2,r0,0x00057500
0x000574f4 addu s0,r0,r0
0x000574f8 beq r0,r0,0x00057504
0x000574fc addiu s6,r0,0x0001
0x00057500 addu s6,r0,r0
0x00057504 lb v0,-0x6dd9(gp)
0x00057508 lui a0,0x8015
0x0005750c addi v0,v0,-0x0001
0x00057510 sll s4,v0,0x10
0x00057514 sra s4,s4,0x10
0x00057518 sb r0,-0x6ddc(gp)
0x0005751c addiu a0,a0,0x576c
0x00057520 jal 0x000c1a04
0x00057524 addiu a1,r0,0x0003
0x00057528 addu a0,r0,r0
0x0005752c jal 0x000c6374
0x00057530 addiu a1,r0,0x0010
0x00057534 beq r0,r0,0x000577c8
0x00057538 slti asmTemp,s5,0x00c8
0x0005753c lui asmTemp,0x8013
0x00057540 lw v1,-0x0cbc(asmTemp)
0x00057544 nop
0x00057548 lbu v0,0x002e(v1)
0x0005754c addiu asmTemp,r0,0x0001
0x00057550 beq v0,asmTemp,0x0005769c
0x00057554 nop
0x00057558 lw v0,0x0004(v1)
0x0005755c addiu a1,sp,0x005c
0x00057560 addiu a0,v0,0x0078
0x00057564 jal 0x000c0f28
0x00057568 addiu a2,sp,0x005e
0x0005756c bltz s4,0x00057628
0x00057570 nop
0x00057574 lui v0,0x8014
0x00057578 lui asmTemp,0x8013
0x0005757c addu s0,s4,r0
0x00057580 addiu v0,v0,0xd5b0
0x00057584 addu v0,v0,s0
0x00057588 lb a1,0x0000(v0)
0x0005758c lw a0,-0x0cbc(asmTemp)
0x00057590 lui v0,0x8014
0x00057594 addiu v0,v0,0xd590
0x00057598 addu v0,v0,s0
0x0005759c lb a2,0x0000(v0)
0x000575a0 jal 0x000e6078
0x000575a4 nop
0x000575a8 lui v0,0x8014
0x000575ac addiu v0,v0,0xd5b0
0x000575b0 addu v0,v0,s0
0x000575b4 lh v1,0x005c(sp)
0x000575b8 lb v0,0x0000(v0)
0x000575bc nop
0x000575c0 bne v1,v0,0x00057600
0x000575c4 nop
0x000575c8 lui v0,0x8014
0x000575cc addiu v0,v0,0xd590
0x000575d0 addu v0,v0,s0
0x000575d4 lh v1,0x005e(sp)
0x000575d8 lb v0,0x0000(v0)
0x000575dc nop
0x000575e0 bne v1,v0,0x00057600
0x000575e4 nop
0x000575e8 addi v0,s4,-0x0001
0x000575ec sll s4,v0,0x10
0x000575f0 lb v0,-0x6dd9(gp)
0x000575f4 sra s4,s4,0x10
0x000575f8 addi v0,v0,-0x0001
0x000575fc sb v0,-0x6dd9(gp)
0x00057600 lui asmTemp,0x8013
0x00057604 lw a0,-0x0cb8(asmTemp)
0x00057608 addiu a2,r0,0x0136
0x0005760c lui asmTemp,0x8013
0x00057610 lw a1,-0x0cbc(asmTemp)
0x00057614 jal 0x000d45ec
0x00057618 addiu a3,r0,0x00e6
0x0005761c sll s3,v0,0x10
0x00057620 beq r0,r0,0x0005769c
0x00057624 sra s3,s3,0x10
0x00057628 lui asmTemp,0x8013
0x0005762c lb a1,-0x6dda(gp)
0x00057630 lb a2,-0x6ddb(gp)
0x00057634 lw a0,-0x0cbc(asmTemp)
0x00057638 jal 0x000e6078
0x0005763c nop
0x00057640 lh v1,0x005c(sp)
0x00057644 lb v0,-0x6dda(gp)
0x00057648 nop
0x0005764c bne v1,v0,0x00057678
0x00057650 nop
0x00057654 lh v1,0x005e(sp)
0x00057658 lb v0,-0x6ddb(gp)
0x0005765c nop
0x00057660 bne v1,v0,0x00057678
0x00057664 nop
0x00057668 addiu v0,r0,0x000b
0x0005766c sll s3,v0,0x10
0x00057670 beq r0,r0,0x0005769c
0x00057674 sra s3,s3,0x10
0x00057678 lui asmTemp,0x8013
0x0005767c lw a0,-0x0cb8(asmTemp)
0x00057680 addiu a2,r0,0x012c
0x00057684 lui asmTemp,0x8013
0x00057688 lw a1,-0x0cbc(asmTemp)
0x0005768c jal 0x000d45ec
0x00057690 addiu a3,r0,0x00dc
0x00057694 sll s3,v0,0x10
0x00057698 sra s3,s3,0x10
0x0005769c addiu asmTemp,r0,0xffff
0x000576a0 bne s4,asmTemp,0x000576c4
0x000576a4 nop
0x000576a8 lh v0,-0x6dc0(gp)
0x000576ac beq r0,r0,0x000576b8
0x000576b0 addiu s0,r0,0x0001
0x000576b4 addi s0,s0,0x0001
0x000576b8 slt asmTemp,v0,s0
0x000576bc beq asmTemp,r0,0x000576b4
0x000576c0 nop
0x000576c4 addiu asmTemp,r0,0x000b
0x000576c8 bne s3,asmTemp,0x00057718
0x000576cc nop
0x000576d0 lui asmTemp,0x8013
0x000576d4 lw a0,-0x0cbc(asmTemp)
0x000576d8 nop
0x000576dc lbu v0,0x002e(a0)
0x000576e0 addiu asmTemp,r0,0x0001
0x000576e4 beq v0,asmTemp,0x00057718
0x000576e8 nop
0x000576ec jal 0x000c1a04
0x000576f0 addiu a1,r0,0x0001
0x000576f4 lui asmTemp,0x8013
0x000576f8 lw v0,-0x0cb8(asmTemp)
0x000576fc nop
0x00057700 lw v0,0x0004(v0)
0x00057704 lui asmTemp,0x8013
0x00057708 lw a0,-0x0cbc(asmTemp)
0x0005770c jal 0x000d459c
0x00057710 addiu a1,v0,0x0078
0x00057714 addiu s5,r0,0x00c6
0x00057718 addi s5,s5,0x0001
0x0005771c addu s0,r0,r0
0x00057720 beq r0,r0,0x00057760
0x00057724 addu s1,r0,r0
0x00057728 addu v0,sp,s1
0x0005772c lh v0,0x0034(v0)
0x00057730 addiu a1,r0,0x0140
0x00057734 sll v1,v0,0x02
0x00057738 lui v0,0x8013
0x0005773c addiu v0,v0,0xf344
0x00057740 addu v0,v0,v1
0x00057744 lw a0,0x0000(v0)
0x00057748 jal 0x000d5430
0x0005774c addiu a2,r0,0x00f0
0x00057750 beq v0,r0,0x0005776c
0x00057754 nop
0x00057758 addi s0,s0,0x0001
0x0005775c addi s1,s1,0x0002
0x00057760 slt asmTemp,s0,s2
0x00057764 bne asmTemp,r0,0x00057728
0x00057768 nop
0x0005776c bne s0,s2,0x00057778
0x00057770 nop
0x00057774 addiu s6,r0,0x0001
0x00057778 jal 0x00063ef0
0x0005777c nop
0x00057780 jal 0x000d4034
0x00057784 addu s0,v0,r0
0x00057788 lw v0,-0x6de0(gp)
0x0005778c lui a0,0x8015
0x00057790 lbu v0,0x066d(v0)
0x00057794 addiu a0,a0,0x57a8
0x00057798 sll v1,v0,0x02
0x0005779c lui v0,0x8013
0x000577a0 addiu v0,v0,0xf344
0x000577a4 addu v0,v0,v1
0x000577a8 lw v0,0x0000(v0)
0x000577ac nop
0x000577b0 lw v0,0x0004(v0)
0x000577b4 jal 0x000d459c
0x000577b8 addiu a1,v0,0x0078
0x000577bc jal 0x0005dec4
0x000577c0 nop
0x000577c4 slti asmTemp,s5,0x00c8
0x000577c8 bne asmTemp,r0,0x0005753c
0x000577cc nop
0x000577d0 beq s6,r0,0x0005753c
0x000577d4 nop
0x000577d8 beq s0,r0,0x0005753c
0x000577dc nop
0x000577e0 addiu asmTemp,r0,0xffff
0x000577e4 beq s4,asmTemp,0x00057808
0x000577e8 nop
0x000577ec addi v0,s4,0x0001
0x000577f0 sb v0,-0x6dd9(gp)
0x000577f4 lb v0,-0x6dd9(gp)
0x000577f8 nop
0x000577fc addi v0,v0,-0x0001
0x00057800 beq r0,r0,0x00057810
0x00057804 sb v0,-0x6ddc(gp)
0x00057808 jal 0x000d3adc
0x0005780c nop
0x00057810 lui asmTemp,0x8013
0x00057814 lw a0,-0x0cbc(asmTemp)
0x00057818 nop
0x0005781c lbu v0,0x002e(a0)
0x00057820 addiu asmTemp,r0,0x0001
0x00057824 beq v0,asmTemp,0x00057854
0x00057828 nop
0x0005782c jal 0x000c1a04
0x00057830 addiu a1,r0,0x0001
0x00057834 lui asmTemp,0x8013
0x00057838 lw v0,-0x0cb8(asmTemp)
0x0005783c nop
0x00057840 lw v0,0x0004(v0)
0x00057844 lui asmTemp,0x8013
0x00057848 lw a0,-0x0cbc(asmTemp)
0x0005784c jal 0x000d459c
0x00057850 addiu a1,v0,0x0078
0x00057854 addu s0,r0,r0
0x00057858 beq r0,r0,0x000578a0
0x0005785c addu a0,r0,r0
0x00057860 addu v0,sp,a0
0x00057864 lh v0,0x0034(v0)
0x00057868 addi s0,s0,0x0001
0x0005786c sll v1,v0,0x02
0x00057870 lui v0,0x8013
0x00057874 addiu v0,v0,0xf344
0x00057878 addu v1,v0,v1
0x0005787c lw v0,0x0000(v1)
0x00057880 addi a0,a0,0x0002
0x00057884 sb r0,0x0034(v0)
0x00057888 lw v1,0x0000(v1)
0x0005788c nop
0x00057890 lbu v0,0x0030(v1)
0x00057894 nop
0x00057898 andi v0,v0,0x00fb
0x0005789c sb v0,0x0030(v1)
0x000578a0 slt asmTemp,s0,s2
0x000578a4 bne asmTemp,r0,0x00057860
0x000578a8 nop
0x000578ac jal 0x00063a20
0x000578b0 nop
0x000578b4 jal 0x00063a2c
0x000578b8 nop
0x000578bc addu a0,r0,r0
0x000578c0 jal 0x000c6374
0x000578c4 addiu a1,r0,0x0011
0x000578c8 beq r0,r0,0x000578d8
0x000578cc nop
0x000578d0 jal 0x0005dec4
0x000578d4 nop
0x000578d8 jal 0x00063ef0
0x000578dc nop
0x000578e0 beq v0,r0,0x000578d0
0x000578e4 nop
0x000578e8 jal 0x00063ee4
0x000578ec nop
0x000578f0 addiu v0,r0,0x0001
0x000578f4 sb v0,-0x6c22(gp)
0x000578f8 lw ra,0x002c(sp)
0x000578fc lw s6,0x0028(sp)
0x00057900 lw s5,0x0024(sp)
0x00057904 lw s4,0x0020(sp)
0x00057908 lw s3,0x001c(sp)
0x0005790c lw s2,0x0018(sp)
0x00057910 lw s1,0x0014(sp)
0x00057914 lw s0,0x0010(sp)
0x00057918 jr ra
0x0005791c addiu sp,sp,0x0060