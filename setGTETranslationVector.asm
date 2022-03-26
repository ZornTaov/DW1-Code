setGTETranslationVector(matrixPtr) {
  gte_cr05 = load(matrixPtr + 0x14)
  gte_cr06 = load(matrixPtr + 0x18)
  gte_cr07 = load(matrixPtr + 0x1C)
}

0x0009b290 lw t0,0x0014(a0)
0x0009b294 lw t1,0x0018(a0)
0x0009b298 lw t2,0x001c(a0)
0x0009b29c ctc2 t0,gtecr05_trx
0x0009b2a0 ctc2 t1,gtecr06_try
0x0009b2a4 ctc2 t2,gtecr07_trz
0x0009b2a8 jr ra
0x0009b2ac nop