/**
 * Sorts an array of values and an associated second array descending.
 * A third array will be filled with a ranking of the values, allowing
 * repetition.
 */
void sortMoveArrayAscending(powerArray, moveSlotArray, rankingArray, numMoves) {
  for(i = 0; i < numMoves; i++) {
    smallestValue = powerArray[i] // load(s1 + i * 4)
    swapIndex = i
    
    for(j = i; j < numMoves; j++) {
      localValue = powerArray[j] // load(s1 + j * 4)
      
      if(smallestValue > localValue) {
        swapIndex = j
        smallestValue = localValue
      }
    }
    
    swapValues(powerArray[i], powerArray[swapIndex])
    swapValues(moveSlotArray[i], moveSlotArray[swapIndex])
  }
  
  fillRankingArray(powerArray, rankingArray, numMoves)
}

0x0005f9d8 addiu sp,sp,0xffd0
0x0005f9dc sw ra,0x002c(sp)
0x0005f9e0 sw s6,0x0028(sp)
0x0005f9e4 sw s5,0x0024(sp)
0x0005f9e8 sw s4,0x0020(sp)
0x0005f9ec sw s3,0x001c(sp)
0x0005f9f0 sw s2,0x0018(sp)
0x0005f9f4 sw s1,0x0014(sp)
0x0005f9f8 sw s0,0x0010(sp)
0x0005f9fc addu s1,a0,r0
0x0005fa00 addu s2,a1,r0
0x0005fa04 addu s6,a2,r0
0x0005fa08 addu s5,a3,r0
0x0005fa0c addu s4,r0,r0
0x0005fa10 beq r0,r0,0x0005fa8c
0x0005fa14 addu s0,r0,r0
0x0005fa18 addu v0,s1,s0
0x0005fa1c lw a0,0x0000(v0)
0x0005fa20 addu a1,s4,r0
0x0005fa24 addu v1,s4,r0
0x0005fa28 beq r0,r0,0x0005fa58
0x0005fa2c sll a2,s4,0x02
0x0005fa30 addu v0,s1,a2
0x0005fa34 lw v0,0x0000(v0)
0x0005fa38 nop
0x0005fa3c slt asmTemp,v0,a0
0x0005fa40 beq asmTemp,r0,0x0005fa50
0x0005fa44 addu a3,v0,r0
0x0005fa48 addu a1,v1,r0
0x0005fa4c addu a0,a3,r0
0x0005fa50 addi v1,v1,0x0001
0x0005fa54 addi a2,a2,0x0004
0x0005fa58 slt asmTemp,v1,s5
0x0005fa5c bne asmTemp,r0,0x0005fa30
0x0005fa60 nop
0x0005fa64 sll v0,a1,0x02
0x0005fa68 addu a0,s1,s0
0x0005fa6c addu s3,v0,r0
0x0005fa70 jal 0x000e52c0
0x0005fa74 addu a1,s1,v0
0x0005fa78 addu a0,s2,s0
0x0005fa7c jal 0x000e52c0
0x0005fa80 addu a1,s2,s3
0x0005fa84 addi s4,s4,0x0001
0x0005fa88 addi s0,s0,0x0004
0x0005fa8c slt asmTemp,s4,s5
0x0005fa90 bne asmTemp,r0,0x0005fa18
0x0005fa94 nop
0x0005fa98 addu a0,s1,r0
0x0005fa9c addu a1,s6,r0
0x0005faa0 jal 0x0005fbb4
0x0005faa4 addu a2,s5,r0
0x0005faa8 lw ra,0x002c(sp)
0x0005faac lw s6,0x0028(sp)
0x0005fab0 lw s5,0x0024(sp)
0x0005fab4 lw s4,0x0020(sp)
0x0005fab8 lw s3,0x001c(sp)
0x0005fabc lw s2,0x0018(sp)
0x0005fac0 lw s1,0x0014(sp)
0x0005fac4 lw s0,0x0010(sp)
0x0005fac8 jr ra
0x0005facc addiu sp,sp,0x0030