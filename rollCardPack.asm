/**
 * Rolls a random card. First it determines the rarity of the card and then
 * selects one from all cards with that rarity, with equal chance each.
 * Chances are 1%, 4%, 15%, 30% and 50% for each rarity respectively.
 */
int rollCardPack() {
  rarityRoll = random(100)

  if (rarityRoll == 0) 
    rarity = 0
  else if (rarityRoll < 5) 
    rarity = 1
  else if (rarityRoll < 20) 
    rarity = 2
  else if (rarityRoll < 50)
    rarity = 3
  else
    rarity = 4

  arrayPtr = allocateArray(66)
  cardsFound = 0

  for(s0 = 0; s0 < 66; s0++) {
    if(load(0x12FFD9 + s0 * 4) == rarity) {
      store(arrayPtr + cardsFound, s0)
      cardsFound++
    }
  }

  cardId = load(arrayPtr + random(cardsFound))
  freeArray(arrayPtr)

  return cardId
}

0x00106e0c addiu sp,sp,0xffe0
0x00106e10 sw ra,0x001c(sp)
0x00106e14 sw s2,0x0018(sp)
0x00106e18 sw s1,0x0014(sp)
0x00106e1c sw s0,0x0010(sp)
0x00106e20 jal 0x000a36d4
0x00106e24 addiu a0,r0,0x0064
0x00106e28 andi s1,v0,0x00ff
0x00106e2c bne s1,r0,0x00106e3c
0x00106e30 nop
0x00106e34 beq r0,r0,0x00106e78
0x00106e38 addu s1,r0,r0
0x00106e3c sltiu asmTemp,s1,0x0005
0x00106e40 beq asmTemp,r0,0x00106e50
0x00106e44 nop
0x00106e48 beq r0,r0,0x00106e78
0x00106e4c addiu s1,r0,0x0001
0x00106e50 sltiu asmTemp,s1,0x0014
0x00106e54 beq asmTemp,r0,0x00106e64
0x00106e58 nop
0x00106e5c beq r0,r0,0x00106e78
0x00106e60 addiu s1,r0,0x0002
0x00106e64 sltiu asmTemp,s1,0x0032
0x00106e68 beq asmTemp,r0,0x00106e78
0x00106e6c addiu s1,r0,0x0004
0x00106e70 beq r0,r0,0x00106e78
0x00106e74 addiu s1,r0,0x0003
0x00106e78 jal 0x000fc2d0
0x00106e7c addiu a0,r0,0x0042
0x00106e80 addu s2,v0,r0
0x00106e84 addu v1,s2,r0
0x00106e88 addu a0,r0,r0
0x00106e8c addu s0,r0,r0
0x00106e90 beq r0,r0,0x00106ed4
0x00106e94 addu a1,r0,r0
0x00106e98 lui v0,0x8013
0x00106e9c addiu v0,v0,0xffd9
0x00106ea0 addu v0,v0,a1
0x00106ea4 lbu v0,0x0000(v0)
0x00106ea8 nop
0x00106eac bne s1,v0,0x00106ec8
0x00106eb0 nop
0x00106eb4 addu v0,v1,r0
0x00106eb8 addiu v1,v0,0x0001
0x00106ebc sb s0,0x0000(v0)
0x00106ec0 addiu v0,a0,0x0001
0x00106ec4 andi a0,v0,0x00ff
0x00106ec8 addiu v0,s0,0x0001
0x00106ecc andi s0,v0,0x00ff
0x00106ed0 addi a1,a1,0x0004
0x00106ed4 sltiu asmTemp,s0,0x0042
0x00106ed8 bne asmTemp,r0,0x00106e98
0x00106edc nop
0x00106ee0 jal 0x000a36d4
0x00106ee4 nop
0x00106ee8 andi s1,v0,0x00ff
0x00106eec addu v0,s2,s1
0x00106ef0 lbu s0,0x0000(v0)
0x00106ef4 jal 0x000fc310
0x00106ef8 addu a0,s2,r0
0x00106efc addu v0,s0,r0
0x00106f00 lw ra,0x001c(sp)
0x00106f04 lw s2,0x0018(sp)
0x00106f08 lw s1,0x0014(sp)
0x00106f0c lw s0,0x0010(sp)
0x00106f10 jr ra