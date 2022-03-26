/**
 * Checks whether position B has moved outside of a rectangle with given
 * width and height centered in the middle of the screen, i.e. the combat area.
 *
 * Return 1 when the new position has moved outside, 0 otherwise.
 */
int hasMovedOutsideCombatArea(screenPosOld, screenPosNew, width, height) {
  posX = screenPosNew[0] - load(0x134D8C) // transform coordinate
  posY = screenPosNew[1] - load(0x134D88) // transform coordinate
  
  if(screenPosOld[0] > screenPosNew[0] && posX < -width / 2)
    return 1
  
  if(screenPosOld[0] < screenPosNew[0] && posX >  width / 2)
    return 1
  
  if(screenPosOld[1] > screenPosNew[1] && posY < -height / 2)
    return 1
  
  if(screenPosOld[1] < screenPosNew[1] && posY >  height / 2)
    return 1
  
  return 0
}

0x000d38d4 lh t0,0x0000(a1)
0x000d38d8 lw v1,-0x6da0(gp)
0x000d38dc addu v0,t0,r0
0x000d38e0 sub t0,t0,v1
0x000d38e4 sub v1,r0,a2
0x000d38e8 addu t1,t0,r0
0x000d38ec addu t2,a2,r0
0x000d38f0 bgez v1,0x000d3900
0x000d38f4 sra t9,v1,0x01
0x000d38f8 addiu v1,v1,0x0001
0x000d38fc sra t9,v1,0x01
0x000d3900 slt asmTemp,t0,t9
0x000d3904 beq asmTemp,r0,0x000d3928
0x000d3908 nop
0x000d390c lh v1,0x0000(a0)
0x000d3910 nop
0x000d3914 slt asmTemp,v0,v1
0x000d3918 beq asmTemp,r0,0x000d3928
0x000d391c nop
0x000d3920 beq r0,r0,0x000d39f0
0x000d3924 addiu v0,r0,0x0001
0x000d3928 bgez t2,0x000d3938
0x000d392c sra t9,t2,0x01
0x000d3930 addiu v1,t2,0x0001
0x000d3934 sra t9,v1,0x01
0x000d3938 slt asmTemp,t9,t1
0x000d393c beq asmTemp,r0,0x000d3960
0x000d3940 nop
0x000d3944 lh v1,0x0000(a0)
0x000d3948 nop
0x000d394c slt asmTemp,v1,v0
0x000d3950 beq asmTemp,r0,0x000d3960
0x000d3954 nop
0x000d3958 beq r0,r0,0x000d39f0
0x000d395c addiu v0,r0,0x0001
0x000d3960 lh v1,0x0002(a1)
0x000d3964 lw v0,-0x6da4(gp)
0x000d3968 addu a1,v1,r0
0x000d396c sub v1,v1,v0
0x000d3970 sub v0,r0,a3
0x000d3974 addu a2,v1,r0
0x000d3978 addu t0,a3,r0
0x000d397c bgez v0,0x000d398c
0x000d3980 sra t9,v0,0x01
0x000d3984 addiu v0,v0,0x0001
0x000d3988 sra t9,v0,0x01
0x000d398c slt asmTemp,v1,t9
0x000d3990 beq asmTemp,r0,0x000d39b4
0x000d3994 nop
0x000d3998 lh v0,0x0002(a0)
0x000d399c nop
0x000d39a0 slt asmTemp,a1,v0
0x000d39a4 beq asmTemp,r0,0x000d39b4
0x000d39a8 nop
0x000d39ac beq r0,r0,0x000d39f0
0x000d39b0 addiu v0,r0,0x0001
0x000d39b4 bgez t0,0x000d39c4
0x000d39b8 sra t9,t0,0x01
0x000d39bc addiu v0,t0,0x0001
0x000d39c0 sra t9,v0,0x01
0x000d39c4 slt asmTemp,t9,a2
0x000d39c8 beq asmTemp,r0,0x000d39ec
0x000d39cc nop
0x000d39d0 lh v0,0x0002(a0)
0x000d39d4 nop
0x000d39d8 slt asmTemp,v0,a1
0x000d39dc beq asmTemp,r0,0x000d39ec
0x000d39e0 nop
0x000d39e4 beq r0,r0,0x000d39f0
0x000d39e8 addiu v0,r0,0x0001
0x000d39ec addu v0,r0,r0
0x000d39f0 jr ra
0x000d39f4 nop