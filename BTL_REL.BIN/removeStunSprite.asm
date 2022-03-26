void removeStunSprite(instanceId, entityPtr) {
  stunTablePtr = 0x00075130 + instanceId * 0x0C
  
  if(instanceId < 0 || instanceId >= 4)
    return
    
  if(load(stunTablePtr + 0x0008) != entityPtr)
    return
    
  store(stunTablePtr, -1)
  unsetObject(0x080F, instanceId)
}

0x0006fee0 addu a2,a0,r0
0x0006fee4 sll v0,a2,0x01
0x0006fee8 add v0,v0,a2
0x0006feec sll v1,v0,0x02
0x0006fef0 lui v0,0x8007
0x0006fef4 addiu sp,sp,0xffe8
0x0006fef8 addiu v0,v0,0x5130
0x0006fefc sw ra,0x0010(sp)
0x0006ff00 bltz a2,0x0006ff38
0x0006ff04 addu v1,v0,v1
0x0006ff08 slti asmTemp,a2,0x0005
0x0006ff0c beq asmTemp,r0,0x0006ff38
0x0006ff10 nop
0x0006ff14 lw v0,0x0008(v1)
0x0006ff18 nop
0x0006ff1c bne v0,a1,0x0006ff38
0x0006ff20 nop
0x0006ff24 addiu v0,r0,0xffff
0x0006ff28 sh v0,0x0000(v1)
0x0006ff2c addiu a0,r0,0x080f
0x0006ff30 jal 0x000a3008
0x0006ff34 addu a1,a2,r0
0x0006ff38 lw ra,0x0010(sp)
0x0006ff3c nop
0x0006ff40 jr ra
0x0006ff44 addiu sp,sp,0x0018