void entityLookAtLocation(entityPtr, posPointer2) {
  if(posPointer2 == 0)
    return
  
  posPointer1 = load(entityPtr + 4) + 0x78
  
  locX1 = load(posPointer1)
  locY1 = load(posPointer1 + 0x08)
  
  locX2 = load(posPointer2)
  locY2 = load(posPointer2 + 0x08)
  
  angle = atan(locY2 - locY1, locX2 - locX1)
  store(somePtr + 0x72, angle)
}

0x000d459c addiu sp,sp,0xffe8
0x000d45a0 sw ra,0x0014(sp)
0x000d45a4 beq a1,r0,0x000d45dc
0x000d45a8 sw s0,0x0010(sp)
0x000d45ac lw s0,0x0004(a0)
0x000d45b0 lw v1,0x0000(a1)
0x000d45b4 addiu a0,s0,0x0078
0x000d45b8 lw v0,0x0000(a0)
0x000d45bc nop
0x000d45c0 sub a2,v1,v0
0x000d45c4 lw v1,0x0008(a1)
0x000d45c8 lw v0,0x0008(a0)
0x000d45cc addu a1,a2,r0
0x000d45d0 jal 0x000a37fc
0x000d45d4 sub a0,v1,v0
0x000d45d8 sh v0,0x0072(s0)
0x000d45dc lw ra,0x0014(sp)
0x000d45e0 lw s0,0x0010(sp)
0x000d45e4 jr ra
0x000d45e8 addiu sp,sp,0x0018