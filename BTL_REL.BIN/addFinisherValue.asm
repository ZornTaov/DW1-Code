void addFinisherValue(int entityCombatOffset, int amount) {

  int combatStartOffset = load(0x134D4C)

  // check if entity has finisher
  for(int i = 0, i < load(0x134D6C), i++) { // for number of entities in combat
    localCombatOffset = combatStartOffset + 0x168 * i
    
    if(localCombatOffset == entityCombatOffset) { // it's the entity we're looking for
      entityMapOffset = load(combatStartOffset + 0x066C + i) * 4 // involved entitiy list
      entityMapDataOffset = load(0x12f344 + entityMapOffset) // entity data table
      finisherId = load(entityMapDataOffset + 0x47) // move in slot #3
      
      techId = getTechFromMove(entityMapDataOffset, finisherId)

      if(techId < 0x3A || techId > 0x71)
        return
    }
  }

  tmpAmount = load(entityCombatOffset + 0x1A) // finisher progress
  tmpAmount += amount
  store(tmpAmount, entityCombatOffset + 0x1A)

  goalAmount = load(entityCombatOffset + 0x18) // finisher goal

  if(goalAmount < tmpAmount) 
    store(goalAmount, entityCombatOffset + 0x1A)
}

// original code
0x0005dfc8 addiu sp,sp,0xffd8
0x0005dfcc sw ra,0x0020(sp)
0x0005dfd0 sw s3,0x001c(sp)
0x0005dfd4 sw s2,0x0018(sp)
0x0005dfd8 sw s1,0x0014(sp)
0x0005dfdc sw s0,0x0010(sp)
0x0005dfe0 addu s0,a0,r0
0x0005dfe4 addu s3,a1,r0
0x0005dfe8 addu s1,r0,r0
0x0005dfec beq r0,r0,0x0005e064
0x0005dff0 addu s2,r0,r0
0x0005dff4 lw v0,-0x6de0(gp)
0x0005dff8 nop
0x0005dffc addu v1,v0,r0
0x0005e000 addu v0,v0,s2
0x0005e004 bne v0,s0,0x0005e05c
0x0005e008 nop
0x0005e00c addu v0,v1,s1
0x0005e010 lbu v0,0x066c(v0)
0x0005e014 nop
0x0005e018 sll v1,v0,0x02
0x0005e01c lui v0,0x8013
0x0005e020 addiu v0,v0,0xf344
0x0005e024 addu v0,v0,v1
0x0005e028 lw a0,0x0000(v0)
0x0005e02c nop
0x0005e030 lbu a1,0x0047(a0)
0x0005e034 jal 0x000e6000
0x0005e038 nop
0x0005e03c sll v0,v0,0x10
0x0005e040 sra v0,v0,0x10
0x0005e044 slti asmTemp,v0,0x003a
0x0005e048 bne asmTemp,r0,0x0005e0a4
0x0005e04c nop
0x0005e050 slti asmTemp,v0,0x0071
0x0005e054 beq asmTemp,r0,0x0005e0a4
0x0005e058 nop
0x0005e05c addi s1,s1,0x0001
0x0005e060 addi s2,s2,0x0168
0x0005e064 lh v0,-0x6dc0(gp)
0x0005e068 nop
0x0005e06c slt asmTemp,v0,s1
0x0005e070 beq asmTemp,r0,0x0005dff4
0x0005e074 nop
0x0005e078 lh v0,0x001a(s0)
0x0005e07c nop
0x0005e080 add v0,v0,s3
0x0005e084 sh v0,0x001a(s0)
0x0005e088 lh v0,0x0018(s0)
0x0005e08c lh v1,0x001a(s0)
0x0005e090 nop
0x0005e094 slt asmTemp,v0,v1
0x0005e098 beq asmTemp,r0,0x0005e0a4
0x0005e09c addu a0,v0,r0
0x0005e0a0 sh a0,0x001a(s0)
0x0005e0a4 lw ra,0x0020(sp)
0x0005e0a8 lw s3,0x001c(sp)
0x0005e0ac lw s2,0x0018(sp)
0x0005e0b0 lw s1,0x0014(sp)
0x0005e0b4 lw s0,0x0010(sp)
0x0005e0b8 jr ra
0x0005e0bc addiu sp,sp,0x0028