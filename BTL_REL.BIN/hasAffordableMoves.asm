/**
 * Gets whether there are moves that a Digimon has enough MP to use.
 * Also fills an array given by arrayPtr with whether a move slot is affordable
 * and the move's order among the afforable ones.
 */
int hasAffordableMoves(arrayPtr, combatId) {
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

0x0005ee58 addiu sp,sp,0xffd0
0x0005ee5c sw ra,0x0028(sp)
0x0005ee60 sw s5,0x0024(sp)
0x0005ee64 sw s4,0x0020(sp)
0x0005ee68 sw s3,0x001c(sp)
0x0005ee6c sw s2,0x0018(sp)
0x0005ee70 sw s1,0x0014(sp)
0x0005ee74 lw v0,-0x6de0(gp)
0x0005ee78 sw s0,0x0010(sp)
0x0005ee7c addu a2,v0,r0
0x0005ee80 addu v0,a1,v0
0x0005ee84 lbu v0,0x066c(v0)
0x0005ee88 addu s3,a0,r0
0x0005ee8c sll v1,v0,0x02
0x0005ee90 lui v0,0x8013
0x0005ee94 addiu v0,v0,0xf344
0x0005ee98 addu v0,v0,v1
0x0005ee9c lw s5,0x0000(v0)
0x0005eea0 addu a0,a1,r0
0x0005eea4 sll v0,a0,0x04
0x0005eea8 sub v1,v0,a0
0x0005eeac sll v0,v1,0x02
0x0005eeb0 sub v0,v0,v1
0x0005eeb4 sll v0,v0,0x03
0x0005eeb8 addu s4,a2,v0
0x0005eebc addu s2,r0,r0
0x0005eec0 addu s1,r0,r0
0x0005eec4 beq r0,r0,0x0005ef08
0x0005eec8 addu s0,r0,r0
0x0005eecc sll a2,s1,0x10
0x0005eed0 sra a2,a2,0x10
0x0005eed4 addu a0,s5,r0
0x0005eed8 jal 0x0005d374
0x0005eedc addu a1,s4,r0
0x0005eee0 beq v0,r0,0x0005eef8
0x0005eee4 nop
0x0005eee8 addiu s2,r0,0x0001
0x0005eeec addu v0,s3,s0
0x0005eef0 beq r0,r0,0x0005ef00
0x0005eef4 sh s2,0x0000(v0)
0x0005eef8 addu v0,s3,s0
0x0005eefc sh r0,0x0000(v0)
0x0005ef00 addi s1,s1,0x0001
0x0005ef04 addi s0,s0,0x0002
0x0005ef08 slti asmTemp,s1,0x0004
0x0005ef0c bne asmTemp,r0,0x0005eecc
0x0005ef10 nop
0x0005ef14 addu v0,s2,r0
0x0005ef18 lw ra,0x0028(sp)
0x0005ef1c lw s5,0x0024(sp)
0x0005ef20 lw s4,0x0020(sp)
0x0005ef24 lw s3,0x001c(sp)
0x0005ef28 lw s2,0x0018(sp)
0x0005ef2c lw s1,0x0014(sp)
0x0005ef30 lw s0,0x0010(sp)
0x0005ef34 jr ra
0x0005ef38 addiu sp,sp,0x0030