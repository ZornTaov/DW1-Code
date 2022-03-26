/**
 * Takes a rotation vector and transforms it into a rotation matrix to
 * which a pointer is returned.
 * All values in the matrix are fixed point numbers, where 4096 is 1.0.
 * The equivalent result would be the following matrix multiplication:
 * 
 * [ 1      0       0  ]   [  cos(y)  0  sin(y) ]   [ cos(z) -sin(z)  0 ]
 * [ 0  cos(x) -sin(x) ] * [      0   1      0  ] * [ sin(z)  cos(z)  0 ]
 * [ 0  sin(x)  cos(x) ]   [ -sin(y)  0  cos(y) ]   [     0       0   1 ]
 *
 * All abs() calls are not actual syscalls in the game but equivalent local code.
 */
int rotVecToRotMatrix(rotVectorPtr, destPtr) {
  // get cos and sin for each axis
  rotX = load(rotVectorPtr)
  lookupResult = load(0x117960 + abs(rotX) * 4) // sin/cos lookup table
  sinX = rotX < 0 ? -lookupResult : lookupResult // cast to short
  cosX = lookupResult >> 0x10
  
  rotY = load(rotVectorPtr + 0x02)
  lookupResult = load(0x117960 + abs(rotY) * 4)  // sin/cos lookup table
  sinY = rotY < 0 ? -lookupResult : lookupResult // cast to short
  cosY = lookupResult >> 0x10
  
  rotZ = load(rotVectorPtr + 0x04)
  lookupResult = load(0x117960 + abs(rotZ) * 4)  // sin/cos lookup table
  sinZ = rotZ < 0 ? -lookupResult : lookupResult // cast to short
  cosZ = lookupResult >> 0x10
  
  // matrix calculations
  store(destPtr, cosZ * cosY / 4096)
  store(destPtr + 0x02, -(sinZ * cosY) / 4096)
  store(destPtr + 0x04, sinY)
  
  val1 = (cosZ * sinY * sinX) / 4096 / 4096
  val2 = (sinZ * cosX) / 4096
  store(destPtr + 0x06, val2 + val1)
  
  val1 = (sinZ * -sinY * sinX) / 4096 / 4096
  val2 = (cosZ * cosX) / 4096
  store(destPtr + 0x08, val2 + val1)
  store(destPtr + 0x0A, -(cosY * -sinX) / 4096)
  
  val1 = (cosZ * -sinY * cosX) / 4096 / 4096
  val2 = (sinZ * sinX) / 4096
  store(destPtr + 0x0C, val2 + val1)
  
  val1 = (sinZ * sinY * cosX) / 4096 / 4096
  val2 = (cosZ * sinX) / 4096
  store(destPtr + 0x0E, val2 + val1)
  store(destPtr + 0x10, cosY * cosX >> 0xC)
  
  return destPtr
}

