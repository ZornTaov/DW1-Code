/**
 * Clears a sub-area of the frame buffer based on a given array.
 *
 * posX, posY = array[0] + 704, array[1] + 256
 * sizeX, sizeY = array[2] / 4, array[3]
 */
void clearTextSubArea(array) {
  array[0] = array[0] / 4 + 0x2C0
  array[1] = array[1] + 0x100
  array[2] = array[2] / 4
  
  clearImage(array, 0, 0, 0)
}

0x0010cbc4 lh v0,0x0000(a0)
0x0010cbc8 nop
0x0010cbcc bgez v0,0x0010cbdc
0x0010cbd0 sra t9,v0,0x02
0x0010cbd4 addiu v0,v0,0x0003
0x0010cbd8 sra t9,v0,0x02
0x0010cbdc addi v0,t9,0x02c0
0x0010cbe0 sh v0,0x0000(a0)
0x0010cbe4 lh v0,0x0002(a0)
0x0010cbe8 addu a1,r0,r0
0x0010cbec addi v0,v0,0x0100
0x0010cbf0 sh v0,0x0002(a0)
0x0010cbf4 lh v0,0x0004(a0)
0x0010cbf8 addu a2,r0,r0
0x0010cbfc sra v0,v0,0x02
0x0010cc00 sh v0,0x0004(a0)
0x0010cc04 j 0x00094818
0x0010cc08 addu a3,r0,r0