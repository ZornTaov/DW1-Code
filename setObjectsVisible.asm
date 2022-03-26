/**
 * Sets the visible status of objects.
 * objId -> object to start setting the visibility of
 * numObjs -> number of objects to set the visibility of
 * visible -> the visible status to set
 */
setObjectsVisible(objId, numObjs, visible) {
  for(i = 0; i < numObjs; i++)
    store(0x14F361 + (objId + i) * 34, visible)
}

0x000b5984 beq r0,r0,0x000b59b0
0x000b5988 addu a3,r0,r0
0x000b598c add v1,a0,a3
0x000b5990 sll v0,v1,0x04
0x000b5994 add v0,v0,v1
0x000b5998 sll v1,v0,0x01
0x000b599c lui v0,0x8015
0x000b59a0 addiu v0,v0,0xf361
0x000b59a4 addu v0,v0,v1
0x000b59a8 sb a2,0x0000(v0)
0x000b59ac addi a3,a3,0x0001
0x000b59b0 slt asmTemp,a3,a1
0x000b59b4 bne asmTemp,r0,0x000b598c
0x000b59b8 nop
0x000b59bc jr ra
0x000b59c0 nop