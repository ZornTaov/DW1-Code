/**
 * Gets the id of the cheapest move from a given array of moves and
 * modifies a given array of moves to only mark the cheapest as eligible.
 *
 * If there are two moves with the same cost this function will return -1
 * but still modify the moves array.
 */
int getCheapestMove(combatId, moveArray) {
  combatHead = load(0x134D4C)
  entityId = load(combatHead + 0x066C + combatId)
  entityPtr = load(0x12F344 + entityId * 4)
  mpArray = short[3]
  
  for(moveId = 0; moveId < 3; moveId++) {
    isUseable = moveArray[moveId]
    if(isUseable == 1) {
      move = load(entityPtr + 0x44 + moveId)
      techId = getTechFromMove(entityPtr, move)
      mpArray[moveId] = load(0x126242 + techId * 0x10) * 3
    }
    else
      mpArray[moveId] = 1000
  }
  
  getCheapestMoveArray(mpArray, moveArray, sp + 0x36, 3)
  return load(sp + 0x36)
}

0x0005f244 addiu sp,sp,0xffc8
0x0005f248 sw ra,0x0024(sp)
0x0005f24c sw s4,0x0020(sp)
0x0005f250 sw s3,0x001c(sp)
0x0005f254 sw s2,0x0018(sp)
0x0005f258 sw s1,0x0014(sp)
0x0005f25c lw v0,-0x6de0(gp)
0x0005f260 sw s0,0x0010(sp)
0x0005f264 addu v0,a0,v0
0x0005f268 lbu v0,0x066c(v0)
0x0005f26c addu s4,a1,r0
0x0005f270 sll v1,v0,0x02
0x0005f274 lui v0,0x8013
0x0005f278 addiu v0,v0,0xf344
0x0005f27c addu v0,v0,v1
0x0005f280 lw s2,0x0000(v0)
0x0005f284 addu s1,r0,r0
0x0005f288 addiu s3,s2,0x0044
0x0005f28c beq r0,r0,0x0005f300
0x0005f290 addu s0,r0,r0
0x0005f294 addu v0,s4,s0
0x0005f298 lh v0,0x0000(v0)
0x0005f29c addiu asmTemp,r0,0x0001
0x0005f2a0 bne v0,asmTemp,0x0005f2ec
0x0005f2a4 nop
0x0005f2a8 addu v0,s3,s1
0x0005f2ac lbu a1,0x0000(v0)
0x0005f2b0 jal 0x000e6000
0x0005f2b4 addu a0,s2,r0
0x0005f2b8 sll v0,v0,0x10
0x0005f2bc sra v0,v0,0x10
0x0005f2c0 sll v1,v0,0x04
0x0005f2c4 lui v0,0x8012
0x0005f2c8 addiu v0,v0,0x6242
0x0005f2cc addu v0,v0,v1
0x0005f2d0 lbu v1,0x0000(v0)
0x0005f2d4 nop
0x0005f2d8 sll v0,v1,0x01
0x0005f2dc add v1,v0,v1
0x0005f2e0 addu v0,sp,s0
0x0005f2e4 beq r0,r0,0x0005f2f8
0x0005f2e8 sh v1,0x002c(v0)
0x0005f2ec addiu v1,r0,0x03e8
0x0005f2f0 addu v0,sp,s0
0x0005f2f4 sh v1,0x002c(v0)
0x0005f2f8 addi s1,s1,0x0001
0x0005f2fc addi s0,s0,0x0002
0x0005f300 slti asmTemp,s1,0x0003
0x0005f304 bne asmTemp,r0,0x0005f294
0x0005f308 nop
0x0005f30c addiu a0,sp,0x002c
0x0005f310 addu a1,s4,r0
0x0005f314 addiu a2,sp,0x0036
0x0005f318 jal 0x0005f404
0x0005f31c addiu a3,r0,0x0003
0x0005f320 lh v0,0x0036(sp)
0x0005f324 lw ra,0x0024(sp)
0x0005f328 lw s4,0x0020(sp)
0x0005f32c lw s3,0x001c(sp)
0x0005f330 lw s2,0x0018(sp)
0x0005f334 lw s1,0x0014(sp)
0x0005f338 lw s0,0x0010(sp)
0x0005f33c jr ra
0x0005f340 addiu sp,sp,0x0038