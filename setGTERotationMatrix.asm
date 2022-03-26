void setGTERotationMatrix(matrixPtr) {
  gte_cr00 = load(matrixPtr + 0x00)
  gte_cr01 = load(matrixPtr + 0x04)
  gte_cr02 = load(matrixPtr + 0x08)
  gte_cr03 = load(matrixPtr + 0x0C)
  gte_cr04 = load(matrixPtr + 0x10)
}

0x0009b200 lw t0,0x0000(a0)
0x0009b204 lw t1,0x0004(a0)
0x0009b208 lw t2,0x0008(a0)
0x0009b20c lw t3,0x000c(a0)
0x0009b210 lw t4,0x0010(a0)
0x0009b214 ctc2 t0,gtecr00_r11r12
0x0009b218 ctc2 t1,gtecr01_r13r21
0x0009b21c ctc2 t2,gtecr02_r22r23
0x0009b220 ctc2 t3,gtecr03_r31r32
0x0009b224 ctc2 t4,gtecr04_r33
0x0009b228 jr ra
0x0009b22c nop