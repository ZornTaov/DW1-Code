void removePoisonSprite(instanceId, entityPtr) {
  poisonTablePtr = 0x000750D0 + instanceId * 8
  
  if(instanceId < 0 || instanceId >= 4)
    return
    
  if(load(poisonTablePtr + 0x0004) != entityPtr)
    return
    
  store(poisonTablePtr, -1)
  unsetObject(0x0808, instanceId)
}

0x0006f168 addu a2,a0,r0
0x0006f16c lui v0,0x8007
0x0006f170 addiu sp,sp,0xffe8
0x0006f174 sll v1,a2,0x03
0x0006f178 addiu v0,v0,0x50d0
0x0006f17c sw ra,0x0010(sp)
0x0006f180 bltz a2,0x0006f1b8
0x0006f184 addu v1,v0,v1
0x0006f188 slti asmTemp,a2,0x0004
0x0006f18c beq asmTemp,r0,0x0006f1b8
0x0006f190 nop
0x0006f194 lw v0,0x0004(v1)
0x0006f198 nop
0x0006f19c bne v0,a1,0x0006f1b8
0x0006f1a0 nop
0x0006f1a4 addiu v0,r0,0xffff
0x0006f1a8 sh v0,0x0000(v1)
0x0006f1ac addiu a0,r0,0x0808
0x0006f1b0 jal 0x000a3008
0x0006f1b4 addu a1,a2,r0
0x0006f1b8 lw ra,0x0010(sp)
0x0006f1bc nop
0x0006f1c0 jr ra
0x0006f1c4 addiu sp,sp,0x0018