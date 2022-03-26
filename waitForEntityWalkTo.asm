int waitForEntityWalkTo(scriptId1, scriptId2, targetPosX, targetPosZ, val5) {
  entitiyPtr1, entityId1 = loadEntityDataFromScriptId(scriptId1)
  locationPtr1 = load(entitiyPtr1 + 0x04)
  
  if(entityId1 >= 2)
    store(0x13D170 + (entityId1 - 2) * 4, 1)
  
  startPosition = int[4]
  targetPosition = int[4]
  
  startPosition[0] = load(locationPtr1 + 0x78)
  startPosition[1] = load(locationPtr1 + 0x7C)
  startPosition[2] = load(locationPtr1 + 0x80)
  startPosition[3] = load(locationPtr1 + 0x84)
  
  if(scriptId2 == -1) {
    targetPosition[0] = targetPosX
    targetPosition[1] = load(locationPtr1 + 0x7C)
    targetPosition[2] = targetPosZ
  }
  else {
    entityPtr, entityId2 = loadEntityDataFromScriptId(scriptId2)
    locationPtr2 = load(entityPtr + 0x04)
    
    targetPosition[0] = load(locationPtr2 + 0x78)
    targetPosition[1] = load(locationPtr2 + 0x7C)
    targetPosition[2] = load(locationPtr2 + 0x80)
    targetPosition[3] = load(locationPtr2 + 0x84)
  }
  
  if(load(0x134C80) == 0 && val5 == 1) {
    store(0x1387A8, startPosition[0])
    store(0x1387AC, startPosition[1])
    store(0x1387B0, startPosition[2])
    store(0x1387B4, startPosition[3])
    store(0x134C80, 1)
  }
  
  tileX1, tileY1 = getModelTile(startPosition)
  tileX2, tileY2 = getModelTile(targetPosition)
  
  entityLookAtLocation(entitiyPtr1, targetPosition)
  
  if(val5 == 1) {
    0x000D892C(0x1387A8, startPosition)
    
    store(0x1387A8, startPosition[0])
    store(0x1387AC, startPosition[1])
    store(0x1387B0, startPosition[2])
    store(0x1387B4, startPosition[3])
  }
  
  collisionResponse = -1
  
  if(entitiyId2 != -1)
    collisionResponse = entityCheckCollision(0, entitiyPtr1, 0, 0)
  
  // Bug: you can walk towards a position and never reach the proper tile
  if(tileX1 != tileX2 || tileY1 != tileY2) {
    // Bug: collision with entity #9 is ignored
    if(collisionResponse == -1 || collisionResponse >= 9) // no collision with entity 0-8
      return 0
  }
  
  store(0x134C80, 0)
  
  if(entityId1 >= 2)
    store(0x13D170 + (entityId1 - 2) * 4, 0)
  
  return 1
}

