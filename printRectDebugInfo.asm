void printRectDebugInfo(funcNamePtr, headerPtr) {
  state = load(0x116C56)
  
  xPos = headerPtr[0]
  yPos = headerPtr[1]
  xSize = headerPtr[2]
  ySize = headerPtr[3]
  
  if(state == 1) { // log error
    width = load(0x116C56 + 2)
    height = load(0x116C56 + 4)
    
    if(width >= xSize && width >= xSize + xPos 
        && height >= yPos && height >= yPos + y2
        && xSize > 0 && xPos >= 0 && yPos > 0 && ySize >= 0)
      return
  
    stringPtr = 0x113E58 // "%s:BAD RECT"
  }
  else if(state == 2) // log anything
    stringPtr = 0x113E78 // "%s:"
  else // log nothing 
    return
  
  // call function pointer loaded from 0x116C50 -> printf()
  printf(stringPtr, funcNamePtr)
  printf(0x113E64, xPos, yPos, xSize, ySize) // "(%d,%d)-(%d,%d)"
}

0x00092cbc addiu sp,sp,0xffe0
0x00092cc0 addu t0,a0,r0
0x00092cc4 sw s0,0x0018(sp)
0x00092cc8 lui a0,0x8011
0x00092ccc addiu a0,a0,0x6c56
0x00092cd0 sw ra,0x001c(sp)
0x00092cd4 lbu v1,0x0000(a0)
0x00092cd8 addiu v0,r0,0x0001
0x00092cdc beq v1,v0,0x00092cf8
0x00092ce0 addu s0,a1,r0
0x00092ce4 addiu v0,r0,0x0002
0x00092ce8 beq v1,v0,0x00092d84
0x00092cec nop
0x00092cf0 j 0x00092dc8
0x00092cf4 nop
0x00092cf8 lh a1,0x0004(s0)
0x00092cfc lh v1,0x0002(a0)
0x00092d00 nop
0x00092d04 slt v0,v1,a1
0x00092d08 bne v0,r0,0x00092d78
0x00092d0c nop
0x00092d10 lh a3,0x0000(s0)
0x00092d14 nop
0x00092d18 addu v0,a1,a3
0x00092d1c slt v0,v1,v0
0x00092d20 bne v0,r0,0x00092d78
0x00092d24 nop
0x00092d28 lh v1,0x0002(s0)
0x00092d2c lh a0,0x0004(a0)
0x00092d30 nop
0x00092d34 slt v0,a0,v1
0x00092d38 bne v0,r0,0x00092d78
0x00092d3c nop
0x00092d40 lh a2,0x0006(s0)
0x00092d44 nop
0x00092d48 addu v0,v1,a2
0x00092d4c slt v0,a0,v0
0x00092d50 bne v0,r0,0x00092d78
0x00092d54 nop
0x00092d58 blez a1,0x00092d78
0x00092d5c nop
0x00092d60 bltz a3,0x00092d78
0x00092d64 nop
0x00092d68 bltz v1,0x00092d78
0x00092d6c nop
0x00092d70 bgtz a2,0x00092dc8
0x00092d74 nop
0x00092d78 lui a0,0x8011
0x00092d7c j 0x00092d8c
0x00092d80 addiu a0,a0,0x3e58
0x00092d84 lui a0,0x8011
0x00092d88 addiu a0,a0,0x3e78
0x00092d8c lui v0,0x8011
0x00092d90 lw v0,0x6c50(v0)
0x00092d94 nop
0x00092d98 jalr v0,ra
0x00092d9c addu a1,t0,r0
0x00092da0 lh a1,0x0000(s0)
0x00092da4 lh a2,0x0002(s0)
0x00092da8 lh a3,0x0004(s0)
0x00092dac lh v1,0x0006(s0)
0x00092db0 lui v0,0x8011
0x00092db4 lw v0,0x6c50(v0)
0x00092db8 lui a0,0x8011
0x00092dbc addiu a0,a0,0x3e64
0x00092dc0 jalr v0,ra
0x00092dc4 sw v1,0x0010(sp)
0x00092dc8 lw ra,0x001c(sp)
0x00092dcc lw s0,0x0018(sp)
0x00092dd0 jr ra
0x00092dd4 addiu sp,sp,0x0020