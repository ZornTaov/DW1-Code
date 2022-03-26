int getMoveCommandAttack(combatId, moveArray) {
  moveId = getStrongestMove(combatId, moveArray)
  
  if(moveId != -1)
    return moveId
  
  moveId = getBestTypeMove(combatId, moveArray)
  
  if(moveId != -1)
    return moveId
    
  return selectRandomMove(moveArray)
}

0x0005fdb4 addiu sp,sp,0xffe0
0x0005fdb8 sw ra,0x0018(sp)
0x0005fdbc sw s1,0x0014(sp)
0x0005fdc0 sw s0,0x0010(sp)
0x0005fdc4 addu s1,a0,r0
0x0005fdc8 jal 0x0005efcc
0x0005fdcc addu s0,a1,r0
0x0005fdd0 sll v0,v0,0x10
0x0005fdd4 sra v0,v0,0x10
0x0005fdd8 addiu asmTemp,r0,0xffff
0x0005fddc beq v0,asmTemp,0x0005fdec
0x0005fde0 addu a0,s1,r0
0x0005fde4 beq r0,r0,0x0005fe1c
0x0005fde8 lw ra,0x0018(sp)
0x0005fdec jal 0x0005f0c0
0x0005fdf0 addu a1,s0,r0
0x0005fdf4 sll v0,v0,0x10
0x0005fdf8 sra v0,v0,0x10
0x0005fdfc addiu asmTemp,r0,0xffff
0x0005fe00 beq v0,asmTemp,0x0005fe10
0x0005fe04 nop
0x0005fe08 beq r0,r0,0x0005fe1c
0x0005fe0c lw ra,0x0018(sp)
0x0005fe10 jal 0x0005ef58
0x0005fe14 addu a0,s0,r0
0x0005fe18 lw ra,0x0018(sp)
0x0005fe1c lw s1,0x0014(sp)
0x0005fe20 lw s0,0x0010(sp)
0x0005fe24 jr ra
0x0005fe28 addiu sp,sp,0x0020