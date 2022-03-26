/**
 * Sets up the model matrix for a node.
 */
setupModelMatrix(nodePtr) {
  copy12toOffset20(nodePtr + 0x14, nodePtr + 0x78) // copy translation vector?
  rotVecToRotMatrix(nodePtr + 0x70, nodePtr + 0x14) // calculate rotation matrix
  scaleMatrix(nodePtr + 0x14, nodePtr + 0x60) // multiply rot matrix with scale
  
  store(nodePtr + 0x10, 0) // reset counter
}

0x000c19a4 addiu sp,sp,0xffe0
0x000c19a8 sw ra,0x001c(sp)
0x000c19ac sw s2,0x0018(sp)
0x000c19b0 sw s1,0x0014(sp)
0x000c19b4 sw s0,0x0010(sp)
0x000c19b8 addu s0,a0,r0
0x000c19bc addiu s2,s0,0x0010
0x000c19c0 addiu a0,s2,0x0004
0x000c19c4 addu s1,a0,r0
0x000c19c8 jal 0x0009b090
0x000c19cc addiu a1,s0,0x0078
0x000c19d0 addiu a0,s0,0x0070
0x000c19d4 jal 0x0009b804
0x000c19d8 addu a1,s1,r0
0x000c19dc addu a0,s1,r0
0x000c19e0 jal 0x0009b0c0
0x000c19e4 addiu a1,s0,0x0060
0x000c19e8 sw r0,0x0000(s2)
0x000c19ec lw ra,0x001c(sp)
0x000c19f0 lw s2,0x0018(sp)
0x000c19f4 lw s1,0x0014(sp)
0x000c19f8 lw s0,0x0010(sp)
0x000c19fc jr ra
0x000c1a00 addiu sp,sp,0x0020