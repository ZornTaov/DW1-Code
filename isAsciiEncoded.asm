int isAsciiEncoded(charPtr) {
  return load(charPtr) >> 7 == 0 ? 1 : 0
}

0x000f18a4 lb v0,0x0000(a0)
0x000f18a8 nop
0x000f18ac sra v0,v0,0x07
0x000f18b0 bne v0,r0,0x000f18c0
0x000f18b4 addu v0,r0,r0
0x000f18b8 beq r0,r0,0x000f18c0
0x000f18bc addiu v0,r0,0x0001
0x000f18c0 jr ra
0x000f18c4 nop