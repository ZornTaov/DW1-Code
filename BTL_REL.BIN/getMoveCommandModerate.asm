int getMoveCommandModerate(combatId, moveArray) {
  v0 = getCheapestMove(combatId, moveArray)
  
  if(v0 != -1)
    return v0
    
  v0 = getBestTypeMove(combatId, moveArray)
  
  if(v0 != -1)
    return v0
    
  return selectRandomMove(moveArray)
}

0x0005fe2c addiu sp,sp,0xffe0
0x0005fe30 sw ra,0x0018(sp)
0x0005fe34 sw s1,0x0014(sp)
0x0005fe38 sw s0,0x0010(sp)
0x0005fe3c addu s1,a0,r0
0x0005fe40 jal 0x0005f244
0x0005fe44 addu s0,a1,r0
0x0005fe48 sll v0,v0,0x10
0x0005fe4c sra v0,v0,0x10
0x0005fe50 addiu asmTemp,r0,0xffff
0x0005fe54 beq v0,asmTemp,0x0005fe64
0x0005fe58 addu a0,s1,r0
0x0005fe5c beq r0,r0,0x0005fe94
0x0005fe60 lw ra,0x0018(sp)
0x0005fe64 jal 0x0005f0c0
0x0005fe68 addu a1,s0,r0
0x0005fe6c sll v0,v0,0x10
0x0005fe70 sra v0,v0,0x10
0x0005fe74 addiu asmTemp,r0,0xffff
0x0005fe78 beq v0,asmTemp,0x0005fe88
0x0005fe7c nop
0x0005fe80 beq r0,r0,0x0005fe94
0x0005fe84 lw ra,0x0018(sp)
0x0005fe88 jal 0x0005ef58
0x0005fe8c addu a0,s0,r0
0x0005fe90 lw ra,0x0018(sp)
0x0005fe94 lw s1,0x0014(sp)
0x0005fe98 lw s0,0x0010(sp)
0x0005fe9c jr ra
0x0005fea0 addiu sp,sp,0x0020