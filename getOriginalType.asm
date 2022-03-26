int getOriginalType(digimonType) {
  if(digimonType < 0 || digimonType >= 0xB1)
    return -1
  
  originalType = load(0x12A84C + a0 * 2)
  
  return originalType >= 0 ? originalType : digimonType
}

0x000d9a3c bltz a0,0x000d9a50
0x000d9a40 nop
0x000d9a44 slti asmTemp,a0,0x00b1
0x000d9a48 bne asmTemp,r0,0x000d9a58
0x000d9a4c nop
0x000d9a50 beq r0,r0,0x000d9a80
0x000d9a54 addiu v0,r0,0xffff
0x000d9a58 lui v0,0x8013
0x000d9a5c sll v1,a0,0x01
0x000d9a60 addiu v0,v0,0xa84c
0x000d9a64 addu v0,v0,v1
0x000d9a68 lh v0,0x0000(v0)
0x000d9a6c nop
0x000d9a70 bgez v0,0x000d9a80
0x000d9a74 nop
0x000d9a78 beq r0,r0,0x000d9a80
0x000d9a7c addu v0,a0,r0
0x000d9a80 jr ra
0x000d9a84 nop