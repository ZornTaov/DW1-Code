/**
 * Gets the cheapest move from a given array of costs, stores it into retPtr
 * and modifies a given array of moves to only mark the strongest as eligible.
 *
 * If there are two moves with the same cost this function will set retPtr to
 * -1 but still modify the moves array.
 */
void getCheapestMoveArray(mpArray, moveArray, retPtr, numMoves) {
  bestMP = mpArray[0]
  
  for(moveId = 1; moveId < numMoves; moveId++) {
    mpCost = mpArray[moveId]
    
    if(mpCost < bestMP)
      bestMP = mpCost
  }
  
  matchedMoves = 0
  
  for(moveId = 0; moveId < numMoves; moveId++) {
    if(mpArray[moveId] == bestMP) {
      store(retPtr, moveId)
      moveArray[moveId] = 1
      matchedMoves++
    }
    else
      moveArray[moveId] = -1
  }
  
  if(matchedMoves >= 2)
    store(retPtr, -1)
}

0x0005f404 lh v1,0x0000(a0)
0x0005f408 addiu v0,r0,0x0001
0x0005f40c addiu t1,r0,0x0002
0x0005f410 beq r0,r0,0x0005f440
0x0005f414 addu t2,a3,r0
0x0005f418 addu t0,a0,t1
0x0005f41c lh t0,0x0000(t0)
0x0005f420 nop
0x0005f424 slt asmTemp,t0,v1
0x0005f428 beq asmTemp,r0,0x0005f438
0x0005f42c addu t3,t0,r0
0x0005f430 sll v1,t3,0x10
0x0005f434 sra v1,v1,0x10
0x0005f438 addi v0,v0,0x0001
0x0005f43c addi t1,t1,0x0002
0x0005f440 slt asmTemp,v0,t2
0x0005f444 bne asmTemp,r0,0x0005f418
0x0005f448 nop
0x0005f44c addu t2,r0,r0
0x0005f450 addu v0,r0,r0
0x0005f454 beq r0,r0,0x0005f49c
0x0005f458 addu t3,r0,r0
0x0005f45c addu t0,a0,t3
0x0005f460 lh t0,0x0000(t0)
0x0005f464 nop
0x0005f468 bne v1,t0,0x0005f488
0x0005f46c nop
0x0005f470 sh v0,0x0000(a2)
0x0005f474 addiu t1,r0,0x0001
0x0005f478 addu t0,a1,t3
0x0005f47c addi t2,t2,0x0001
0x0005f480 beq r0,r0,0x0005f494
0x0005f484 sh t1,0x0000(t0)
0x0005f488 addiu t1,r0,0xffff
0x0005f48c addu t0,a1,t3
0x0005f490 sh t1,0x0000(t0)
0x0005f494 addi v0,v0,0x0001
0x0005f498 addi t3,t3,0x0002
0x0005f49c slt asmTemp,v0,a3
0x0005f4a0 bne asmTemp,r0,0x0005f45c
0x0005f4a4 nop
0x0005f4a8 slti asmTemp,t2,0x0002
0x0005f4ac bne asmTemp,r0,0x0005f4bc
0x0005f4b0 nop
0x0005f4b4 addiu v0,r0,0xffff
0x0005f4b8 sh v0,0x0000(a2)
0x0005f4bc jr ra
0x0005f4c0 nop