void handleHPHealingItem(int itemId) {
  if(load(0x1557F4) == 0) // check current HP
    return

  healingAmount = load(0x13435C + itemId * 2)
  maxHP = load(0x1557F0) 

  healValue(0x1557F4, healingAmount, maxHP)

  if(load(0x134F0A) == 1) { // check combat state?  
    store(stack + 0x10, 1)
    amount = load(0x13435C + itemId * 2)
    entityPtr = load(0x12F348) // Digimon entity data
    unknownValue = 0
    textColor = 11
    
    // entityDataPtr, 0?, color, text
    0x000DF868(entityPtr, unknownValue, textColor, amount) // display heal amount text
  }

  particleType = load(0x134364 + itemId)
  entityPtr = load(0x12F348)

  // entityDataPtr, particleType
  0x000C1560(entityPtr, particleType) // play particle effects
}

0x000c4ac0 addiu sp,sp,0xffd8
0x000c4ac4 sw ra,0x0020(sp)
0x000c4ac8 lui asmTemp,0x8015
0x000c4acc sw s1,0x001c(sp)
0x000c4ad0 lh v0,0x57f4(asmTemp)
0x000c4ad4 nop
0x000c4ad8 beq v0,r0,0x000c4b60
0x000c4adc sw s0,0x0018(sp)
0x000c4ae0 sll v1,a0,0x01
0x000c4ae4 addiu v0,gp,0x8830
0x000c4ae8 addu s1,a0,r0
0x000c4aec addu v0,v0,v1
0x000c4af0 lui asmTemp,0x8015
0x000c4af4 lui a0,0x8015
0x000c4af8 lh a1,0x0000(v0)
0x000c4afc lh a2,0x57f0(asmTemp)
0x000c4b00 addu s0,v1,r0
0x000c4b04 jal 0x000c563c
0x000c4b08 addiu a0,a0,0x57f4
0x000c4b0c lb v0,-0x6c22(gp)
0x000c4b10 addiu asmTemp,r0,0x0001
0x000c4b14 bne v0,asmTemp,0x000c4b44
0x000c4b18 nop
0x000c4b1c addiu v0,r0,0x0001
0x000c4b20 sw v0,0x0010(sp)
0x000c4b24 addiu v0,gp,0x8830
0x000c4b28 addu v0,v0,s0
0x000c4b2c lui asmTemp,0x8013
0x000c4b30 lh a3,0x0000(v0)
0x000c4b34 lw a0,-0x0cb8(asmTemp)
0x000c4b38 addu a1,r0,r0
0x000c4b3c jal 0x000df868
0x000c4b40 addiu a2,r0,0x000b
0x000c4b44 addiu v0,gp,0x8838
0x000c4b48 addu v0,v0,s1
0x000c4b4c lui asmTemp,0x8013
0x000c4b50 lbu a1,0x0000(v0)
0x000c4b54 lw a0,-0x0cb8(asmTemp)
0x000c4b58 jal 0x000c1560
0x000c4b5c nop
0x000c4b60 lw ra,0x0020(sp)
0x000c4b64 lw s1,0x001c(sp)
0x000c4b68 lw s0,0x0018(sp)
0x000c4b6c jr ra
0x000c4b70 addiu sp,sp,0x0028