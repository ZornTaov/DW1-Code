int entityCheckEntityCollision(entityPtr, entityPtr2, diffX, diffY) {
  
  entityType1 = load(entityPtr + 0x00)
  entityType2 = load(entityPtr2 + 0x00)
  
  locPtr1 = load(entityPtr + 0x04) + 0x78
  locPtr2 = load(entityPtr2 + 0x04) + 0x78
  
  radius1 = load(0x12CECC + entityType1 * 52) // radius
  radius2 = load(0x12CECC + entityType2 * 52) // radius
  
  array = short[4]
  array[0] = load(locPtr2 + 0x00) - radius2
  array[1] = load(locPtr2 + 0x08) + radius2
  array[2] = radius2 * 2
  array[3] = radius2 * 2
  
  posX1 = load(locPtr1 + 0x00)
  posY1 = load(locPtr1 + 0x08)
  
  xMin = posX1 - radius1
  xMax = posX1 + radius1
  yMax = posY1 + radius1
  yMin = posY1 - radius1
  
  if(load(0x134F0A) == 0 && load(0x12F344) == entityPtr) {
    isXDown = (load(0x134EE4) & ~load(0x134EE8)) & 0x40 // polled input and last polled input
    
    // check if there is a Digimon you try to talk to
    if(isXDown != 0 && load(entityPtr + 0x2E) == 0) {
      rotationPtr = load(entityPtr + 0x04) + 0x72
      rotation = load(rotationPtr)
      
      if(rotation > 0 && rotation < 0x0800)
        xMin = xMin - 50
      
      if(rotation >= 0x0801 && rotation < 0x1000)
        xMax = xMax + 50
        
      if(rotation < 0x0400 && rotation >= 0x0C01)
        yMin = yMin - 50
        
      if(rotation >= 0x0401 && rotation < 0x0C00)
        yMax = yMax + 50
    }
    
    if(isRectInRect(array, xMin, yMax, xMin, yMin) != 0)
      return 1
    
    if(isRectInRect(array, xMax, yMax, xMax, yMin) != 0)
      return 1
    
    if(isRectInRect(array, xMin, yMin, xMax, yMin) != 0)
      return 1
    
    if(isRectInRect(array, xMin, yMax, xMax, yMax) != 0)
      return 1
    
    return entityIsInEntity(entityPtr, entityPtr2)
  }
  else {
    if(diffX < 0 && isRectInRect(array, xMin, yMax, xMin, yMin) != 0)
      return 1
    
    if(diffX > 0 && isRectInRect(array, xMax, yMax, xMax, yMin) != 0)
      return 1
    
    if(diffY < 0 && isRectInRect(array, xMin, yMin, xMax, yMin) != 0)
      return 1
    
    if(diffY > 0 && isRectInRect(array, xMin, yMax, xMax, yMax) != 0)
      return 1
  }
  
  return 0
}

