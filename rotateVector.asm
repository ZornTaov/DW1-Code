void rotateVector(rotMatrix, sourceVector, targetVector) {
  // upload rotation vector to GTE
  // vector
  x = vector[0]
  y = vector[1]
  x = vector[z]
  
  // rotate
  targetVector[0] = (rotMatrix[0][0] * x + rotMatrix[0][1] * y + rotMatrix[0][2] * z)
  targetVector[1] = (rotMatrix[1][0] * x + rotMatrix[1][1] * y + rotMatrix[1][2] * z)
  targetVector[2] = (rotMatrix[2][0] * x + rotMatrix[2][1] * y + rotMatrix[2][2] * z)
  
  return targetVector
}

0x0009b030 lw t0,0x0000(a0)
0x0009b034 lw t1,0x0004(a0)
0x0009b038 lw t2,0x0008(a0)
0x0009b03c lw t3,0x000c(a0)
0x0009b040 lw t4,0x0010(a0)
0x0009b044 ctc2 t0,gtecr00_r11r12
0x0009b048 ctc2 t1,gtecr01_r13r21
0x0009b04c ctc2 t2,gtecr02_r22r23
0x0009b050 ctc2 t3,gtecr03_r31r32
0x0009b054 ctc2 t4,gtecr04_r33
0x0009b058 lwc2 gtedr00_vxy0,0x0000(a1)
0x0009b05c lwc2 gtedr01_vz0,0x0004(a1)
0x0009b060 nop
0x0009b064 mvmva
0x0009b068 mfc2 t0,gtedr09_ir1
0x0009b06c mfc2 t1,gtedr10_ir2
0x0009b070 mfc2 t2,gtedr11_ir3
0x0009b074 sh t0,0x0000(a2)
0x0009b078 sh t1,0x0002(a2)
0x0009b07c sh t2,0x0004(a2)
0x0009b080 addu v0,a2,r0
0x0009b084 jr ra
0x0009b088 nop