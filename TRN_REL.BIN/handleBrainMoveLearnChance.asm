int handleBrainMoveLearnChance(digimonType) {
  specArray = byte[3]
  
  for(specId = 0; specId < 3; specId++) {
    specArray[specId] = load(0x12CED2 + digimonType * 52 + specId)
  }
  
  moveArray = { -1, -1, -1 }
  chanceArray = { -1, -1, -1 }
  
  for(i = 0; i < 3; i++) {
    spec = specArray[i]
    if(spec == -1)
      continue
    
    for(j = 0; j < 8; j++) {
      moveId = load(0x8F14C + spec * 8 + j)
      if(hasMove(moveId) == 1)
        continue
      
      partnerType = load(0x1557A8) // loaded in this function, ignores digimonType parameter
      moveChance = load(0x8F184 + j * 3 + i)
      
      for(k = 0; k < 0x10; k++) {
        if(moveId != load(0x12CED7 + partnerType * 52 + k)) // can learn move
          continue
        
        moveArray[i] = moveId
        chanceArray[i] = moveChance
      }
      
      if(moveArray[i] != -1 || chanceArray[i] != -1)
        break
    }
  }
  
  bestMove = moveArray[0]
  bestChance = chanceArray[0]
  
  if(bestChance < chanceArray[1]) {
    bestChance = chanceArray[1]
    bestMove = moveArray[1]
  }
  
  if(bestChance < chanceArray[2]) {
    bestChance = chanceArray[2]
    bestMove = moveArray[2]
  }
  
  if(random(100) >= bestChance)
    return 0
    
  learnMove(bestMove)
  
  moveName = load(0x126054 + bestMove * 4)
  renderString(moveName, 0, 0x78)
  
  moveNameLength = strlen(moveName)
  store(0x135392, moveNameLength)
  
  renderString(0x8F19C, 0, 0x84) // render "was mastered!"
  
  // parameters 4-7 passed via sp+0x10 to sp+0x1C
  0x000B8E50(2, -88, 18, 176, 0x23, 0x02, 0, 0x8A9F8)
  store(0x135388, 1)
  
  return 1
}

