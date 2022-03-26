int checkCombatEndCondition() {
  partnerPtr = load(0x12F348)
  
  combatHead = load(0x134D4C)
  remainingDamage = load(combatHead + 0x2E)
  currentHP = load(0x1557F4)
  
  // flee timer
  if(load(0x134D68) > 40 && currentHP - remainingDamage > 0)
    return 1
  
  currentAnim = load(partnerPtr + 0x2E) // current anim
  
  // reset stuff if partner gets back up
  if(currentAnim == 0x2C) {
    store(0x134D6A, 0) // unset death countdown
    
    if(load(partnerPtr + 0x30) & 1 == 1) {
      store(combatHead + 0x34, load(combatHead + 0x34) & 0x7FFF) // unset isDead flag
      store(0x1557FB, 0)
      
      if(load(0x134D74) != 0) { // no AI flag
        val = load(0x13507C)
        
        if(val != -1)
          0x00070BFC(val) // TODO name
        
        store(0x134D60, 0)
        store(0x134D74, 0) // no AI flag
      }
    }
    
    for(enemyId = 0; enemyId < load(0x134D6C); enemyId++) {
      combatPtr = combatHead + enemyId * 0x168
      
      store(combatPtr + 0x28, 0) // reset cooldown
      store(combatPtr + 0x34, load(combatPtr + 0x34) & 0xC3BF) // unset falgs
      
      entityId = load(combatHead + 0x66C + enemyId)
      entityPtr = load(0x12F344 + entityId * 4)
      
      isDead = load(combatPtr + 0x34) & 0x8000 // isDead
      
      remainingDamage = load(combatPtr + 0x2E) // remaining HP damage
      currentHP = load(entityPtr + 0x4C) // current HP
      
      if(isDead == 0 || currentHP - remainingDamage > 0)
        store(combatPtr + 0x36, 0)
    }
  }
  
  // end combat when partner is down
  if(currentAnim == 0x2B && load(partnerPtr + 0x30) & 1 == 0) {
    if(load(0x13D4D8) == -1) // no item is being thrown
      store(0x134D6A, load(0x134D6A) + 1) // death countdown
    
    if(load(0x134D6A) == 20)
      spawnDeathCountdown(partnerPtr)
    
    return deathCountdown >= 0xAB ? 1 : 0
  }
  
  // end combat when all enemies are knocked down
  for(enemyId = 1; enemyId < load(0x134D6C); enemyId++) {
    entityId = load(combatHead + 0x66C + enemyId)
    entityPtr = load(0x12F344 + entityId * 4)
    
    // enemy knockdown animation
    if(load(entityPtr + 0x2E) != 0x2B || load(entityPtr + 0x30) & 1 != 0)
      return 0
  }
  
  remainingDamage = load(combatHead + 0x2E)
  currentHP = load(0x1557F4)
  
  return currentHP - remainingDamage > 0 ? 1 : 0
}

