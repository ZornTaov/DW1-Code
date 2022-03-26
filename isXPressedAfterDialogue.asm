int isXPressedAfterDialogue() { // is X still held after entering the dialogue
  if(load(0x135028) == 0) // X has been released
    return 1
  
  if(load(0x134EE4) & 0x40 != 0) // X is still pressed
    return 0
  
  store(0x135028, 0) // set X released
  return 1
}

0x000fc098 lw v0,-0x6b04(gp)
0x000fc09c nop
0x000fc0a0 beq v0,r0,0x000fc0c8
0x000fc0a4 nop
0x000fc0a8 lw v0,-0x6c48(gp)
0x000fc0ac nop
0x000fc0b0 andi v0,v0,0x0040
0x000fc0b4 beq v0,r0,0x000fc0c4
0x000fc0b8 nop
0x000fc0bc beq r0,r0,0x000fc0cc
0x000fc0c0 addu v0,r0,r0
0x000fc0c4 sw r0,-0x6b04(gp)
0x000fc0c8 addiu v0,r0,0x0001
0x000fc0cc jr ra
0x000fc0d0 nop