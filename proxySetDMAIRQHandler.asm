int proxySetDMAIRQHandler(stringPtr, arrayPtr) {
  v0 = load(0x116AE4) // 0x116AC4
  v0 = load(v0 + 0x04) // 0x00092708
  
  return setDMAIRQHandler(stringPtr, arrayPtr) // called from v0
}

0x000923ac lui v0,0x8011
0x000923b0 lw v0,0x6ae4(v0)
0x000923b4 addiu sp,sp,0xffe8
0x000923b8 sw ra,0x0010(sp)
0x000923bc lw v0,0x0004(v0)
0x000923c0 nop
0x000923c4 jalr v0,ra
0x000923c8 nop
0x000923cc lw ra,0x0010(sp)
0x000923d0 addiu sp,sp,0x0018
0x000923d4 jr ra
0x000923d8 nop