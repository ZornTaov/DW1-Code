/**
 * Returns two values representing a tile position of the given model.
 * The values get stored in the given addresess in a1 and a2, 
 * typically the stack but not necessarily.
 */
int, int getEntityTileFromModel(int entityPtr) {
  modelPtr = load(entityPtr + 4)
  return getModelTile(modelPtr + 0x78)
}

0x000d3aec addiu sp,sp,0xffd8
0x000d3af0 sw ra,0x0018(sp)
0x000d3af4 sw s1,0x0014(sp)
0x000d3af8 sw s0,0x0010(sp)
0x000d3afc lw v0,0x0004(a0)
0x000d3b00 addu s1,a1,r0
0x000d3b04 addu s0,a2,r0
0x000d3b08 addiu a0,v0,0x0078
0x000d3b0c addiu a1,sp,0x0024
0x000d3b10 jal 0x000c0f28
0x000d3b14 addiu a2,sp,0x0026
0x000d3b18 lh v0,0x0024(sp)
0x000d3b1c nop
0x000d3b20 sb v0,0x0000(s1)
0x000d3b24 lh v0,0x0026(sp)
0x000d3b28 nop
0x000d3b2c sb v0,0x0000(s0)
0x000d3b30 lw ra,0x0018(sp)
0x000d3b34 lw s1,0x0014(sp)
0x000d3b38 lw s0,0x0010(sp)
0x000d3b3c jr ra
0x000d3b40 addiu sp,sp,0x0028
