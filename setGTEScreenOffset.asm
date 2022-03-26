void setGTEScreenOffset(offsetX, offsetY) {
  gte_cr24 = offsetX
  gte_cr25 = offsetY
}

0x0009b340 sll a0,a0,0x10
0x0009b344 sll a1,a1,0x10
0x0009b348 ctc2 a0,gtecr24_ofx
0x0009b34c ctc2 a1,gtecr25_ofy
0x0009b350 jr ra
0x0009b354 nop