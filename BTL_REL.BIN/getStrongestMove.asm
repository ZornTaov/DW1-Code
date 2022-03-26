/**
 * Gets the id of the strongest move from a given array of moves and
 * modifies a given array of moves to only mark the strongest as eligible.
 *
 * If there are two moves with the same power this function will return -1
 * but still modify the moves array.
 */
int getStrongestMove(combatId, moveArray) {
  combatHead = load(0x134D4C)
  entityId = load(combatHead + 0x066C + combatId)
  entityPtr = load(0x12F344 + entityId * 4)
  
  powerArray = short[3]
  
  for(moveId = 0; moveId < 3; moveId++) {
    if(moveArray[moveId] == 1) { // is affordable
      moveId = load(entityPtr + 0x44 + moveId)
      techId = getTechFromMove(entityPtr, moveId)
      movePower = load(0x126240 + techId * 0x10)
      powerArray[moveId] = movePower
    }
    else 
      powerArray[moveId] = -1
  }
  
  getStrongestMoveArray(powerArray, moveArray, sp + 0x36, 3)
  
  return load(sp + 0x36)
}

0x0005efcc addiu sp,sp,0xffc8
0x0005efd0 sw ra,0x0024(sp)
0x0005efd4 sw s4,0x0020(sp)
0x0005efd8 sw s3,0x001c(sp)
0x0005efdc sw s2,0x0018(sp)
0x0005efe0 sw s1,0x0014(sp)
0x0005efe4 lw v0,-0x6de0(gp)
0x0005efe8 sw s0,0x0010(sp)
0x0005efec addu v0,a0,v0
0x0005eff0 lbu v0,0x066c(v0)
0x0005eff4 addu s4,a1,r0
0x0005eff8 sll v1,v0,0x02
0x0005effc lui v0,0x8013
0x0005f000 addiu v0,v0,0xf344
0x0005f004 addu v0,v0,v1
0x0005f008 lw s2,0x0000(v0)
0x0005f00c addu s1,r0,r0
0x0005f010 addiu s3,s2,0x0044
0x0005f014 beq r0,r0,0x0005f07c
0x0005f018 addu s0,r0,r0
0x0005f01c addu v0,s4,s0
0x0005f020 lh v0,0x0000(v0)
0x0005f024 addiu asmTemp,r0,0x0001
0x0005f028 bne v0,asmTemp,0x0005f068
0x0005f02c nop
0x0005f030 addu v0,s3,s1
0x0005f034 lbu a1,0x0000(v0)
0x0005f038 jal 0x000e6000
0x0005f03c addu a0,s2,r0
0x0005f040 sll v0,v0,0x10
0x0005f044 sra v0,v0,0x10
0x0005f048 sll v1,v0,0x04
0x0005f04c lui v0,0x8012
0x0005f050 addiu v0,v0,0x6240
0x0005f054 addu v0,v0,v1
0x0005f058 lh v1,0x0000(v0)
0x0005f05c addu v0,sp,s0
0x0005f060 beq r0,r0,0x0005f074
0x0005f064 sh v1,0x002c(v0)
0x0005f068 addiu v1,r0,0xffff
0x0005f06c addu v0,sp,s0
0x0005f070 sh v1,0x002c(v0)
0x0005f074 addi s1,s1,0x0001
0x0005f078 addi s0,s0,0x0002
0x0005f07c slti asmTemp,s1,0x0003
0x0005f080 bne asmTemp,r0,0x0005f01c
0x0005f084 nop
0x0005f088 addiu a0,sp,0x002c
0x0005f08c addu a1,s4,r0
0x0005f090 addiu a2,sp,0x0036
0x0005f094 jal 0x0005f344
0x0005f098 addiu a3,r0,0x0003
0x0005f09c lh v0,0x0036(sp)
0x0005f0a0 lw ra,0x0024(sp)
0x0005f0a4 lw s4,0x0020(sp)
0x0005f0a8 lw s3,0x001c(sp)
0x0005f0ac lw s2,0x0018(sp)
0x0005f0b0 lw s1,0x0014(sp)
0x0005f0b4 lw s0,0x0010(sp)
0x0005f0b8 jr ra
0x0005f0bc addiu sp,sp,0x0038