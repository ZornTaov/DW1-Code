/**
 * Returns two values representing a tile position of the given model.
 * The values get stored in the given addresess in a1 and a2, 
 * typically the stack but not necessarily.
 */
int, int getModelTile(int modelPtr) {
  posX = load(modelPtr)
  tileX = posX * 0.01 + 50

  if(posX < 0)
    tileX--

  posY = load(modelPtr + 8)
  tileY = posY * 0.01 + 50

  if(posY < 0)
    tileY--

  return tileX, tileY
}

0x000c0f28 lui v0,0x51eb
0x000c0f2c lw v1,0x0000(a0)
0x000c0f30 ori a3,v0,0x851f
0x000c0f34 mult a3,v1
0x000c0f38 mfhi v0
0x000c0f3c srl v1,v1,0x1f
0x000c0f40 sra v0,v0,0x05
0x000c0f44 addu v0,v0,v1
0x000c0f48 addi v0,v0,0x0032
0x000c0f4c sh v0,0x0000(a1)
0x000c0f50 lw v0,0x0008(a0)
0x000c0f54 nop
0x000c0f58 mult a3,v0
0x000c0f5c srl v1,v0,0x1f
0x000c0f60 mfhi v0
0x000c0f64 sra v0,v0,0x05
0x000c0f68 addu v1,v0,v1
0x000c0f6c addiu v0,r0,0x0032
0x000c0f70 sub v0,v0,v1
0x000c0f74 sh v0,0x0000(a2)
0x000c0f78 lw v0,0x0000(a0)
0x000c0f7c nop
0x000c0f80 bgez v0,0x000c0f98
0x000c0f84 nop
0x000c0f88 lh v0,0x0000(a1)
0x000c0f8c nop
0x000c0f90 addi v0,v0,-0x0001
0x000c0f94 sh v0,0x0000(a1)
0x000c0f98 lw v0,0x0008(a0)
0x000c0f9c nop
0x000c0fa0 blez v0,0x000c0fb8
0x000c0fa4 nop
0x000c0fa8 lh v0,0x0000(a2)
0x000c0fac nop
0x000c0fb0 addi v0,v0,-0x0001
0x000c0fb4 sh v0,0x0000(a2)
0x000c0fb8 jr ra
0x000c0fbc nop
