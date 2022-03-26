int isRectInRect(array, xMin, yMin, xMax, yMax) {
  posYmin = array[1] - array[3]
  posXmax = array[0] + array[2]
  
  if(posXmax < xMin)
    return 0
    
  if(xMax < array[0])
    return 0
  
  if(yMin < posYmin)
    return 0
  
  if(array[1] < yMax)
    return 0
    
  return 1
}

0x000d3858 lh v1,0x0002(a0)
0x000d385c lh v0,0x0006(a0)
0x000d3860 addu t1,v1,r0
0x000d3864 sub t0,v1,v0
0x000d3868 lh v1,0x0004(a0)
0x000d386c lh v0,0x0000(a0)
0x000d3870 lw t2,0x0010(sp)
0x000d3874 addu a0,v0,r0
0x000d3878 add v0,v0,v1
0x000d387c slt asmTemp,v0,a1
0x000d3880 beq asmTemp,r0,0x000d3890
0x000d3884 nop
0x000d3888 beq r0,r0,0x000d38cc
0x000d388c addu v0,r0,r0
0x000d3890 slt asmTemp,a3,a0
0x000d3894 beq asmTemp,r0,0x000d38a4
0x000d3898 nop
0x000d389c beq r0,r0,0x000d38cc
0x000d38a0 addu v0,r0,r0
0x000d38a4 slt asmTemp,a2,t0
0x000d38a8 beq asmTemp,r0,0x000d38b8
0x000d38ac nop
0x000d38b0 beq r0,r0,0x000d38cc
0x000d38b4 addu v0,r0,r0
0x000d38b8 slt asmTemp,t1,t2
0x000d38bc beq asmTemp,r0,0x000d38cc
0x000d38c0 addiu v0,r0,0x0001
0x000d38c4 beq r0,r0,0x000d38cc
0x000d38c8 addu v0,r0,r0
0x000d38cc jr ra
0x000d38d0 nop