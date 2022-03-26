/**
 * Scales a matrix by a given vector (x, y, z) which representing a scale matrix.
 * A pointer to the scaled matrix is returned.
 * All values in the matrix are fixed point numbers, where 4096 is 1.0.
 *
 * [ a b c ]   [ x 0 0 ]   [ a*x b*y c*z ]
 * [ d e f ] * [ 0 y 0 ] = [ d*x e*y f*z ]
 * [ g h i ]   [ 0 0 z ]   [ g*x h*y i*z ]
 *
 */
scaleMatrix(destPtr, scaleVector) {
  scaleX = load(scaleVector)
  scaleY = load(scaleVector + 0x04)
  scaleZ = load(scaleVector + 0x08)
  
  store(destPtr, load(destPtr + 0x00) * scaleX / 4096)
  store(destPtr, load(destPtr + 0x02) * scaleY / 4096)
  store(destPtr, load(destPtr + 0x04) * scaleZ / 4096)
  
  store(destPtr, load(destPtr + 0x06) * scaleX / 4096)
  store(destPtr, load(destPtr + 0x08) * scaleY / 4096)
  store(destPtr, load(destPtr + 0x0A) * scaleZ / 4096)
  
  store(destPtr, load(destPtr + 0x0C) * scaleX / 4096)
  store(destPtr, load(destPtr + 0x0E) * scaleY / 4096)
  store(destPtr, load(destPtr + 0x10) * scaleZ / 4096)
  
  return destPtr
}

0x0009b0c0 lw t3,0x0000(a1)
0x0009b0c4 lw t4,0x0004(a1)
0x0009b0c8 lw t5,0x0008(a1)
0x0009b0cc lw t0,0x0000(a0)
0x0009b0d0 nop
0x0009b0d4 andi t1,t0,0xffff
0x0009b0d8 sll t1,t1,0x10
0x0009b0dc sra t1,t1,0x10
0x0009b0e0 multu t1,t3
0x0009b0e4 mflo t1
0x0009b0e8 sra t1,t1,0x0c
0x0009b0ec andi t1,t1,0xffff
0x0009b0f0 sra t2,t0,0x10
0x0009b0f4 multu t2,t4
0x0009b0f8 mflo t2
0x0009b0fc sra t2,t2,0x0c
0x0009b100 sll t2,t2,0x10
0x0009b104 or t1,t1,t2
0x0009b108 sw t1,0x0000(a0)
0x0009b10c lw t0,0x0004(a0)
0x0009b110 nop
0x0009b114 andi t1,t0,0xffff
0x0009b118 sll t1,t1,0x10
0x0009b11c sra t1,t1,0x10
0x0009b120 multu t1,t5
0x0009b124 mflo t1
0x0009b128 sra t1,t1,0x0c
0x0009b12c andi t1,t1,0xffff
0x0009b130 sra t2,t0,0x10
0x0009b134 multu t2,t3
0x0009b138 mflo t2
0x0009b13c sra t2,t2,0x0c
0x0009b140 sll t2,t2,0x10
0x0009b144 or t1,t1,t2
0x0009b148 sw t1,0x0004(a0)
0x0009b14c lw t0,0x0008(a0)
0x0009b150 nop
0x0009b154 andi t1,t0,0xffff
0x0009b158 sll t1,t1,0x10
0x0009b15c sra t1,t1,0x10
0x0009b160 multu t1,t4
0x0009b164 mflo t1
0x0009b168 sra t1,t1,0x0c
0x0009b16c andi t1,t1,0xffff
0x0009b170 sra t2,t0,0x10
0x0009b174 multu t2,t5
0x0009b178 mflo t2
0x0009b17c sra t2,t2,0x0c
0x0009b180 sll t2,t2,0x10
0x0009b184 or t1,t1,t2
0x0009b188 sw t1,0x0008(a0)
0x0009b18c lw t0,0x000c(a0)
0x0009b190 nop
0x0009b194 andi t1,t0,0xffff
0x0009b198 sll t1,t1,0x10
0x0009b19c sra t1,t1,0x10
0x0009b1a0 multu t1,t3
0x0009b1a4 mflo t1
0x0009b1a8 sra t1,t1,0x0c
0x0009b1ac andi t1,t1,0xffff
0x0009b1b0 sra t2,t0,0x10
0x0009b1b4 multu t2,t4
0x0009b1b8 mflo t2
0x0009b1bc sra t2,t2,0x0c
0x0009b1c0 sll t2,t2,0x10
0x0009b1c4 or t1,t1,t2
0x0009b1c8 sw t1,0x000c(a0)
0x0009b1cc lw t0,0x0010(a0)
0x0009b1d0 nop
0x0009b1d4 andi t1,t0,0xffff
0x0009b1d8 sll t1,t1,0x10
0x0009b1dc sra t1,t1,0x10
0x0009b1e0 multu t1,t5
0x0009b1e4 mflo t1
0x0009b1e8 sra t1,t1,0x0c
0x0009b1ec sw t1,0x0010(a0)
0x0009b1f0 jr ra
0x0009b1f4 addu v0,a0,r0