void removeEffectSprites(int entityPtr, int combatPtr) {
  flags = load(combatPtr + 0x34)
  
  if(flags & 0x0004 != 0) // stun
    removeEffectSprite(entityPtr, combatPtr, 3)
  
  if(flags & 0x0002 != 0) // confusion
    removeEffectSprite(entityPtr, combatPtr, 2)
  
  if(flags & 0x0001 != 0) // poison
    removeEffectSprite(entityPtr, combatPtr, 1)
}

0x0005ec7c addiu sp,sp,0xffe0
0x0005ec80 sw ra,0x0018(sp)
0x0005ec84 sw s1,0x0014(sp)
0x0005ec88 sw s0,0x0010(sp)
0x0005ec8c addu s0,a1,r0
0x0005ec90 lhu v0,0x0034(s0)
0x0005ec94 nop
0x0005ec98 andi v0,v0,0x0004
0x0005ec9c beq v0,r0,0x0005ecac
0x0005eca0 addu s1,a0,r0
0x0005eca4 jal 0x0005e520
0x0005eca8 addiu a2,r0,0x0003
0x0005ecac lhu v0,0x0034(s0)
0x0005ecb0 nop
0x0005ecb4 andi v0,v0,0x0002
0x0005ecb8 beq v0,r0,0x0005ecd0
0x0005ecbc nop
0x0005ecc0 addu a0,s1,r0
0x0005ecc4 addu a1,s0,r0
0x0005ecc8 jal 0x0005e520
0x0005eccc addiu a2,r0,0x0002
0x0005ecd0 lhu v0,0x0034(s0)
0x0005ecd4 nop
0x0005ecd8 andi v0,v0,0x0001
0x0005ecdc beq v0,r0,0x0005ecf4
0x0005ece0 nop
0x0005ece4 addu a0,s1,r0
0x0005ece8 addu a1,s0,r0
0x0005ecec jal 0x0005e520
0x0005ecf0 addiu a2,r0,0x0001
0x0005ecf4 lw ra,0x0018(sp)
0x0005ecf8 lw s1,0x0014(sp)
0x0005ecfc lw s0,0x0010(sp)
0x0005ed00 jr ra
0x0005ed04 addiu sp,sp,0x0020