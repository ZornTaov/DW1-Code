/**
 * Checks if an entity is in an unpassable map tile by iterating over a line
 * of tiles it occupies on the X axis. The variable useYMin determines whether 
 * it will take the upper or lower end of the Y coordinate to check.
 *
 * This function return 1 when the entity occupies at least one unpassable tile,
 * 0 otherwise.
 */
int checkMapCollisionX(entityPtr, useYMin) {
  positionPtr = load(entityPtr + 0x04) + 0x78
  diameter = load(0x12CECC + load(entityPtr) * 52)
  radius = diameter / 2
  
  posX = load(positionPtr)
  posY = load(positionPtr + 0x08)
  
  if(useYMin == 0)
    posY = posY + diameter
  else
    posY = posY - diameter
  
  xMin = posX - radius
  xMax = posX + radius
  xMinTile = xMin / 100 + 50
  xMaxTile = xMax / 100 + 50
  
  if(xMin < 0)
    xMinTile--
  if(xMax < 0)
    xMaxTile--
  
  yTile = 49 - posY / 100
  
  if(posY < 0)
    yTile = yTile + 1
  
  tileOffset = xMinTile + yTile * 100
  
  while(xMaxTile >= xMinTile) {
    if(load(0x1AF398 + tileOffset) & 0x80 != 0) // is non-passable
      return 1
    
    xMinTile++
    tileOffset++
  }
  
  return 0
}

0x000c0bbc lw v0,0x0004(a0)
0x000c0bc0 lw a0,0x0000(a0)
0x000c0bc4 addiu v0,v0,0x0078
0x000c0bc8 sll v1,a0,0x01
0x000c0bcc add v1,v1,a0
0x000c0bd0 sll v1,v1,0x02
0x000c0bd4 add v1,v1,a0
0x000c0bd8 sll a0,v1,0x02
0x000c0bdc lui v1,0x8013
0x000c0be0 addiu v1,v1,0xcecc
0x000c0be4 addu v1,v1,a0
0x000c0be8 lh v1,0x0000(v1)
0x000c0bec nop
0x000c0bf0 addu a2,v1,r0
0x000c0bf4 bgez v1,0x000c0c04
0x000c0bf8 sra t9,v1,0x01
0x000c0bfc addiu v1,v1,0x0001
0x000c0c00 sra t9,v1,0x01
0x000c0c04 lw v1,0x0000(v0)
0x000c0c08 addu a3,t9,r0
0x000c0c0c addu t1,v1,r0
0x000c0c10 sub v1,v1,t9
0x000c0c14 sll t0,v1,0x10
0x000c0c18 lui v1,0x51eb
0x000c0c1c sra t0,t0,0x10
0x000c0c20 ori v1,v1,0x851f
0x000c0c24 mult v1,t0
0x000c0c28 srl a0,t0,0x1f
0x000c0c2c mfhi v1
0x000c0c30 sra v1,v1,0x05
0x000c0c34 addu v1,v1,a0
0x000c0c38 addi v1,v1,0x0032
0x000c0c3c sll v1,v1,0x10
0x000c0c40 bgez t0,0x000c0c54
0x000c0c44 sra v1,v1,0x10
0x000c0c48 addi v1,v1,-0x0001
0x000c0c4c sll v1,v1,0x10
0x000c0c50 sra v1,v1,0x10
0x000c0c54 add a0,t1,a3
0x000c0c58 sll t0,a0,0x10
0x000c0c5c lui a0,0x51eb
0x000c0c60 sra t0,t0,0x10
0x000c0c64 ori a0,a0,0x851f
0x000c0c68 mult a0,t0
0x000c0c6c srl a3,t0,0x1f
0x000c0c70 mfhi a0
0x000c0c74 sra a0,a0,0x05
0x000c0c78 addu a0,a0,a3
0x000c0c7c addi a0,a0,0x0032
0x000c0c80 sll a0,a0,0x10
0x000c0c84 bgez t0,0x000c0c98
0x000c0c88 sra a0,a0,0x10
0x000c0c8c addi a0,a0,-0x0001
0x000c0c90 sll a0,a0,0x10
0x000c0c94 sra a0,a0,0x10
0x000c0c98 bne a1,r0,0x000c0cb8
0x000c0c9c nop
0x000c0ca0 lw v0,0x0008(v0)
0x000c0ca4 nop
0x000c0ca8 add v0,v0,a2
0x000c0cac sll a2,v0,0x10
0x000c0cb0 beq r0,r0,0x000c0ccc
0x000c0cb4 sra a2,a2,0x10
0x000c0cb8 lw v0,0x0008(v0)
0x000c0cbc nop
0x000c0cc0 sub v0,v0,a2
0x000c0cc4 sll a2,v0,0x10
0x000c0cc8 sra a2,a2,0x10
0x000c0ccc lui v0,0x51eb
0x000c0cd0 ori v0,v0,0x851f
0x000c0cd4 mult v0,a2
0x000c0cd8 srl a1,a2,0x1f
0x000c0cdc mfhi v0
0x000c0ce0 sra v0,v0,0x05
0x000c0ce4 addu a1,v0,a1
0x000c0ce8 addiu v0,r0,0x0031
0x000c0cec sub v0,v0,a1
0x000c0cf0 sll a1,v0,0x10
0x000c0cf4 bgez a2,0x000c0d08
0x000c0cf8 sra a1,a1,0x10
0x000c0cfc addi v0,a1,0x0001
0x000c0d00 sll a1,v0,0x10
0x000c0d04 sra a1,a1,0x10
0x000c0d08 sll v0,a1,0x02
0x000c0d0c add a1,v0,a1
0x000c0d10 sll v0,a1,0x02
0x000c0d14 add v0,a1,v0
0x000c0d18 sll v0,v0,0x02
0x000c0d1c beq r0,r0,0x000c0d5c
0x000c0d20 add a1,v1,v0
0x000c0d24 lui v0,0x801b
0x000c0d28 addiu v0,v0,0xf398
0x000c0d2c addu v0,v0,a1
0x000c0d30 lbu v0,0x0000(v0)
0x000c0d34 nop
0x000c0d38 andi v0,v0,0x0080
0x000c0d3c beq v0,r0,0x000c0d4c
0x000c0d40 nop
0x000c0d44 beq r0,r0,0x000c0d6c
0x000c0d48 addiu v0,r0,0x0001
0x000c0d4c addi v0,v1,0x0001
0x000c0d50 sll v1,v0,0x10
0x000c0d54 sra v1,v1,0x10
0x000c0d58 addi a1,a1,0x0001
0x000c0d5c slt asmTemp,a0,v1
0x000c0d60 beq asmTemp,r0,0x000c0d24
0x000c0d64 nop
0x000c0d68 addu v0,r0,r0
0x000c0d6c jr ra
0x000c0d70 nop