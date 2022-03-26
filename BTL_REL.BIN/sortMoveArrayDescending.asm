/**
 * Sorts an array of values and an associated second array descending.
 * A third array will be filled with a ranking of the values, allowing
 * repetition.
 */
void sortMoveArrayDescending(powerArray, moveSlotArray, rankingArray, numMoves) {
  for(i = 0; i < numMoves; i++) {
    biggestValue = powerArray[i] // load(s1 + i * 4)
    swapIndex = i
    
    for(j = i; j < numMoves; j++) {
      localValue = powerArray[j] // load(s1 + j * 4)
      
      if(biggestValue < localValue) {
        swapIndex = j
        biggestValue = localValue
      }
    }
    
    swapValues(powerArray[i], powerArray[swapIndex])
    swapValues(moveSlotArray[i], moveSlotArray[swapIndex])
  }
  
  fillRankingArray(powerArray, rankingArray, numMoves)
}

0x0005f8e0 addiu sp,sp,0xffd0
0x0005f8e4 sw ra,0x002c(sp)
0x0005f8e8 sw s6,0x0028(sp)
0x0005f8ec sw s5,0x0024(sp)
0x0005f8f0 sw s4,0x0020(sp)
0x0005f8f4 sw s3,0x001c(sp)
0x0005f8f8 sw s2,0x0018(sp)
0x0005f8fc sw s1,0x0014(sp)
0x0005f900 sw s0,0x0010(sp)
0x0005f904 addu s1,a0,r0
0x0005f908 addu s2,a1,r0
0x0005f90c addu s6,a2,r0
0x0005f910 addu s5,a3,r0
0x0005f914 addu s4,r0,r0
0x0005f918 beq r0,r0,0x0005f994
0x0005f91c addu s0,r0,r0
0x0005f920 addu v0,s1,s0
0x0005f924 lw a0,0x0000(v0)
0x0005f928 addu a1,s4,r0
0x0005f92c addu v1,s4,r0
0x0005f930 beq r0,r0,0x0005f960
0x0005f934 sll a2,s4,0x02
0x0005f938 addu v0,s1,a2
0x0005f93c lw v0,0x0000(v0)
0x0005f940 nop
0x0005f944 slt asmTemp,a0,v0
0x0005f948 beq asmTemp,r0,0x0005f958
0x0005f94c addu a3,v0,r0
0x0005f950 addu a1,v1,r0
0x0005f954 addu a0,a3,r0
0x0005f958 addi v1,v1,0x0001
0x0005f95c addi a2,a2,0x0004
0x0005f960 slt asmTemp,v1,s5
0x0005f964 bne asmTemp,r0,0x0005f938
0x0005f968 nop
0x0005f96c sll v0,a1,0x02
0x0005f970 addu a0,s1,s0
0x0005f974 addu s3,v0,r0
0x0005f978 jal 0x000e52c0
0x0005f97c addu a1,s1,v0
0x0005f980 addu a0,s2,s0
0x0005f984 jal 0x000e52c0
0x0005f988 addu a1,s2,s3
0x0005f98c addi s4,s4,0x0001
0x0005f990 addi s0,s0,0x0004
0x0005f994 slt asmTemp,s4,s5
0x0005f998 bne asmTemp,r0,0x0005f920
0x0005f99c nop
0x0005f9a0 addu a0,s1,r0
0x0005f9a4 addu a1,s6,r0
0x0005f9a8 jal 0x0005fbb4
0x0005f9ac addu a2,s5,r0
0x0005f9b0 lw ra,0x002c(sp)
0x0005f9b4 lw s6,0x0028(sp)
0x0005f9b8 lw s5,0x0024(sp)
0x0005f9bc lw s4,0x0020(sp)
0x0005f9c0 lw s3,0x001c(sp)
0x0005f9c4 lw s2,0x0018(sp)
0x0005f9c8 lw s1,0x0014(sp)
0x0005f9cc lw s0,0x0010(sp)
0x0005f9d0 jr ra
0x0005f9d4 addiu sp,sp,0x0030