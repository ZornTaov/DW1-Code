/*
 * Rotate a given vector with a given rotation matrix and store the result into
 * a given pointer. This is using the Geometry Transform Engine (GTE).
 */
int rotateVectorByMatrix(rotMatrix, vector, resultPtr) {
  // upload rotation vector to GTE
  
  // upper 16 bit
  xTop = vector[0] / 0x8000
  yTop = vector[1] / 0x8000
  zTop = vector[2] / 0x8000
  
  // lower 16 bit
  xLow = vector[0] % 0x8000
  yLow = vector[1] % 0x8000
  zLow = vector[2] % 0x8000
  
  // rotate upper 16 bits, done on GTE
  xTop = (rotMatrix[0][0] * xTop + rotMatrix[0][1] * yTop + rotMatrix[0][2] * zTop)
  yTop = (rotMatrix[1][0] * xTop + rotMatrix[1][1] * yTop + rotMatrix[1][2] * zTop)
  zTop = (rotMatrix[2][0] * xTop + rotMatrix[2][1] * yTop + rotMatrix[2][2] * zTop)
  
  // rotate lower 16 bits, done on GTE
  xLow = (rotMatrix[0][0] * xLow + rotMatrix[0][1] * yLow + rotMatrix[0][2] * zLow) >> 12
  yLow = (rotMatrix[1][0] * xLow + rotMatrix[1][1] * yLow + rotMatrix[1][2] * zLow) >> 12
  zLow = (rotMatrix[2][0] * xLow + rotMatrix[2][1] * yLow + rotMatrix[2][2] * zLow) >> 12
  
  // assemble the result
  resultPtr[0] = xTop * 8 + xLow
  resultPtr[1] = yTop * 8 + yLow
  resultPtr[2] = zTop * 8 + zLow
  
  return resultPtr
}

0x0009ab10 lw t0,0x0000(a0)
0x0009ab14 lw t1,0x0004(a0)
0x0009ab18 lw t2,0x0008(a0)
0x0009ab1c lw t3,0x000c(a0)
0x0009ab20 lw t4,0x0010(a0)
0x0009ab24 ctc2 t0,gtecr00_r11r12
0x0009ab28 ctc2 t1,gtecr01_r13r21
0x0009ab2c ctc2 t2,gtecr02_r22r23
0x0009ab30 ctc2 t3,gtecr03_r31r32
0x0009ab34 ctc2 t4,gtecr04_r33
0x0009ab38 lw t0,0x0000(a1)
0x0009ab3c lw t1,0x0004(a1)
0x0009ab40 lw t2,0x0008(a1)
0x0009ab44 bgez t0,0x0009ab64
0x0009ab48 nop
0x0009ab4c subu t0,r0,t0
0x0009ab50 sra t3,t0,0x0f
0x0009ab54 subu t3,r0,t3
0x0009ab58 andi t0,t0,0x7fff
0x0009ab5c beq r0,r0,0x0009ab6c
0x0009ab60 subu t0,r0,t0
0x0009ab64 sra t3,t0,0x0f
0x0009ab68 andi t0,t0,0x7fff
0x0009ab6c bgez t1,0x0009ab8c
0x0009ab70 nop
0x0009ab74 subu t1,r0,t1
0x0009ab78 sra t4,t1,0x0f
0x0009ab7c subu t4,r0,t4
0x0009ab80 andi t1,t1,0x7fff
0x0009ab84 beq r0,r0,0x0009ab94
0x0009ab88 subu t1,r0,t1
0x0009ab8c sra t4,t1,0x0f
0x0009ab90 andi t1,t1,0x7fff
0x0009ab94 bgez t2,0x0009abb4
0x0009ab98 nop
0x0009ab9c subu t2,r0,t2
0x0009aba0 sra t5,t2,0x0f
0x0009aba4 subu t5,r0,t5
0x0009aba8 andi t2,t2,0x7fff
0x0009abac beq r0,r0,0x0009abbc
0x0009abb0 subu t2,r0,t2
0x0009abb4 sra t5,t2,0x0f
0x0009abb8 andi t2,t2,0x7fff
0x0009abbc mtc2 t3,gtedr09_ir1
0x0009abc0 mtc2 t4,gtedr10_ir2
0x0009abc4 mtc2 t5,gtedr11_ir3
0x0009abc8 nop
0x0009abcc mvmva
0x0009abd0 mfc2 t3,gtedr25_mac1
0x0009abd4 mfc2 t4,gtedr26_mac2
0x0009abd8 mfc2 t5,gtedr27_mac3
0x0009abdc mtc2 t0,gtedr09_ir1
0x0009abe0 mtc2 t1,gtedr10_ir2
0x0009abe4 mtc2 t2,gtedr11_ir3
0x0009abe8 nop
0x0009abec mvmva
0x0009abf0 bgez t3,0x0009ac08
0x0009abf4 nop
0x0009abf8 subu t3,r0,t3
0x0009abfc sll t3,t3,0x03
0x0009ac00 beq r0,r0,0x0009ac0c
0x0009ac04 subu t3,r0,t3
0x0009ac08 sll t3,t3,0x03
0x0009ac0c bgez t4,0x0009ac24
0x0009ac10 nop
0x0009ac14 subu t4,r0,t4
0x0009ac18 sll t4,t4,0x03
0x0009ac1c beq r0,r0,0x0009ac28
0x0009ac20 subu t4,r0,t4
0x0009ac24 sll t4,t4,0x03
0x0009ac28 bgez t5,0x0009ac40
0x0009ac2c nop
0x0009ac30 subu t5,r0,t5
0x0009ac34 sll t5,t5,0x03
0x0009ac38 beq r0,r0,0x0009ac44
0x0009ac3c subu t5,r0,t5
0x0009ac40 sll t5,t5,0x03
0x0009ac44 mfc2 t0,gtedr25_mac1
0x0009ac48 mfc2 t1,gtedr26_mac2
0x0009ac4c mfc2 t2,gtedr27_mac3
0x0009ac50 addu t0,t0,t3
0x0009ac54 addu t1,t1,t4
0x0009ac58 addu t2,t2,t5
0x0009ac5c sw t0,0x0000(a2)
0x0009ac60 sw t1,0x0004(a2)
0x0009ac64 sw t2,0x0008(a2)
0x0009ac68 jr ra
0x0009ac6c addu v0,a2,r0