0x000ac06c addiu sp,sp,0xffb0
0x000ac070 sw ra,0x0024(sp)
0x000ac074 sw s4,0x0020(sp)
0x000ac078 sw s3,0x001c(sp)
0x000ac07c sw s2,0x0018(sp)
0x000ac080 sw s1,0x0014(sp)
0x000ac084 sw a0,0x0050(sp)
0x000ac088 sw s0,0x0010(sp)
0x000ac08c addiu v0,r0,0xffff
0x000ac090 sll s0,v0,0x10
0x000ac094 lb s2,0x0060(sp)
0x000ac098 sw a1,0x0054(sp)
0x000ac09c addu s3,a2,r0
0x000ac0a0 addu s4,a3,r0
0x000ac0a4 sra s0,s0,0x10
0x000ac0a8 jal 0x000ac2f8
0x000ac0ac addiu a0,sp,0x0050
0x000ac0b0 lbu v1,0x0050(sp)
0x000ac0b4 nop
0x000ac0b8 sltiu asmTemp,v1,0x0002
0x000ac0bc bne asmTemp,r0,0x000ac0e0
0x000ac0c0 addu s1,v0,r0
0x000ac0c4 addi v0,v1,-0x0002
0x000ac0c8 sll v1,v0,0x02
0x000ac0cc lui v0,0x8014
0x000ac0d0 addiu v0,v0,0xd170
0x000ac0d4 addiu a0,r0,0x0001
0x000ac0d8 addu v0,v0,v1
0x000ac0dc sw a0,0x0000(v0)
0x000ac0e0 lw v0,0x0004(s1)
0x000ac0e4 addiu asmTemp,r0,0x00ff
0x000ac0e8 lw a1,0x0078(v0)
0x000ac0ec lw a0,0x007c(v0)
0x000ac0f0 lw v1,0x0080(v0)
0x000ac0f4 lw v0,0x0084(v0)
0x000ac0f8 sw a1,0x0028(sp)
0x000ac0fc sw a0,0x002c(sp)
0x000ac100 sw v1,0x0030(sp)
0x000ac104 sw v0,0x0034(sp)
0x000ac108 lbu v0,0x0054(sp)
0x000ac10c nop
0x000ac110 bne v0,asmTemp,0x000ac138
0x000ac114 nop
0x000ac118 sw s3,0x0038(sp)
0x000ac11c lw v0,0x0004(s1)
0x000ac120 nop
0x000ac124 lw v0,0x007c(v0)
0x000ac128 nop
0x000ac12c sw v0,0x003c(sp)
0x000ac130 beq r0,r0,0x000ac168
0x000ac134 sw s4,0x0040(sp)
0x000ac138 jal 0x000ac2f8
0x000ac13c addiu a0,sp,0x0054
0x000ac140 lw v0,0x0004(v0)
0x000ac144 nop
0x000ac148 lw a1,0x0078(v0)
0x000ac14c lw a0,0x007c(v0)
0x000ac150 lw v1,0x0080(v0)
0x000ac154 lw v0,0x0084(v0)
0x000ac158 sw a1,0x0038(sp)
0x000ac15c sw a0,0x003c(sp)
0x000ac160 sw v1,0x0040(sp)
0x000ac164 sw v0,0x0044(sp)
0x000ac168 lb v0,-0x6eac(gp)
0x000ac16c nop
0x000ac170 bne v0,r0,0x000ac1bc
0x000ac174 nop
0x000ac178 addiu asmTemp,r0,0x0001
0x000ac17c bne s2,asmTemp,0x000ac1bc
0x000ac180 nop
0x000ac184 lw a1,0x0028(sp)
0x000ac188 lui asmTemp,0x8014
0x000ac18c sw a1,-0x7858(asmTemp)
0x000ac190 lw a0,0x002c(sp)
0x000ac194 lui asmTemp,0x8014
0x000ac198 sw a0,-0x7854(asmTemp)
0x000ac19c lw v1,0x0030(sp)
0x000ac1a0 lui asmTemp,0x8014
0x000ac1a4 sw v1,-0x7850(asmTemp)
0x000ac1a8 lw v0,0x0034(sp)
0x000ac1ac lui asmTemp,0x8014
0x000ac1b0 sw v0,-0x784c(asmTemp)
0x000ac1b4 addiu v0,r0,0x0001
0x000ac1b8 sb v0,-0x6eac(gp)
0x000ac1bc addiu a0,sp,0x0028
0x000ac1c0 addiu a1,sp,0x0048
0x000ac1c4 jal 0x000c0f28
0x000ac1c8 addiu a2,sp,0x004a
0x000ac1cc addiu a0,sp,0x0038
0x000ac1d0 addiu a1,sp,0x004c
0x000ac1d4 jal 0x000c0f28
0x000ac1d8 addiu a2,sp,0x004e
0x000ac1dc addu a0,s1,r0
0x000ac1e0 jal 0x000d459c
0x000ac1e4 addiu a1,sp,0x0038
0x000ac1e8 addiu asmTemp,r0,0x0001
0x000ac1ec bne s2,asmTemp,0x000ac234
0x000ac1f0 nop
0x000ac1f4 lui a0,0x8014
0x000ac1f8 addiu a0,a0,0x87a8
0x000ac1fc jal 0x000d892c
0x000ac200 addiu a1,sp,0x0028
0x000ac204 lw a1,0x0028(sp)
0x000ac208 lui asmTemp,0x8014
0x000ac20c sw a1,-0x7858(asmTemp)
0x000ac210 lw a0,0x002c(sp)
0x000ac214 lui asmTemp,0x8014
0x000ac218 sw a0,-0x7854(asmTemp)
0x000ac21c lw v1,0x0030(sp)
0x000ac220 lui asmTemp,0x8014
0x000ac224 sw v1,-0x7850(asmTemp)
0x000ac228 lw v0,0x0034(sp)
0x000ac22c lui asmTemp,0x8014
0x000ac230 sw v0,-0x784c(asmTemp)
0x000ac234 lbu v0,0x0054(sp)
0x000ac238 addiu asmTemp,r0,0x00ff
0x000ac23c beq v0,asmTemp,0x000ac260
0x000ac240 nop
0x000ac244 addu a0,r0,r0
0x000ac248 addu a1,s1,r0
0x000ac24c addu a2,r0,r0
0x000ac250 jal 0x000d45ec
0x000ac254 addu a3,r0,r0
0x000ac258 sll s0,v0,0x10
0x000ac25c sra s0,s0,0x10
0x000ac260 lh v1,0x0048(sp)
0x000ac264 lh v0,0x004c(sp)
0x000ac268 nop
0x000ac26c bne v1,v0,0x000ac288
0x000ac270 nop
0x000ac274 lh v1,0x004a(sp)
0x000ac278 lh v0,0x004e(sp)
0x000ac27c nop
0x000ac280 beq v1,v0,0x000ac2a0
0x000ac284 nop
0x000ac288 addiu asmTemp,r0,0xffff
0x000ac28c beq s0,asmTemp,0x000ac2d4
0x000ac290 nop
0x000ac294 slti asmTemp,s0,0x0009
0x000ac298 beq asmTemp,r0,0x000ac2d4
0x000ac29c nop
0x000ac2a0 lbu v0,0x0050(sp)
0x000ac2a4 nop
0x000ac2a8 sltiu asmTemp,v0,0x0002
0x000ac2ac bne asmTemp,r0,0x000ac2cc
0x000ac2b0 sb r0,-0x6eac(gp)
0x000ac2b4 addi v0,v0,-0x0002
0x000ac2b8 sll v1,v0,0x02
0x000ac2bc lui v0,0x8014
0x000ac2c0 addiu v0,v0,0xd170
0x000ac2c4 addu v0,v0,v1
0x000ac2c8 sw r0,0x0000(v0)
0x000ac2cc beq r0,r0,0x000ac2d8
0x000ac2d0 addiu v0,r0,0x0001
0x000ac2d4 addu v0,r0,r0
0x000ac2d8 lw ra,0x0024(sp)
0x000ac2dc lw s4,0x0020(sp)
0x000ac2e0 lw s3,0x001c(sp)
0x000ac2e4 lw s2,0x0018(sp)
0x000ac2e8 lw s1,0x0014(sp)
0x000ac2ec lw s0,0x0010(sp)
0x000ac2f0 jr ra
0x000ac2f4 addiu sp,sp,0x0050