void handleMPHealingItem(int itemId) {
  if(load(0x1557F4) == 0) // check current HP
    return

  itemOffset = itemId - 4
  healingAmount = load(0x13435C + itemOffset * 2)
  maxMP = load(0x1557F2) 

  healValue(0x1557F6, healingAmount, maxMP)

  if(load(0x134F0A) == 1) { // check combat state?  
    store(stack + 0x10, 2)
    amount = load(0x13435C + itemOffset * 2)
    entityPtr = load(0x12F348) // Digimon entity data
    unknownValue = 0
    textColor = 11
    
    // entityDataPtr, 0?, color, text
    0x000DF868(entityPtr, unknownValue, textColor, amount) // display heal amount text
  }

  particleType = load(0x134364 + itemOffset)
  entityPtr = load(0x12F348)

  // entityDataPtr, particleType
  0x000C1560(entityPtr, particleType) // play particle effects
}

0x000c4a08 addiu sp,sp,0xffd8
0x000c4a0c sw ra,0x0020(sp)
0x000c4a10 lui asmTemp,0x8015
0x000c4a14 sw s1,0x001c(sp)
0x000c4a18 lh v0,0x57f4(asmTemp)
0x000c4a1c nop
0x000c4a20 beq v0,r0,0x000c4aac
0x000c4a24 sw s0,0x0018(sp)
0x000c4a28 addi v0,a0,-0x0004
0x000c4a2c sll v1,v0,0x01
0x000c4a30 addu s1,v0,r0
0x000c4a34 addiu v0,gp,0x8830
0x000c4a38 addu v0,v0,v1
0x000c4a3c lui asmTemp,0x8015
0x000c4a40 lui a0,0x8015
0x000c4a44 lh a1,0x0000(v0)
0x000c4a48 lh a2,0x57f2(asmTemp)
0x000c4a4c addu s0,v1,r0
0x000c4a50 jal 0x000c563c
0x000c4a54 addiu a0,a0,0x57f6
0x000c4a58 lb v0,-0x6c22(gp)
0x000c4a5c addiu asmTemp,r0,0x0001
0x000c4a60 bne v0,asmTemp,0x000c4a90
0x000c4a64 nop
0x000c4a68 addiu v0,r0,0x0002
0x000c4a6c sw v0,0x0010(sp)
0x000c4a70 addiu v0,gp,0x8830
0x000c4a74 addu v0,v0,s0
0x000c4a78 lui asmTemp,0x8013
0x000c4a7c lh a3,0x0000(v0)
0x000c4a80 lw a0,-0x0cb8(asmTemp)
0x000c4a84 addu a1,r0,r0
0x000c4a88 jal 0x000df868
0x000c4a8c addiu a2,r0,0x000b
0x000c4a90 addiu v0,gp,0x8838
0x000c4a94 addu v0,v0,s1
0x000c4a98 lui asmTemp,0x8013
0x000c4a9c lbu a1,0x0000(v0)
0x000c4aa0 lw a0,-0x0cb8(asmTemp)
0x000c4aa4 jal 0x000c1560
0x000c4aa8 nop
0x000c4aac lw ra,0x0020(sp)
0x000c4ab0 lw s1,0x001c(sp)
0x000c4ab4 lw s0,0x0018(sp)
0x000c4ab8 jr ra
0x000c4abc addiu sp,sp,0x0028