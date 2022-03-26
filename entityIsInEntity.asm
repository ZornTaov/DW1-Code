int entityIsInEntity(entityPtr, entityPtr2) {
  type1 = load(entityPtr + 0x00)
  locPtr1 = load(entityPtr + 0x04) + 0x78
  radius1 = load(0x12CECC + type1 * 52)
  
  type2 = load(entityPtr2 + 0x00)
  locPtr2 = load(entityPtr2 + 0x04) + 0x78
  radius2 = load(0x12CECC + type2 * 52)
  
  posX1 = load(locPtr1)
  posY1 = load(locPtr1 + 0x08)
  posX2 = load(locPtr2)
  posY2 = load(locPtr2 + 0x08)
  
  x1Min = posX1 - radius1
  x1Max = posX1 + radius1
  
  y1Min = posY1 - radius1
  y1Max = posY1 + radius1
  
  x2Min = posX2 - radius2
  x2Max = posX2 + radius2
  
  y2Min = posY2 - radius2
  y2Max = posY2 + radius2
  
  if(x2Max < x1Min)
    return 0
  
  if(x1Max < x2Min)
    return 0
  
  if(y2Max < y1Min)
    return 0
  
  if(y1Max < y2Min)
    return 0
  
  return 1
}

0x000d31ac lw v0,0x0004(a0)
0x000d31b0 lui a2,0x8013
0x000d31b4 lw a0,0x0000(a0)
0x000d31b8 addiu a2,a2,0xcecc
0x000d31bc sll v1,a0,0x01
0x000d31c0 add v1,v1,a0
0x000d31c4 sll v1,v1,0x02
0x000d31c8 add v1,v1,a0
0x000d31cc sll v1,v1,0x02
0x000d31d0 addu v1,a2,v1
0x000d31d4 lh t0,0x0000(v1)
0x000d31d8 lw a0,0x0000(a1)
0x000d31dc lw v1,0x0004(a1)
0x000d31e0 addiu v0,v0,0x0078
0x000d31e4 addiu a3,v1,0x0078
0x000d31e8 sll v1,a0,0x01
0x000d31ec add v1,v1,a0
0x000d31f0 sll v1,v1,0x02
0x000d31f4 add v1,v1,a0
0x000d31f8 sll v1,v1,0x02
0x000d31fc addu v1,a2,v1
0x000d3200 lh a1,0x0000(v1)
0x000d3204 addu t1,t0,r0
0x000d3208 lw v1,0x0000(v0)
0x000d320c nop
0x000d3210 addu t2,v1,r0
0x000d3214 sub a0,v1,t0
0x000d3218 lw v1,0x0000(a3)
0x000d321c nop
0x000d3220 addu t0,v1,r0
0x000d3224 add v1,v1,a1
0x000d3228 slt asmTemp,v1,a0
0x000d322c beq asmTemp,r0,0x000d323c
0x000d3230 addu a2,a1,r0
0x000d3234 beq r0,r0,0x000d32a0
0x000d3238 addu v0,r0,r0
0x000d323c add a0,t2,t1
0x000d3240 sub v1,t0,a2
0x000d3244 slt asmTemp,a0,v1
0x000d3248 beq asmTemp,r0,0x000d3258
0x000d324c nop
0x000d3250 beq r0,r0,0x000d32a0
0x000d3254 addu v0,r0,r0
0x000d3258 lw v1,0x0008(v0)
0x000d325c lw v0,0x0008(a3)
0x000d3260 addu a1,v1,r0
0x000d3264 addu a0,v0,r0
0x000d3268 sub v1,v1,t1
0x000d326c add v0,v0,a2
0x000d3270 slt asmTemp,v0,v1
0x000d3274 beq asmTemp,r0,0x000d3284
0x000d3278 nop
0x000d327c beq r0,r0,0x000d32a0
0x000d3280 addu v0,r0,r0
0x000d3284 add v1,a1,t1
0x000d3288 sub v0,a0,a2
0x000d328c slt asmTemp,v1,v0
0x000d3290 beq asmTemp,r0,0x000d32a0
0x000d3294 addiu v0,r0,0x0001
0x000d3298 beq r0,r0,0x000d32a0
0x000d329c addu v0,r0,r0
0x000d32a0 jr ra
0x000d32a4 nop
