void removeConfusionSprite(instanceId, entityPtr) {
  confusionTablePtr = 0x000750F0 + instanceId * 0x10
  
  if(instanceId < 0 || instanceId >= 4)
    return
  
  if(load(confusionTablePtr + 0x0C) != entityPtr)
    return
  
  store(confusionTablePtr, -1)
  unsetObject(0x0806, instanceId)
}

0x0006f4dc addu a2,a0,r0
0x0006f4e0 lui v0,0x8007
0x0006f4e4 addiu sp,sp,0xffe8
0x0006f4e8 sll v1,a2,0x04
0x0006f4ec addiu v0,v0,0x50f0
0x0006f4f0 sw ra,0x0010(sp)
0x0006f4f4 bltz a2,0x0006f52c
0x0006f4f8 addu v1,v0,v1
0x0006f4fc slti asmTemp,a2,0x0004
0x0006f500 beq asmTemp,r0,0x0006f52c
0x0006f504 nop
0x0006f508 lw v0,0x000c(v1)
0x0006f50c nop
0x0006f510 bne v0,a1,0x0006f52c
0x0006f514 nop
0x0006f518 addiu v0,r0,0xffff
0x0006f51c sh v0,0x0000(v1)
0x0006f520 addiu a0,r0,0x0806
0x0006f524 jal 0x000a3008
0x0006f528 addu a1,a2,r0
0x0006f52c lw ra,0x0010(sp)
0x0006f530 nop
0x0006f534 jr ra
0x0006f538 addiu sp,sp,0x0018