/**
 * Deallocates the array from the given address from the memory offset defined
 * at 0x134F64, by reading the head denominating the size of the array.
 */
void freeArray(int arrayPtr) {
  arraySize = load(arrayPtr - 4)
  offset = load(0x134F64)
  
  store(0x134F64, offset - (arraySize + 4)) 
}

0x000fc310 lw v1,-0x0004(a0)
0x000fc314 lw v0,-0x6bc8(gp)
0x000fc318 addiu v1,v1,0x0004
0x000fc31c subu v0,v0,v1
0x000fc320 jr ra
0x000fc324 sw v0,-0x6bc8(gp)