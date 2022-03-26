/**
 * Copies 12 bytes from src to (dest + 20)
 * Returns the dest address.
 */
copy12toOffset20(dest, src) {
  t0 = load(a1)
  t1 = load(a1 + 0x04)
  t2 = load(a1 + 0x08)
  
  store(a0 + 0x14, t0)
  store(a0 + 0x18, t1)
  store(a0 + 0x1C, t2)

  return a0
}

0x0009b090 lw t0,0x0000(a1)
0x0009b094 lw t1,0x0004(a1)
0x0009b098 lw t2,0x0008(a1)
0x0009b09c sw t0,0x0014(a0)
0x0009b0a0 sw t1,0x0018(a0)
0x0009b0a4 sw t2,0x001c(a0)
0x0009b0a8 addu v0,a0,r0
0x0009b0ac jr ra
0x0009b0b0 nop