/**
 * Gets the strongest move from a given array of powers, stores it into retPtr
 * and modifies a given array of moves to only mark the strongest as eligible.
 *
 * If there are two moves with the same power this function will set retPtr to
 * -1 but still modify the moves array.
 */
void getStrongestMoveArray(powerArray, moveArray, retPtr, numMoves) {
  maxPower = powerArray[0]
  
  for(i = 1; i < numMoves; i++) {
    power = powerArray[i]
    
    if(maxPower < power)
      maxPower = power
  }
  
  matchedMoves = 0
  
  for(moveId = 0; moveId < numMoves; moveId++) {
    if(maxPower == powerArray[moveId]) {
      store(retPtr, moveId)
      matchedMoves++
      moveArray[moveId] = 1
    }
    else
      moveArray[moveId] = -1
  }
  
  if(matchedMoves >= 2)
    store(retPtr, -1)
}

0x0005f344 lh v1,0x0000(a0)
0x0005f348 addiu v0,r0,0x0001
0x0005f34c addiu t1,r0,0x0002
0x0005f350 beq r0,r0,0x0005f380
0x0005f354 addu t2,a3,r0
0x0005f358 addu t0,a0,t1
0x0005f35c lh t0,0x0000(t0)
0x0005f360 nop
0x0005f364 slt asmTemp,v1,t0
0x0005f368 beq asmTemp,r0,0x0005f378
0x0005f36c addu t3,t0,r0
0x0005f370 sll v1,t3,0x10
0x0005f374 sra v1,v1,0x10
0x0005f378 addi v0,v0,0x0001
0x0005f37c addi t1,t1,0x0002
0x0005f380 slt asmTemp,v0,t2
0x0005f384 bne asmTemp,r0,0x0005f358
0x0005f388 nop
0x0005f38c addu t2,r0,r0
0x0005f390 addu v0,r0,r0
0x0005f394 beq r0,r0,0x0005f3dc
0x0005f398 addu t3,r0,r0
0x0005f39c addu t0,a0,t3
0x0005f3a0 lh t0,0x0000(t0)
0x0005f3a4 nop
0x0005f3a8 bne v1,t0,0x0005f3c8
0x0005f3ac nop
0x0005f3b0 sh v0,0x0000(a2)
0x0005f3b4 addiu t1,r0,0x0001
0x0005f3b8 addu t0,a1,t3
0x0005f3bc addi t2,t2,0x0001
0x0005f3c0 beq r0,r0,0x0005f3d4
0x0005f3c4 sh t1,0x0000(t0)
0x0005f3c8 addiu t1,r0,0xffff
0x0005f3cc addu t0,a1,t3
0x0005f3d0 sh t1,0x0000(t0)
0x0005f3d4 addi v0,v0,0x0001
0x0005f3d8 addi t3,t3,0x0002
0x0005f3dc slt asmTemp,v0,a3
0x0005f3e0 bne asmTemp,r0,0x0005f39c
0x0005f3e4 nop
0x0005f3e8 slti asmTemp,t2,0x0002
0x0005f3ec bne asmTemp,r0,0x0005f3fc
0x0005f3f0 nop
0x0005f3f4 addiu v0,r0,0xffff
0x0005f3f8 sh v0,0x0000(a2)
0x0005f3fc jr ra
0x0005f400 nop