0x0008a744 addiu sp,sp,0xffb8
0x0008a748 sw ra,0x0030(sp)
0x0008a74c sll v0,a0,0x01
0x0008a750 sw s3,0x002c(sp)
0x0008a754 add v0,v0,a0
0x0008a758 sw s2,0x0028(sp)
0x0008a75c sll v0,v0,0x02
0x0008a760 sw s1,0x0024(sp)
0x0008a764 add v0,v0,a0
0x0008a768 sw s0,0x0020(sp)
0x0008a76c addu a1,r0,r0
0x0008a770 beq r0,r0,0x0008a798
0x0008a774 sll a0,v0,0x02
0x0008a778 lui v0,0x8013
0x0008a77c addiu v0,v0,0xced2
0x0008a780 addu v0,v0,a0
0x0008a784 addu v0,a1,v0
0x0008a788 lbu v1,0x0000(v0)
0x0008a78c addu v0,sp,a1
0x0008a790 sb v1,0x003c(v0)
0x0008a794 addi a1,a1,0x0001
0x0008a798 slti asmTemp,a1,0x0003
0x0008a79c bne asmTemp,r0,0x0008a778
0x0008a7a0 nop
0x0008a7a4 addiu v0,r0,0xffff
0x0008a7a8 sb v0,0x0042(sp)
0x0008a7ac sb v0,0x0046(sp)
0x0008a7b0 sb v0,0x0041(sp)
0x0008a7b4 sb v0,0x0045(sp)
0x0008a7b8 sb v0,0x0040(sp)
0x0008a7bc sb v0,0x0044(sp)
0x0008a7c0 beq r0,r0,0x0008a8dc
0x0008a7c4 addu s0,r0,r0
0x0008a7c8 addu v1,sp,s0
0x0008a7cc lbu v0,0x003c(v1)
0x0008a7d0 addiu asmTemp,r0,0x00ff
0x0008a7d4 beq v0,asmTemp,0x0008a8d8
0x0008a7d8 nop
0x0008a7dc sll v0,v0,0x03
0x0008a7e0 addu s3,r0,r0
0x0008a7e4 add s1,r0,v0
0x0008a7e8 beq r0,r0,0x0008a8cc
0x0008a7ec addu s2,r0,r0
0x0008a7f0 lui v0,0x8009
0x0008a7f4 addiu v0,v0,0xf14c
0x0008a7f8 addu v0,v0,s1
0x0008a7fc lbu a0,0x0000(v0)
0x0008a800 jal 0x000e5eb4
0x0008a804 nop
0x0008a808 addiu asmTemp,r0,0x0001
0x0008a80c beq v0,asmTemp,0x0008a8c0
0x0008a810 nop
0x0008a814 lui asmTemp,0x8015
0x0008a818 lw a0,0x57a8(asmTemp)
0x0008a81c nop
0x0008a820 sll v1,a0,0x01
0x0008a824 add v1,v1,a0
0x0008a828 sll v1,v1,0x02
0x0008a82c add v1,v1,a0
0x0008a830 sll a0,v1,0x02
0x0008a834 lui v1,0x8009
0x0008a838 addiu v1,v1,0xf14c
0x0008a83c addu v1,v1,s1
0x0008a840 lbu a1,0x0000(v1)
0x0008a844 lui v1,0x8009
0x0008a848 addiu v1,v1,0xf184
0x0008a84c addu v1,v1,s2
0x0008a850 addu v1,s0,v1
0x0008a854 lb a2,0x0000(v1)
0x0008a858 beq r0,r0,0x0008a890
0x0008a85c addu v0,r0,r0
0x0008a860 lui v1,0x8013
0x0008a864 addiu v1,v1,0xced7
0x0008a868 addu v1,v1,a0
0x0008a86c addu v1,v0,v1
0x0008a870 lbu v1,0x0000(v1)
0x0008a874 nop
0x0008a878 bne a1,v1,0x0008a88c
0x0008a87c nop
0x0008a880 addu v1,sp,s0
0x0008a884 sb a1,0x0040(v1)
0x0008a888 sb a2,0x0044(v1)
0x0008a88c addi v0,v0,0x0001
0x0008a890 slti asmTemp,v0,0x0010
0x0008a894 bne asmTemp,r0,0x0008a860
0x0008a898 nop
0x0008a89c addu v1,sp,s0
0x0008a8a0 lb v0,0x0040(v1)
0x0008a8a4 addiu asmTemp,r0,0xffff
0x0008a8a8 beq v0,asmTemp,0x0008a8c0
0x0008a8ac nop
0x0008a8b0 lb v0,0x0044(v1)
0x0008a8b4 addiu asmTemp,r0,0xffff
0x0008a8b8 bne v0,asmTemp,0x0008a8d8
0x0008a8bc nop
0x0008a8c0 addi s3,s3,0x0001
0x0008a8c4 addi s2,s2,0x0003
0x0008a8c8 addi s1,s1,0x0001
0x0008a8cc slti asmTemp,s3,0x0008
0x0008a8d0 bne asmTemp,r0,0x0008a7f0
0x0008a8d4 nop
0x0008a8d8 addi s0,s0,0x0001
0x0008a8dc slti asmTemp,s0,0x0003
0x0008a8e0 bne asmTemp,r0,0x0008a7c8
0x0008a8e4 nop
0x0008a8e8 lb v1,0x0044(sp)
0x0008a8ec lb v0,0x0045(sp)
0x0008a8f0 lb s1,0x0040(sp)
0x0008a8f4 addu s0,v1,r0
0x0008a8f8 slt asmTemp,v1,v0
0x0008a8fc beq asmTemp,r0,0x0008a910
0x0008a900 addu a0,v0,r0
0x0008a904 sll s0,a0,0x18
0x0008a908 lb s1,0x0041(sp)
0x0008a90c sra s0,s0,0x18
0x0008a910 lb v0,0x0046(sp)
0x0008a914 nop
0x0008a918 slt asmTemp,s0,v0
0x0008a91c beq asmTemp,r0,0x0008a930
0x0008a920 addu v1,v0,r0
0x0008a924 sll s0,v1,0x18
0x0008a928 lb s1,0x0042(sp)
0x0008a92c sra s0,s0,0x18
0x0008a930 jal 0x000a36d4
0x0008a934 addiu a0,r0,0x0064
0x0008a938 slt asmTemp,v0,s0
0x0008a93c beq asmTemp,r0,0x0008a9dc
0x0008a940 addu v0,r0,r0
0x0008a944 jal 0x000e5f14
0x0008a948 addu a0,s1,r0
0x0008a94c lui v0,0x8012
0x0008a950 sll v1,s1,0x02
0x0008a954 addiu v0,v0,0x6054
0x0008a958 addu v0,v0,v1
0x0008a95c lw a0,0x0000(v0)
0x0008a960 addu s0,v1,r0
0x0008a964 addu a1,r0,r0
0x0008a968 jal 0x0010cf24
0x0008a96c addiu a2,r0,0x0078
0x0008a970 lui v0,0x8012
0x0008a974 addiu v0,v0,0x6054
0x0008a978 addu v0,v0,s0
0x0008a97c lw a0,0x0000(v0)
0x0008a980 jal 0x0009121c
0x0008a984 nop
0x0008a988 lui a0,0x8009
0x0008a98c sb v0,-0x679a(gp)
0x0008a990 addiu a0,a0,0xf19c
0x0008a994 addu a1,r0,r0
0x0008a998 jal 0x0010cf24
0x0008a99c addiu a2,r0,0x0084
0x0008a9a0 addiu v0,r0,0x0023
0x0008a9a4 sw v0,0x0010(sp)
0x0008a9a8 addiu a0,r0,0x0002
0x0008a9ac sw a0,0x0014(sp)
0x0008a9b0 lui v0,0x8009
0x0008a9b4 sw r0,0x0018(sp)
0x0008a9b8 addiu v0,v0,0xa9f8
0x0008a9bc sw v0,0x001c(sp)
0x0008a9c0 addiu a1,r0,0xffa8
0x0008a9c4 addiu a2,r0,0x0012
0x0008a9c8 jal 0x000b8e50
0x0008a9cc addiu a3,r0,0x00b0
0x0008a9d0 addiu v0,r0,0x0001
0x0008a9d4 beq r0,r0,0x0008a9dc
0x0008a9d8 sw v0,-0x67a4(gp)
0x0008a9dc lw ra,0x0030(sp)
0x0008a9e0 lw s3,0x002c(sp)
0x0008a9e4 lw s2,0x0028(sp)
0x0008a9e8 lw s1,0x0024(sp)
0x0008a9ec lw s0,0x0020(sp)
0x0008a9f0 jr ra
0x0008a9f4 addiu sp,sp,0x0048