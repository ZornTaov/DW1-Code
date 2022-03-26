/**
 * Takes an array of values and fills another given array with a ranking of
 * those values, starting at 0 and repeating if two powers are equal.
 */
void fillRankingArray(powerArray, rankingArray, numMoves) {
  rankingIndex = 0
  rankingArray[0] = 0
  
  for(i = 1; i < numMoves; i++) {
    if(powerArray[i] != powerArray[i - 1])
      rankingIndex++
    
    rankingArray[i] = rankingIndex
  }
}

0x0005fbb4 addu t0,r0,r0
0x0005fbb8 sw r0,0x0000(a1)
0x0005fbbc addiu a3,r0,0x0001
0x0005fbc0 beq r0,r0,0x0005fc04
0x0005fbc4 addiu t1,r0,0x0004
0x0005fbc8 addu v0,a0,t1
0x0005fbcc lw v1,0x0000(v0)
0x0005fbd0 lw v0,-0x0004(v0)
0x0005fbd4 nop
0x0005fbd8 bne v1,v0,0x0005fbec
0x0005fbdc nop
0x0005fbe0 addu v0,a1,t1
0x0005fbe4 beq r0,r0,0x0005fbfc
0x0005fbe8 sw t0,0x0000(v0)
0x0005fbec addi v1,t0,0x0001
0x0005fbf0 addu v0,a1,t1
0x0005fbf4 addu t0,v1,r0
0x0005fbf8 sw v1,0x0000(v0)
0x0005fbfc addi a3,a3,0x0001
0x0005fc00 addi t1,t1,0x0004
0x0005fc04 slt asmTemp,a3,a2
0x0005fc08 bne asmTemp,r0,0x0005fbc8
0x0005fc0c nop
0x0005fc10 jr ra
0x0005fc14 nop