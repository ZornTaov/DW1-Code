/**
 * Checks map collision after movement, with with diffX and diffY.
 * Return 1 if there is collision, 0 if not.
 *
 * see checkMapCollisionX and checkMapCollisionY for the checking algorithm.
 */
int checkMapCollision(entityPtr, diffX, diffY) {
  if(diffY > 0 && checkMapCollisionX(entityPtr, 0) != 0)
    return 1
  
  if(diffY < 0 && checkMapCollisionX(entityPtr, 1) != 0)
    return 1
    
  if(diffX < 0 && checkMapCollisionY(entityPtr, 0) != 0)
    return 1
    
  if(diffX > 0 && checkMapCollisionY(entityPtr, 1) != 0)
    return 1
    
  return 0
}

0x000d5018 addiu sp,sp,0xffe0
0x000d501c sw ra,0x001c(sp)
0x000d5020 sw s2,0x0018(sp)
0x000d5024 sw s1,0x0014(sp)
0x000d5028 sw s0,0x0010(sp)
0x000d502c addu s0,a0,r0
0x000d5030 addu s1,a2,r0
0x000d5034 blez s1,0x000d5054
0x000d5038 addu s2,a1,r0
0x000d503c jal 0x000c0bbc
0x000d5040 addu a1,r0,r0
0x000d5044 beq v0,r0,0x000d5054
0x000d5048 nop
0x000d504c beq r0,r0,0x000d50c4
0x000d5050 addiu v0,r0,0x0001
0x000d5054 bgez s1,0x000d5078
0x000d5058 nop
0x000d505c addu a0,s0,r0
0x000d5060 jal 0x000c0bbc
0x000d5064 addiu a1,r0,0x0001
0x000d5068 beq v0,r0,0x000d5078
0x000d506c nop
0x000d5070 beq r0,r0,0x000d50c4
0x000d5074 addiu v0,r0,0x0001
0x000d5078 bgez s2,0x000d509c
0x000d507c nop
0x000d5080 addu a0,s0,r0
0x000d5084 jal 0x000c0d74
0x000d5088 addu a1,r0,r0
0x000d508c beq v0,r0,0x000d509c
0x000d5090 nop
0x000d5094 beq r0,r0,0x000d50c4
0x000d5098 addiu v0,r0,0x0001
0x000d509c blez s2,0x000d50c0
0x000d50a0 nop
0x000d50a4 addu a0,s0,r0
0x000d50a8 jal 0x000c0d74
0x000d50ac addiu a1,r0,0x0001
0x000d50b0 beq v0,r0,0x000d50c0
0x000d50b4 nop
0x000d50b8 beq r0,r0,0x000d50c4
0x000d50bc addiu v0,r0,0x0001
0x000d50c0 addu v0,r0,r0
0x000d50c4 lw ra,0x001c(sp)
0x000d50c8 lw s2,0x0018(sp)
0x000d50cc lw s1,0x0014(sp)
0x000d50d0 lw s0,0x0010(sp)
0x000d50d4 jr ra
0x000d50d8 addiu sp,sp,0x0020