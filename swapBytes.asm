/**
 * Swaps the two least significant bytes of a given value with each other.
 */
int swapBytes(val) {
  v1 = a0 >> 8
  v0 = a0 << 8
  return v0 | v1
}

0x000f1ab0 sra v1,a0,0x08
0x000f1ab4 sll v0,a0,0x08
0x000f1ab8 or v0,v1,v0
0x000f1abc jr ra
0x000f1ac0 andi v0,v0,0xffff