/**
 * Gets whether there are moves that a Digimon has enough MP to use.
 * Also fills an array given by arrayPtr with whether a move slot is affordable
 * and the move's order among the afforable ones.
 */
int hasAffordableMoves0x0005B070(arrayPtr, combatId) {
  battleHead = load(0x134D4C)
  entityId = load(battleHead + 0x066C + combatId) // enemyId
  entityPtr = load(0x12F344 + entityId * 4)
  
  affordableMoves = 0
  
  for(moveId = 0; moveId < 4; moveId++) {
    mpCost = getMPCost(entityPtr, battleHead + combatId * 0x168, moveId)
    arrayPtr[moveId] = mpCost != 0 ? 1 : 0
  }
  
  return affordableMoves
}

0x0005b070 addiu sp,sp,0xffd0
0x0005b074 sw ra,0x0028(sp)
0x0005b078 sw s5,0x0024(sp)
0x0005b07c sw s4,0x0020(sp)
0x0005b080 sw s3,0x001c(sp)
0x0005b084 sw s2,0x0018(sp)
0x0005b088 sw s1,0x0014(sp)
0x0005b08c lw v0,-0x6de0(gp)
0x0005b090 sw s0,0x0010(sp)
0x0005b094 addu a2,v0,r0
0x0005b098 addu v0,a1,v0
0x0005b09c lbu v0,0x066c(v0)
0x0005b0a0 addu s3,a0,r0
0x0005b0a4 sll v1,v0,0x02
0x0005b0a8 lui v0,0x8013
0x0005b0ac addiu v0,v0,0xf344
0x0005b0b0 addu v0,v0,v1
0x0005b0b4 lw s5,0x0000(v0)
0x0005b0b8 addu a0,a1,r0
0x0005b0bc sll v0,a0,0x04
0x0005b0c0 sub v1,v0,a0
0x0005b0c4 sll v0,v1,0x02
0x0005b0c8 sub v0,v0,v1
0x0005b0cc sll v0,v0,0x03
0x0005b0d0 addu s4,a2,v0
0x0005b0d4 addu s2,r0,r0
0x0005b0d8 addu s1,r0,r0
0x0005b0dc beq r0,r0,0x0005b120
0x0005b0e0 addu s0,r0,r0
0x0005b0e4 sll a2,s1,0x10
0x0005b0e8 sra a2,a2,0x10
0x0005b0ec addu a0,s5,r0
0x0005b0f0 jal 0x0005d374
0x0005b0f4 addu a1,s4,r0
0x0005b0f8 beq v0,r0,0x0005b110
0x0005b0fc nop
0x0005b100 addiu s2,r0,0x0001
0x0005b104 addu v0,s3,s0
0x0005b108 beq r0,r0,0x0005b118
0x0005b10c sh s2,0x0000(v0)
0x0005b110 addu v0,s3,s0
0x0005b114 sh r0,0x0000(v0)
0x0005b118 addi s1,s1,0x0001
0x0005b11c addi s0,s0,0x0002
0x0005b120 slti asmTemp,s1,0x0004
0x0005b124 bne asmTemp,r0,0x0005b0e4
0x0005b128 nop
0x0005b12c addu v0,s2,r0
0x0005b130 lw ra,0x0028(sp)
0x0005b134 lw s5,0x0024(sp)
0x0005b138 lw s4,0x0020(sp)
0x0005b13c lw s3,0x001c(sp)
0x0005b140 lw s2,0x0018(sp)
0x0005b144 lw s1,0x0014(sp)
0x0005b148 lw s0,0x0010(sp)
0x0005b14c jr ra
0x0005b150 addiu sp,sp,0x0030