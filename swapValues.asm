void swapValues(valPtr1, valPtr2) {
  tmp = load(valPtr1)
  store(valPtr1, load(valPtr2))
  store(valPtr2, tmp)
}

0x000e52c0 lw v1,0x0000(a0)
0x000e52c4 lw v0,0x0000(a1)
0x000e52c8 nop
0x000e52cc sw v0,0x0000(a0)
0x000e52d0 jr ra
0x000e52d4 sw v1,0x0000(a1)