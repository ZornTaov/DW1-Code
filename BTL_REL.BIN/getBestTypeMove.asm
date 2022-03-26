/**
 * Gets the id of the move with the best type factor from a given array of
 * moves and modifies a given array of moves to only mark the best as eligible.
 *
 * If there are two moves with the same factor this function will return -1
 * but still modify the moves array.
 */
int getBestTypeMove(combatId, moveArray) {
  combatHead = load(0x134D4C)
  entityId = load(combatHead + 0x066C + combatId)
  entityPtr = load(0x12F344 + entityId * 4)
  
  currentTarget = load(combatHead + 0x37 + combatId * 0x168)
  enemyId = load(combatHead + 0x066C + currentTarget)
  enemyPtr = load(0x12F344 + enemyId * 4)
  
  typeFactorArray = short[3]
  
  for(s1 = 0; s1 < 3; s1++) {
    isUseable = moveArray[s1]
    
    if(isUseable == 1) {
      moveId = load(entityPtr + 0x44 + s1)
      techId = getTechFromMove(entityPtr, moveId)
      attackSpec = load(0x126245 + techId * 0x10)
      enemyType = load(enemyPtr)
      enemySpec = load(0x12CED2 + enemyType * 0x34)
      
      typeFactor = load(0x125F70 + attackSpec * 7 + enemySpec)
      typeFactorArray[s1] = typeFactor
    }
    else
      typeFactorArray[s1] = -1
  }
  
  getStrongestMoveArray(typeFactorArray, moveArray, sp + 0x3E, 3)
  
  return load(sp + 0x3E)
}

0x0005f0c0 addiu sp,sp,0xffc0
0x0005f0c4 sw ra,0x0028(sp)
0x0005f0c8 sw s5,0x0024(sp)
0x0005f0cc sw s4,0x0020(sp)
0x0005f0d0 sw s3,0x001c(sp)
0x0005f0d4 sw s2,0x0018(sp)
0x0005f0d8 sw s1,0x0014(sp)
0x0005f0dc sw s0,0x0010(sp)
0x0005f0e0 lw v0,-0x6de0(gp)
0x0005f0e4 addu s4,a1,r0
0x0005f0e8 addu a1,v0,r0
0x0005f0ec addu v0,a0,v0
0x0005f0f0 addu v1,a0,r0
0x0005f0f4 lbu v0,0x066c(v0)
0x0005f0f8 lui a0,0x8013
0x0005f0fc sll v0,v0,0x02
0x0005f100 addiu a0,a0,0xf344
0x0005f104 addu v0,a0,v0
0x0005f108 lw s2,0x0000(v0)
0x0005f10c addu s1,r0,r0
0x0005f110 sll v0,v1,0x04
0x0005f114 sub v1,v0,v1
0x0005f118 sll v0,v1,0x02
0x0005f11c sub v0,v0,v1
0x0005f120 sll v0,v0,0x03
0x0005f124 addu v0,v0,a1
0x0005f128 lbu v0,0x0037(v0)
0x0005f12c addiu s5,s2,0x0044
0x0005f130 addu v0,v0,a1
0x0005f134 lbu v0,0x066c(v0)
0x0005f138 nop
0x0005f13c sll v0,v0,0x02
0x0005f140 addu v0,a0,v0
0x0005f144 lw s3,0x0000(v0)
0x0005f148 beq r0,r0,0x0005f1fc
0x0005f14c addu s0,r0,r0
0x0005f150 addu v0,s4,s0
0x0005f154 lh v0,0x0000(v0)
0x0005f158 addiu asmTemp,r0,0x0001
0x0005f15c bne v0,asmTemp,0x0005f1e8
0x0005f160 nop
0x0005f164 addu v0,s5,s1
0x0005f168 lbu a1,0x0000(v0)
0x0005f16c jal 0x000e6000
0x0005f170 addu a0,s2,r0
0x0005f174 sll v0,v0,0x10
0x0005f178 sra v0,v0,0x10
0x0005f17c sll v1,v0,0x04
0x0005f180 lui v0,0x8012
0x0005f184 addiu v0,v0,0x6245
0x0005f188 addu v0,v0,v1
0x0005f18c lbu v1,0x0000(v0)
0x0005f190 nop
0x0005f194 sll v0,v1,0x03
0x0005f198 sub a0,v0,v1
0x0005f19c lui v0,0x8012
0x0005f1a0 addiu v0,v0,0x5f70
0x0005f1a4 lw v1,0x0000(s3)
0x0005f1a8 addu a0,v0,a0
0x0005f1ac sll v0,v1,0x01
0x0005f1b0 add v0,v0,v1
0x0005f1b4 sll v0,v0,0x02
0x0005f1b8 add v0,v0,v1
0x0005f1bc sll v1,v0,0x02
0x0005f1c0 lui v0,0x8013
0x0005f1c4 addiu v0,v0,0xced2
0x0005f1c8 addu v0,v0,v1
0x0005f1cc lbu v0,0x0000(v0)
0x0005f1d0 nop
0x0005f1d4 addu v0,v0,a0
0x0005f1d8 lbu v1,0x0000(v0)
0x0005f1dc addu v0,sp,s0
0x0005f1e0 beq r0,r0,0x0005f1f4
0x0005f1e4 sh v1,0x0034(v0)
0x0005f1e8 addiu v1,r0,0xffff
0x0005f1ec addu v0,sp,s0
0x0005f1f0 sh v1,0x0034(v0)
0x0005f1f4 addi s1,s1,0x0001
0x0005f1f8 addi s0,s0,0x0002
0x0005f1fc slti asmTemp,s1,0x0003
0x0005f200 bne asmTemp,r0,0x0005f150
0x0005f204 nop
0x0005f208 addiu a0,sp,0x0034
0x0005f20c addu a1,s4,r0
0x0005f210 addiu a2,sp,0x003e
0x0005f214 jal 0x0005f344
0x0005f218 addiu a3,r0,0x0003
0x0005f21c lh v0,0x003e(sp)
0x0005f220 lw ra,0x0028(sp)
0x0005f224 lw s5,0x0024(sp)
0x0005f228 lw s4,0x0020(sp)
0x0005f22c lw s3,0x001c(sp)
0x0005f230 lw s2,0x0018(sp)
0x0005f234 lw s1,0x0014(sp)
0x0005f238 lw s0,0x0010(sp)
0x0005f23c jr ra
0x0005f240 addiu sp,sp,0x0040