0x0009b804 lh t7,0x0000(a0)
0x0009b808 addu v0,a1,r0
0x0009b80c bgez t7,0x0009b848
0x0009b810 andi t9,t7,0x0fff
0x0009b814 subu t7,r0,t7
0x0009b818 bgez t7,0x0009b820
0x0009b81c andi t7,t7,0x0fff
0x0009b820 sll t8,t7,0x02
0x0009b824 lui t9,0x8011
0x0009b828 addu t9,t9,t8
0x0009b82c lw t9,0x7960(t9)
0x0009b830 nop
0x0009b834 sll t8,t9,0x10
0x0009b838 sra t8,t8,0x10
0x0009b83c subu t3,r0,t8
0x0009b840 j 0x0009b868
0x0009b844 sra t0,t9,0x10
0x0009b848 sll t8,t9,0x02
0x0009b84c lui t9,0x8011
0x0009b850 addu t9,t9,t8
0x0009b854 lw t9,0x7960(t9)
0x0009b858 nop
0x0009b85c sll t8,t9,0x10
0x0009b860 sra t3,t8,0x10
0x0009b864 sra t0,t9,0x10
0x0009b868 lh t7,0x0002(a0)
0x0009b86c nop
0x0009b870 bgez t7,0x0009b8ac
0x0009b874 andi t9,t7,0x0fff
0x0009b878 subu t7,r0,t7
0x0009b87c bgez t7,0x0009b884
0x0009b880 andi t7,t7,0x0fff
0x0009b884 sll t8,t7,0x02
0x0009b888 lui t9,0x8011
0x0009b88c addu t9,t9,t8
0x0009b890 lw t9,0x7960(t9)
0x0009b894 nop
0x0009b898 sll t4,t9,0x10
0x0009b89c sra t4,t4,0x10
0x0009b8a0 subu t6,r0,t4
0x0009b8a4 j 0x0009b8d0
0x0009b8a8 sra t1,t9,0x10
0x0009b8ac sll t8,t9,0x02
0x0009b8b0 lui t9,0x8011
0x0009b8b4 addu t9,t9,t8
0x0009b8b8 lw t9,0x7960(t9)
0x0009b8bc nop
0x0009b8c0 sll t6,t9,0x10
0x0009b8c4 sra t6,t6,0x10
0x0009b8c8 subu t4,r0,t6
0x0009b8cc sra t1,t9,0x10
0x0009b8d0 multu t1,t3
0x0009b8d4 lh t7,0x0004(a0)
0x0009b8d8 sh t6,0x0004(a1)
0x0009b8dc mflo t8
0x0009b8e0 subu t9,r0,t8
0x0009b8e4 sra t6,t9,0x0c
0x0009b8e8 multu t1,t0
0x0009b8ec sh t6,0x000a(a1)
0x0009b8f0 bgez t7,0x0009b938
0x0009b8f4 andi t9,t7,0x0fff
0x0009b8f8 mflo t8
0x0009b8fc sra t6,t8,0x0c
0x0009b900 sh t6,0x0010(a1)
0x0009b904 subu t7,r0,t7
0x0009b908 bgez t7,0x0009b910
0x0009b90c andi t7,t7,0x0fff
0x0009b910 sll t8,t7,0x02
0x0009b914 lui t9,0x8011
0x0009b918 addu t9,t9,t8
0x0009b91c lw t9,0x7960(t9)
0x0009b920 nop
0x0009b924 sll t8,t9,0x10
0x0009b928 sra t8,t8,0x10
0x0009b92c subu t5,r0,t8
0x0009b930 j 0x0009b964
0x0009b934 sra t2,t9,0x10
0x0009b938 mflo t7
0x0009b93c sra t6,t7,0x0c
0x0009b940 sh t6,0x0010(a1)
0x0009b944 sll t8,t9,0x02
0x0009b948 lui t9,0x8011
0x0009b94c addu t9,t9,t8
0x0009b950 lw t9,0x7960(t9)
0x0009b954 nop
0x0009b958 sll t8,t9,0x10
0x0009b95c sra t5,t8,0x10
0x0009b960 sra t2,t9,0x10
0x0009b964 multu t2,t1
0x0009b968 nop
0x0009b96c nop
0x0009b970 mflo t7
0x0009b974 sra t6,t7,0x0c
0x0009b978 sh t6,0x0000(a1)
0x0009b97c multu t5,t1
0x0009b980 nop
0x0009b984 nop
0x0009b988 mflo t7
0x0009b98c subu t6,r0,t7
0x0009b990 sra t7,t6,0x0c
0x0009b994 multu t2,t4
0x0009b998 sh t7,0x0002(a1)
0x0009b99c nop
0x0009b9a0 mflo t7
0x0009b9a4 sra t8,t7,0x0c
0x0009b9a8 nop
0x0009b9ac multu t8,t3
0x0009b9b0 nop
0x0009b9b4 nop
0x0009b9b8 mflo t7
0x0009b9bc sra t6,t7,0x0c
0x0009b9c0 nop
0x0009b9c4 multu t5,t0
0x0009b9c8 nop
0x0009b9cc nop
0x0009b9d0 mflo t7
0x0009b9d4 sra t9,t7,0x0c
0x0009b9d8 subu t7,t9,t6
0x0009b9dc multu t8,t0
0x0009b9e0 sh t7,0x0006(a1)
0x0009b9e4 nop
0x0009b9e8 mflo t6
0x0009b9ec sra t7,t6,0x0c
0x0009b9f0 nop
0x0009b9f4 multu t5,t3
0x0009b9f8 nop
0x0009b9fc nop
0x0009ba00 mflo t6
0x0009ba04 sra t9,t6,0x0c
0x0009ba08 addu t6,t9,t7
0x0009ba0c multu t5,t4
0x0009ba10 sh t6,0x000c(a1)
0x0009ba14 nop
0x0009ba18 mflo t7
0x0009ba1c sra t8,t7,0x0c
0x0009ba20 nop
0x0009ba24 multu t8,t3
0x0009ba28 nop
0x0009ba2c nop
0x0009ba30 mflo t7
0x0009ba34 sra t6,t7,0x0c
0x0009ba38 nop
0x0009ba3c multu t2,t0
0x0009ba40 nop
0x0009ba44 nop
0x0009ba48 mflo t7
0x0009ba4c sra t9,t7,0x0c
0x0009ba50 addu t7,t9,t6
0x0009ba54 multu t8,t0
0x0009ba58 sh t7,0x0008(a1)
0x0009ba5c nop
0x0009ba60 mflo t6
0x0009ba64 sra t7,t6,0x0c
0x0009ba68 nop
0x0009ba6c multu t2,t3
0x0009ba70 nop
0x0009ba74 nop
0x0009ba78 mflo t6
0x0009ba7c sra t9,t6,0x0c
0x0009ba80 subu t6,t9,t7
0x0009ba84 sh t6,0x000e(a1)
0x0009ba88 jr ra
0x0009ba8c nop
