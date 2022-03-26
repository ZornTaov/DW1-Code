/**
 * Gets an array and count of remaining (alive) enemies for a given Digimon.
 * The values get stored in addresses given by a1 (array) and a2 (count), 
 * typically on the stack.
 */
int[], int getRemainingEnemies(entityPtr) {
  aliveCount = 0
  aliveList = new int[4]
  combatHead = load(0x134D4C) // combatPtr
  
  for(combatId = 0; combatId <= load(0x134D6C); combatId++) {
    entityId = load(combatHead + combatId + 0x066C)
    lEntityPtr = load(0x12F344 + entityId * 4)
    
    if(entityPtr == lEntityPtr)
      continue
    
    if(hasZeroHP(combatId))
      continue
    
    aliveList[aliveCount] = combatId
    aliveCount++
  }
  
  return aliveList, aliveCount
}

0x0005fce8 addiu sp,sp,0xffd8
0x0005fcec sw ra,0x0020(sp)
0x0005fcf0 sw s3,0x001c(sp)
0x0005fcf4 sw s2,0x0018(sp)
0x0005fcf8 sw s1,0x0014(sp)
0x0005fcfc sw s0,0x0010(sp)
0x0005fd00 addu s1,a2,r0
0x0005fd04 addu s3,a0,r0
0x0005fd08 addu s2,a1,r0
0x0005fd0c sh r0,0x0000(s1)
0x0005fd10 beq r0,r0,0x0005fd84
0x0005fd14 addu s0,r0,r0
0x0005fd18 lw v0,-0x6de0(gp)
0x0005fd1c nop
0x0005fd20 addu v0,s0,v0
0x0005fd24 lbu v0,0x066c(v0)
0x0005fd28 nop
0x0005fd2c sll v1,v0,0x02
0x0005fd30 lui v0,0x8013
0x0005fd34 addiu v0,v0,0xf344
0x0005fd38 addu v0,v0,v1
0x0005fd3c lw v0,0x0000(v0)
0x0005fd40 nop
0x0005fd44 beq s3,v0,0x0005fd80
0x0005fd48 nop
0x0005fd4c jal 0x000601ac
0x0005fd50 andi a0,s0,0x00ff
0x0005fd54 bne v0,r0,0x0005fd80
0x0005fd58 nop
0x0005fd5c lh v0,0x0000(s1)
0x0005fd60 nop
0x0005fd64 sll v0,v0,0x01
0x0005fd68 addu v0,s2,v0
0x0005fd6c sh s0,0x0000(v0)
0x0005fd70 lh v0,0x0000(s1)
0x0005fd74 nop
0x0005fd78 addi v0,v0,0x0001
0x0005fd7c sh v0,0x0000(s1)
0x0005fd80 addi s0,s0,0x0001
0x0005fd84 lh v0,-0x6dc0(gp)
0x0005fd88 nop
0x0005fd8c slt asmTemp,v0,s0
0x0005fd90 beq asmTemp,r0,0x0005fd18
0x0005fd94 nop
0x0005fd98 lw ra,0x0020(sp)
0x0005fd9c lw s3,0x001c(sp)
0x0005fda0 lw s2,0x0018(sp)
0x0005fda4 lw s1,0x0014(sp)
0x0005fda8 lw s0,0x0010(sp)
0x0005fdac jr ra
0x0005fdb0 addiu sp,sp,0x0028