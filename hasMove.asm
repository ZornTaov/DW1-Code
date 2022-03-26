int hasMove(moveId) {
  moveAddress = moveId / 32
  moveBit = moveId & 0x1F
  
  if(moveId < 0 && moveBit == 0) // negative input, should never happen, will bug out
    moveBit -= 32
  
  moveValue = load(0x155800 + moveAddress * 4)
  moveFlag = 1 << moveBit
  
  return moveValue & moveFlag != 0 ? 1 : 0
}

0x000e5eb4 bgez a0,0x000e5ec4
0x000e5eb8 sra t9,a0,0x05
0x000e5ebc addiu v0,a0,0x001f
0x000e5ec0 sra t9,v0,0x05
0x000e5ec4 lui v0,0x8015
0x000e5ec8 sll v1,t9,0x02
0x000e5ecc addiu v0,v0,0x5800
0x000e5ed0 addu v1,v0,v1
0x000e5ed4 bgez a0,0x000e5ee8
0x000e5ed8 andi a1,a0,0x001f
0x000e5edc beq a1,r0,0x000e5ee8
0x000e5ee0 nop
0x000e5ee4 addiu a1,a1,0xffe0
0x000e5ee8 addiu v0,r0,0x0001
0x000e5eec lw v1,0x0000(v1)
0x000e5ef0 sllv a0,v0,a1
0x000e5ef4 and v1,v1,a0
0x000e5ef8 beq v1,r0,0x000e5f08
0x000e5efc nop
0x000e5f00 beq r0,r0,0x000e5f0c
0x000e5f04 nop
0x000e5f08 addu v0,r0,r0
0x000e5f0c jr ra
0x000e5f10 nop