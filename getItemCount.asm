/**
 * Gets the amount of an item in the player's inventory
 */
int getItemCount(int itemId) {
  inventorySize = load(0x13D4CE)

  for(int i = 0; i < a1; i++) {
    foundItem = load(0x13D474 + i) // item ID in slot i
    
    if(foundItem == itemId)
      return load(0x13D492 + i) // item amount in slot i
  }

  return 0
}

0x000c51e0 lui asmTemp,0x8014
0x000c51e4 lbu a1,-0x2b32(asmTemp)
0x000c51e8 beq r0,r0,0x000c5228
0x000c51ec addu v1,r0,r0
0x000c51f0 lui v0,0x8014
0x000c51f4 addiu v0,v0,0xd474
0x000c51f8 addu v0,v0,v1
0x000c51fc lbu v0,0x0000(v0)
0x000c5200 nop
0x000c5204 bne v0,a0,0x000c5224
0x000c5208 nop
0x000c520c lui v0,0x8014
0x000c5210 addiu v0,v0,0xd492
0x000c5214 addu v0,v0,v1
0x000c5218 lbu v0,0x0000(v0)
0x000c521c beq r0,r0,0x000c5238
0x000c5220 nop
0x000c5224 addi v1,v1,0x0001
0x000c5228 slt asmTemp,v1,a1
0x000c522c bne asmTemp,r0,0x000c51f0
0x000c5230 nop
0x000c5234 addu v0,r0,r0
0x000c5238 jr ra
0x000c523c nop