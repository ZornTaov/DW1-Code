void removeEffectSprites(entityPtr, combatPtr, effectType) {
  instanceId = load(combatPtr)
  
  if(instanceId == -1) // has status sprite
    return
    
  if(effectType == 3)
    removeStunSprite(instanceId, entityPtr)
  else if(effectType == 2)
    removeConfusionSprite(instanceId, entityPtr)
  else if(effectType == 1)
    removePoisonSprite(instanceId, entityPtr)
  
  store(combatPtr, -1)
}

0x0005e520 addiu sp,sp,0xffe8
0x0005e524 sw ra,0x0014(sp)
0x0005e528 sw s0,0x0010(sp)
0x0005e52c addu v0,a0,r0
0x0005e530 addu s0,a1,r0
0x0005e534 lw a0,0x0000(s0)
0x0005e538 addiu asmTemp,r0,0xffff
0x0005e53c beq a0,asmTemp,0x0005e598
0x0005e540 nop
0x0005e544 addiu asmTemp,r0,0x0003
0x0005e548 beq a2,asmTemp,0x0005e588
0x0005e54c nop
0x0005e550 addiu asmTemp,r0,0x0002
0x0005e554 beq a2,asmTemp,0x0005e578
0x0005e558 nop
0x0005e55c addiu asmTemp,r0,0x0001
0x0005e560 bne a2,asmTemp,0x0005e590
0x0005e564 nop
0x0005e568 jal 0x0006f168
0x0005e56c addu a1,v0,r0
0x0005e570 beq r0,r0,0x0005e594
0x0005e574 addiu v0,r0,0xffff
0x0005e578 jal 0x0006f4dc
0x0005e57c addu a1,v0,r0
0x0005e580 beq r0,r0,0x0005e594
0x0005e584 addiu v0,r0,0xffff
0x0005e588 jal 0x0006fee0
0x0005e58c addu a1,v0,r0
0x0005e590 addiu v0,r0,0xffff
0x0005e594 sw v0,0x0000(s0)
0x0005e598 lw ra,0x0014(sp)
0x0005e59c lw s0,0x0010(sp)
0x0005e5a0 jr ra
0x0005e5a4 addiu sp,sp,0x0018