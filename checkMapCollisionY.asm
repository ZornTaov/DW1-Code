/**
 * Checks if an entity is in an unpassable map tile by iterating over a line
 * of tiles it occupies on the Y axis. The variable useXMin determines whether 
 * it will take the upper or lower end of the X coordinate to check.
 *
 * This function return 1 when the entity occupies at least one unpassable tile,
 * 0 otherwise.
 */
int checkMapCollisionY(entityPtr, val) {
  positionPtr = load(entityPtr + 0x04) + 0x78
  diameter = load(0x12CECC + load(entityPtr + 0x00) * 52)
  radius = diameter / 2
  
  posX = load(positionPtr)
  posY = load(positionPtr + 0x08)
  
  if(val == 0)
    posX = posX - diameter
  else
    posX = posX + diameter
  
  yMax = posY + radius
  yMin = posY - radius
  yMaxTile = 49 - yMax / 100
  yMinTile = 49 - yMin / 100
  
  if(yMax < 0)
    yMaxTile++
  if(yMin < 0)
    yMinTile++
  
  tileX = posX / 100 + 50
  
  if(posX < 0)
    tileX--
  
  tileOffset = yMaxTile * 100
  
  while(yMinTile >= yMaxTile) {
    if(load(0x1AF398 + tileOffset + tileX) & 0x80 != 0)
      return 1
    
    yMaxTile++
    tileOffset += 100
  }
  
  return 0
}

0x000c0d74 lw v0,0x0004(a0)
0x000c0d78 lw a0,0x0000(a0)
0x000c0d7c nop
0x000c0d80 sll v1,a0,0x01
0x000c0d84 add v1,v1,a0
0x000c0d88 sll v1,v1,0x02
0x000c0d8c add v1,v1,a0
0x000c0d90 sll a0,v1,0x02
0x000c0d94 lui v1,0x8013
0x000c0d98 addiu v1,v1,0xcecc
0x000c0d9c addu v1,v1,a0
0x000c0da0 lh v1,0x0000(v1)
0x000c0da4 bne a1,r0,0x000c0dc4
0x000c0da8 addiu v0,v0,0x0078
0x000c0dac lw a0,0x0000(v0)
0x000c0db0 nop
0x000c0db4 sub a0,a0,v1
0x000c0db8 sll a2,a0,0x10
0x000c0dbc beq r0,r0,0x000c0dd8
0x000c0dc0 sra a2,a2,0x10
0x000c0dc4 lw a0,0x0000(v0)
0x000c0dc8 nop
0x000c0dcc add a0,a0,v1
0x000c0dd0 sll a2,a0,0x10
0x000c0dd4 sra a2,a2,0x10
0x000c0dd8 lui a0,0x51eb
0x000c0ddc ori a0,a0,0x851f
0x000c0de0 mult a0,a2
0x000c0de4 srl a1,a2,0x1f
0x000c0de8 mfhi a0
0x000c0dec sra a0,a0,0x05
0x000c0df0 addu a0,a0,a1
0x000c0df4 addi a0,a0,0x0032
0x000c0df8 sll a0,a0,0x10
0x000c0dfc bgez a2,0x000c0e10
0x000c0e00 sra a0,a0,0x10
0x000c0e04 addi a0,a0,-0x0001
0x000c0e08 sll a0,a0,0x10
0x000c0e0c sra a0,a0,0x10
0x000c0e10 bgez v1,0x000c0e20
0x000c0e14 sra t9,v1,0x01
0x000c0e18 addiu v1,v1,0x0001
0x000c0e1c sra t9,v1,0x01
0x000c0e20 lw v0,0x0008(v0)
0x000c0e24 addu a1,t9,r0
0x000c0e28 addu a2,v0,r0
0x000c0e2c add v0,v0,t9
0x000c0e30 sll a3,v0,0x10
0x000c0e34 lui v0,0x51eb
0x000c0e38 sra a3,a3,0x10
0x000c0e3c ori v0,v0,0x851f
0x000c0e40 mult v0,a3
0x000c0e44 srl v1,a3,0x1f
0x000c0e48 mfhi v0
0x000c0e4c sra v0,v0,0x05
0x000c0e50 addu v1,v0,v1
0x000c0e54 addiu v0,r0,0x0031
0x000c0e58 sub v0,v0,v1
0x000c0e5c sll v0,v0,0x10
0x000c0e60 bgez a3,0x000c0e74
0x000c0e64 sra v0,v0,0x10
0x000c0e68 addi v0,v0,0x0001
0x000c0e6c sll v0,v0,0x10
0x000c0e70 sra v0,v0,0x10
0x000c0e74 sub v1,a2,a1
0x000c0e78 sll a3,v1,0x10
0x000c0e7c lui v1,0x51eb
0x000c0e80 sra a3,a3,0x10
0x000c0e84 ori v1,v1,0x851f
0x000c0e88 mult v1,a3
0x000c0e8c srl a1,a3,0x1f
0x000c0e90 mfhi v1
0x000c0e94 sra v1,v1,0x05
0x000c0e98 addu a1,v1,a1
0x000c0e9c addiu v1,r0,0x0031
0x000c0ea0 sub v1,v1,a1
0x000c0ea4 sll a2,v1,0x10
0x000c0ea8 bgez a3,0x000c0ebc
0x000c0eac sra a2,a2,0x10
0x000c0eb0 addi v1,a2,0x0001
0x000c0eb4 sll a2,v1,0x10
0x000c0eb8 sra a2,a2,0x10
0x000c0ebc sll v1,v0,0x02
0x000c0ec0 add a1,v1,v0
0x000c0ec4 sll v1,a1,0x02
0x000c0ec8 add v1,a1,v1
0x000c0ecc beq r0,r0,0x000c0f10
0x000c0ed0 sll a3,v1,0x02
0x000c0ed4 lui v1,0x801b
0x000c0ed8 add a1,a0,a3
0x000c0edc addiu v1,v1,0xf398
0x000c0ee0 addu v1,v1,a1
0x000c0ee4 lbu v1,0x0000(v1)
0x000c0ee8 nop
0x000c0eec andi v1,v1,0x0080
0x000c0ef0 beq v1,r0,0x000c0f00
0x000c0ef4 nop
0x000c0ef8 beq r0,r0,0x000c0f20
0x000c0efc addiu v0,r0,0x0001
0x000c0f00 addi v0,v0,0x0001
0x000c0f04 sll v0,v0,0x10
0x000c0f08 sra v0,v0,0x10
0x000c0f0c addi a3,a3,0x0064
0x000c0f10 slt asmTemp,a2,v0
0x000c0f14 beq asmTemp,r0,0x000c0ed4
0x000c0f18 nop
0x000c0f1c addu v0,r0,r0
0x000c0f20 jr ra
0x000c0f24 nop