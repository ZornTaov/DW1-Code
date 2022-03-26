/**
 * Select random move from a given array.
 */
int selectRandomMove(arrayPtr) {
  numMoves = 0
  
  for(i = 0; i < 4; i++)
    if(arrayPtr[i] == 1)
      newArray[numMoves++] = i
  
  return newArray[random(numMoves)]
}

0x0005ef58 addiu sp,sp,0xffe0
0x0005ef5c sw ra,0x0010(sp)
0x0005ef60 addu a1,r0,r0
0x0005ef64 addu v1,r0,r0
0x0005ef68 beq r0,r0,0x0005efa0
0x0005ef6c addu a2,r0,r0
0x0005ef70 addu v0,a0,a2
0x0005ef74 lh v0,0x0000(v0)
0x0005ef78 addiu asmTemp,r0,0x0001
0x0005ef7c bne v0,asmTemp,0x0005ef98
0x0005ef80 nop
0x0005ef84 addu v0,a1,r0
0x0005ef88 addi a1,v0,0x0001
0x0005ef8c sll v0,v0,0x01
0x0005ef90 addu v0,sp,v0
0x0005ef94 sh v1,0x0018(v0)
0x0005ef98 addi v1,v1,0x0001
0x0005ef9c addi a2,a2,0x0002
0x0005efa0 slti asmTemp,v1,0x0004
0x0005efa4 bne asmTemp,r0,0x0005ef70
0x0005efa8 nop
0x0005efac jal 0x000a36d4
0x0005efb0 addu a0,a1,r0
0x0005efb4 sll v0,v0,0x01
0x0005efb8 addu v0,sp,v0
0x0005efbc lw ra,0x0010(sp)
0x0005efc0 lh v0,0x0018(v0)
0x0005efc4 jr ra
0x0005efc8 addiu sp,sp,0x0020