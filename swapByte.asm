void swapByte(valPtr1, valPtr2) {
  val1 = load(valPtr1)
  val2 = load(valPtr2)
  store(valPtr1, val2)
  store(valPtr2, val1)
}

0x000e5290 lbu v1,0x0000(a0)
0x000e5294 lbu v0,0x0000(a1)
0x000e5298 nop
0x000e529c sb v0,0x0000(a0)
0x000e52a0 jr ra
0x000e52a4 sb v1,0x0000(a1)