0x000d50dc addiu sp,sp,0xffb8
0x000d50e0 sw ra,0x0038(sp)
0x000d50e4 sw s7,0x0034(sp)
0x000d50e8 sw s6,0x0030(sp)
0x000d50ec sw s5,0x002c(sp)
0x000d50f0 sw s4,0x0028(sp)
0x000d50f4 sw s3,0x0024(sp)
0x000d50f8 sw s2,0x0020(sp)
0x000d50fc sw s1,0x001c(sp)
0x000d5100 sw s0,0x0018(sp)
0x000d5104 addu s4,a0,r0
0x000d5108 lw v0,0x0004(s4)
0x000d510c lw a0,0x0000(s4)
0x000d5110 addiu v1,v0,0x0078
0x000d5114 sll v0,a0,0x01
0x000d5118 add v0,v0,a0
0x000d511c sll v0,v0,0x02
0x000d5120 addu s5,a1,r0
0x000d5124 add v0,v0,a0
0x000d5128 lw a0,0x0004(s5)
0x000d512c addu s7,a3,r0
0x000d5130 lw a1,0x0000(s5)
0x000d5134 addiu a3,a0,0x0078
0x000d5138 sll a0,a1,0x01
0x000d513c add a0,a0,a1
0x000d5140 addu s6,a2,r0
0x000d5144 sll a0,a0,0x02
0x000d5148 lui a2,0x8013
0x000d514c add a0,a0,a1
0x000d5150 addiu a2,a2,0xcecc
0x000d5154 sll a0,a0,0x02
0x000d5158 addu a0,a2,a0
0x000d515c lh a1,0x0000(a0)
0x000d5160 sll v0,v0,0x02
0x000d5164 addu v0,a2,v0
0x000d5168 lw a0,0x0000(a3)
0x000d516c lh v0,0x0000(v0)
0x000d5170 sub a0,a0,a1
0x000d5174 sh a0,0x0040(sp)
0x000d5178 lw a0,0x0008(a3)
0x000d517c nop
0x000d5180 add a0,a0,a1
0x000d5184 sh a0,0x0042(sp)
0x000d5188 sll a0,a1,0x01
0x000d518c addu a1,a0,r0
0x000d5190 sh a0,0x0044(sp)
0x000d5194 sh a1,0x0046(sp)
0x000d5198 lw a0,0x0000(v1)
0x000d519c lw v1,0x0008(v1)
0x000d51a0 addu a1,a0,r0
0x000d51a4 sub s3,a0,v0
0x000d51a8 addu a0,v1,r0
0x000d51ac add s2,a1,v0
0x000d51b0 add s1,v1,v0
0x000d51b4 sub s0,a0,v0
0x000d51b8 lb v0,-0x6c22(gp)
0x000d51bc nop
0x000d51c0 bne v0,r0,0x000d5340
0x000d51c4 nop
0x000d51c8 lui asmTemp,0x8013
0x000d51cc lw v0,-0x0cbc(asmTemp)
0x000d51d0 nop
0x000d51d4 bne s4,v0,0x000d5340
0x000d51d8 nop
0x000d51dc lw v1,-0x6c44(gp)
0x000d51e0 lw v0,-0x6c48(gp)
0x000d51e4 nor v1,v1,r0
0x000d51e8 and v0,v0,v1
0x000d51ec andi v0,v0,0x0040
0x000d51f0 beq v0,r0,0x000d5288
0x000d51f4 nop
0x000d51f8 lbu v0,0x002e(s4)
0x000d51fc nop
0x000d5200 bne v0,r0,0x000d5288
0x000d5204 nop
0x000d5208 lw v0,0x0004(s4)
0x000d520c nop
0x000d5210 lh v0,0x0072(v0)
0x000d5214 nop
0x000d5218 slt asmTemp,r0,v0
0x000d521c beq asmTemp,r0,0x000d5234
0x000d5220 nop
0x000d5224 slti asmTemp,v0,0x0800
0x000d5228 beq asmTemp,r0,0x000d5234
0x000d522c nop
0x000d5230 addi s3,s3,-0x0032
0x000d5234 slti asmTemp,v0,0x0801
0x000d5238 bne asmTemp,r0,0x000d5250
0x000d523c nop
0x000d5240 slti asmTemp,v0,0x1000
0x000d5244 beq asmTemp,r0,0x000d5250
0x000d5248 nop
0x000d524c addi s2,s2,0x0032
0x000d5250 slti asmTemp,v0,0x0400
0x000d5254 bne asmTemp,r0,0x000d5268
0x000d5258 nop
0x000d525c slti asmTemp,v0,0x0c01
0x000d5260 bne asmTemp,r0,0x000d526c
0x000d5264 nop
0x000d5268 addi s0,s0,-0x0032
0x000d526c slti asmTemp,v0,0x0401
0x000d5270 bne asmTemp,r0,0x000d5288
0x000d5274 nop
0x000d5278 slti asmTemp,v0,0x0c00
0x000d527c beq asmTemp,r0,0x000d5288
0x000d5280 nop
0x000d5284 addi s1,s1,0x0032
0x000d5288 sw s0,0x0010(sp)
0x000d528c addiu a0,sp,0x0040
0x000d5290 addu a1,s3,r0
0x000d5294 addu a2,s1,r0
0x000d5298 jal 0x000d3858
0x000d529c addu a3,s3,r0
0x000d52a0 beq v0,r0,0x000d52b0
0x000d52a4 nop
0x000d52a8 beq r0,r0,0x000d5404
0x000d52ac addiu v0,r0,0x0001
0x000d52b0 sw s0,0x0010(sp)
0x000d52b4 addiu a0,sp,0x0040
0x000d52b8 addu a1,s2,r0
0x000d52bc addu a2,s1,r0
0x000d52c0 jal 0x000d3858
0x000d52c4 addu a3,s2,r0
0x000d52c8 beq v0,r0,0x000d52d8
0x000d52cc nop
0x000d52d0 beq r0,r0,0x000d5404
0x000d52d4 addiu v0,r0,0x0001
0x000d52d8 sw s0,0x0010(sp)
0x000d52dc addiu a0,sp,0x0040
0x000d52e0 addu a1,s3,r0
0x000d52e4 addu a2,s0,r0
0x000d52e8 jal 0x000d3858
0x000d52ec addu a3,s2,r0
0x000d52f0 beq v0,r0,0x000d5300
0x000d52f4 nop
0x000d52f8 beq r0,r0,0x000d5404
0x000d52fc addiu v0,r0,0x0001
0x000d5300 sw s1,0x0010(sp)
0x000d5304 addiu a0,sp,0x0040
0x000d5308 addu a1,s3,r0
0x000d530c addu a2,s1,r0
0x000d5310 jal 0x000d3858
0x000d5314 addu a3,s2,r0
0x000d5318 beq v0,r0,0x000d5328
0x000d531c addu a0,s4,r0
0x000d5320 beq r0,r0,0x000d5404
0x000d5324 addiu v0,r0,0x0001
0x000d5328 jal 0x000d31ac
0x000d532c addu a1,s5,r0
0x000d5330 beq v0,r0,0x000d5400
0x000d5334 nop
0x000d5338 beq r0,r0,0x000d5404
0x000d533c addiu v0,r0,0x0001
0x000d5340 bgez s6,0x000d5370
0x000d5344 nop
0x000d5348 sw s0,0x0010(sp)
0x000d534c addiu a0,sp,0x0040
0x000d5350 addu a1,s3,r0
0x000d5354 addu a2,s1,r0
0x000d5358 jal 0x000d3858
0x000d535c addu a3,s3,r0
0x000d5360 beq v0,r0,0x000d5370
0x000d5364 nop
0x000d5368 beq r0,r0,0x000d5404
0x000d536c addiu v0,r0,0x0001
0x000d5370 blez s6,0x000d53a0
0x000d5374 nop
0x000d5378 sw s0,0x0010(sp)
0x000d537c addiu a0,sp,0x0040
0x000d5380 addu a1,s2,r0
0x000d5384 addu a2,s1,r0
0x000d5388 jal 0x000d3858
0x000d538c addu a3,s2,r0
0x000d5390 beq v0,r0,0x000d53a0
0x000d5394 nop
0x000d5398 beq r0,r0,0x000d5404
0x000d539c addiu v0,r0,0x0001
0x000d53a0 bgez s7,0x000d53d0
0x000d53a4 nop
0x000d53a8 sw s0,0x0010(sp)
0x000d53ac addiu a0,sp,0x0040
0x000d53b0 addu a1,s3,r0
0x000d53b4 addu a2,s0,r0
0x000d53b8 jal 0x000d3858
0x000d53bc addu a3,s2,r0
0x000d53c0 beq v0,r0,0x000d53d0
0x000d53c4 nop
0x000d53c8 beq r0,r0,0x000d5404
0x000d53cc addiu v0,r0,0x0001
0x000d53d0 blez s7,0x000d5400
0x000d53d4 nop
0x000d53d8 sw s1,0x0010(sp)
0x000d53dc addiu a0,sp,0x0040
0x000d53e0 addu a1,s3,r0
0x000d53e4 addu a2,s1,r0
0x000d53e8 jal 0x000d3858
0x000d53ec addu a3,s2,r0
0x000d53f0 beq v0,r0,0x000d5400
0x000d53f4 nop
0x000d53f8 beq r0,r0,0x000d5404
0x000d53fc addiu v0,r0,0x0001
0x000d5400 addu v0,r0,r0
0x000d5404 lw ra,0x0038(sp)
0x000d5408 lw s7,0x0034(sp)
0x000d540c lw s6,0x0030(sp)
0x000d5410 lw s5,0x002c(sp)
0x000d5414 lw s4,0x0028(sp)
0x000d5418 lw s3,0x0024(sp)
0x000d541c lw s2,0x0020(sp)
0x000d5420 lw s1,0x001c(sp)
0x000d5424 lw s0,0x0018(sp)
0x000d5428 jr ra
0x000d542c addiu sp,sp,0x0048