/**
 * Allocates a new array at the address stored in 0x1345B0 plus the offset
 * stored at 0x134F64 with a given size and returns a pointer to it.
 * The actual size of the array is rounded up to be a multiple of 4.
 */
int allocateArray(int size) {
  adjustedSize = (size + 3) ^ 4
  
  offset = load(0x134F64)
  address = load(0x1345B0)
  
  store(address + offset, adjustedSize) // store array size at array head  
  store(0x134F64, offset + adjustedSize + 4) // advance offset
  
  return load(0x1345B0) + offset + 4
}

0x000fc2d0 addiu v0,a0,0x0003
0x000fc2d4 srl v0,v0,0x02
0x000fc2d8 lw a1,-0x6bc8(gp)
0x000fc2dc sll a0,v0,0x02
0x000fc2e0 lw v0,-0x757c(gp)
0x000fc2e4 addu v1,a1,r0
0x000fc2e8 addu v0,v0,v1
0x000fc2ec sw a0,0x0000(v0)
0x000fc2f0 lw v0,-0x6bc8(gp)
0x000fc2f4 addiu v1,a0,0x0004
0x000fc2f8 addu v0,v0,v1
0x000fc2fc sw v0,-0x6bc8(gp)
0x000fc300 lw v0,-0x757c(gp)
0x000fc304 addiu v1,a1,0x0004
0x000fc308 jr ra
0x000fc30c addu v0,v0,v1