0x00057920 addiu sp,sp,0xffe8
0x00057924 sw ra,0x0014(sp)
0x00057928 sw s0,0x0010(sp)
0x0005792c lui asmTemp,0x8013
0x00057930 lw s0,-0x0cb8(asmTemp)
0x00057934 lh v0,-0x6dc4(gp)
0x00057938 nop
0x0005793c slti asmTemp,v0,0x0029
0x00057940 bne asmTemp,r0,0x00057970
0x00057944 nop
0x00057948 lw v0,-0x6de0(gp)
0x0005794c lui asmTemp,0x8015
0x00057950 lh v1,0x002e(v0)
0x00057954 lh v0,0x57f4(asmTemp)
0x00057958 nop
0x0005795c sub v0,v0,v1
0x00057960 blez v0,0x00057970
0x00057964 nop
0x00057968 beq r0,r0,0x00057bc0
0x0005796c addiu v0,r0,0x0001
0x00057970 lbu v0,0x002e(s0)
0x00057974 addiu asmTemp,r0,0x002c
0x00057978 bne v0,asmTemp,0x00057a9c
0x0005797c nop
0x00057980 sh r0,-0x6dc2(gp)
0x00057984 lbu v0,0x0030(s0)
0x00057988 nop
0x0005798c andi v0,v0,0x0001
0x00057990 bne v0,r0,0x00057a9c
0x00057994 nop
0x00057998 lw v1,-0x6de0(gp)
0x0005799c lui asmTemp,0x8015
0x000579a0 lhu v0,0x0034(v1)
0x000579a4 nop
0x000579a8 andi v0,v0,0x7fff
0x000579ac sh v0,0x0034(v1)
0x000579b0 lw v0,-0x6db8(gp)
0x000579b4 nop
0x000579b8 beq v0,r0,0x000579e0
0x000579bc sb r0,0x57fb(asmTemp)
0x000579c0 lw a0,-0x6ab0(gp)
0x000579c4 addiu asmTemp,r0,0xffff
0x000579c8 beq a0,asmTemp,0x000579d8
0x000579cc nop
0x000579d0 jal 0x00070bfc
0x000579d4 nop
0x000579d8 sw r0,-0x6db8(gp)
0x000579dc sw r0,-0x6dcc(gp)
0x000579e0 addu v0,r0,r0
0x000579e4 beq r0,r0,0x00057a88
0x000579e8 addu v1,r0,r0
0x000579ec lw a0,-0x6de0(gp)
0x000579f0 nop
0x000579f4 addu a0,v1,a0
0x000579f8 sh r0,0x0028(a0)
0x000579fc lw a0,-0x6de0(gp)
0x00057a00 nop
0x00057a04 addu a1,v1,a0
0x00057a08 lhu a0,0x0034(a1)
0x00057a0c nop
0x00057a10 andi a0,a0,0xc3bf
0x00057a14 sh a0,0x0034(a1)
0x00057a18 lw a0,-0x6de0(gp)
0x00057a1c nop
0x00057a20 addu a3,a0,r0
0x00057a24 addu a0,v0,a0
0x00057a28 lbu a0,0x066c(a0)
0x00057a2c nop
0x00057a30 sll a1,a0,0x02
0x00057a34 lui a0,0x8013
0x00057a38 addiu a0,a0,0xf344
0x00057a3c addu a0,a0,a1
0x00057a40 lw a0,0x0000(a0)
0x00057a44 addu a1,v1,a3
0x00057a48 addiu a2,a0,0x0038
0x00057a4c lhu a0,0x0034(a1)
0x00057a50 nop
0x00057a54 andi a0,a0,0x8000
0x00057a58 beq a0,r0,0x00057a78
0x00057a5c nop
0x00057a60 lh a1,0x002e(a1)
0x00057a64 lh a0,0x0014(a2)
0x00057a68 nop
0x00057a6c sub a0,a0,a1
0x00057a70 blez a0,0x00057a80
0x00057a74 nop
0x00057a78 addu a0,v1,a3
0x00057a7c sb r0,0x0036(a0)
0x00057a80 addi v0,v0,0x0001
0x00057a84 addi v1,v1,0x0168
0x00057a88 lh a0,-0x6dc0(gp)
0x00057a8c nop
0x00057a90 slt asmTemp,a0,v0
0x00057a94 beq asmTemp,r0,0x000579ec
0x00057a98 nop
0x00057a9c lbu v0,0x002e(s0)
0x00057aa0 addiu asmTemp,r0,0x002b
0x00057aa4 bne v0,asmTemp,0x00057b28
0x00057aa8 nop
0x00057aac lbu v0,0x0030(s0)
0x00057ab0 nop
0x00057ab4 andi v0,v0,0x0001
0x00057ab8 bne v0,r0,0x00057b28
0x00057abc nop
0x00057ac0 lui asmTemp,0x8014
0x00057ac4 lw v0,-0x2b28(asmTemp)
0x00057ac8 addiu asmTemp,r0,0x00ff
0x00057acc bne v0,asmTemp,0x00057ae4
0x00057ad0 nop
0x00057ad4 lh v0,-0x6dc2(gp)
0x00057ad8 nop
0x00057adc addi v0,v0,0x0001
0x00057ae0 sh v0,-0x6dc2(gp)
0x00057ae4 lh v0,-0x6dc2(gp)
0x00057ae8 addiu asmTemp,r0,0x0014
0x00057aec bne v0,asmTemp,0x00057b04
0x00057af0 nop
0x00057af4 lui asmTemp,0x8013
0x00057af8 lw a0,-0x0cb8(asmTemp)
0x00057afc jal 0x00062468
0x00057b00 nop
0x00057b04 lh v0,-0x6dc2(gp)
0x00057b08 nop
0x00057b0c slti asmTemp,v0,0x00ab
0x00057b10 bne asmTemp,r0,0x00057b20
0x00057b14 nop
0x00057b18 beq r0,r0,0x00057bc0
0x00057b1c addiu v0,r0,0x0001
0x00057b20 beq r0,r0,0x00057bc0
0x00057b24 addu v0,r0,r0
0x00057b28 lw a1,-0x6de0(gp)
0x00057b2c lh a2,-0x6dc0(gp)
0x00057b30 beq r0,r0,0x00057b8c
0x00057b34 addiu v0,r0,0x0001
0x00057b38 addu v1,v0,a1
0x00057b3c lbu v1,0x066c(v1)
0x00057b40 addiu asmTemp,r0,0x002b
0x00057b44 sll a0,v1,0x02
0x00057b48 lui v1,0x8013
0x00057b4c addiu v1,v1,0xf344
0x00057b50 addu v1,v1,a0
0x00057b54 lw s0,0x0000(v1)
0x00057b58 nop
0x00057b5c lbu v1,0x002e(s0)
0x00057b60 nop
0x00057b64 bne v1,asmTemp,0x00057b80
0x00057b68 nop
0x00057b6c lbu v1,0x0030(s0)
0x00057b70 nop
0x00057b74 andi v1,v1,0x0001
0x00057b78 beq v1,r0,0x00057b88
0x00057b7c nop
0x00057b80 beq r0,r0,0x00057bc0
0x00057b84 addu v0,r0,r0
0x00057b88 addi v0,v0,0x0001
0x00057b8c slt asmTemp,a2,v0
0x00057b90 beq asmTemp,r0,0x00057b38
0x00057b94 nop
0x00057b98 lw v0,-0x6de0(gp)
0x00057b9c lui asmTemp,0x8015
0x00057ba0 lh v1,0x002e(v0)
0x00057ba4 lh v0,0x57f4(asmTemp)
0x00057ba8 nop
0x00057bac sub v0,v0,v1
0x00057bb0 bgtz v0,0x00057bc0
0x00057bb4 addiu v0,r0,0x0001
0x00057bb8 beq r0,r0,0x00057bc0
0x00057bbc addu v0,r0,r0
0x00057bc0 lw ra,0x0014(sp)
0x00057bc4 lw s0,0x0010(sp)
0x00057bc8 jr ra
0x00057bcc addiu sp,sp,0x0018