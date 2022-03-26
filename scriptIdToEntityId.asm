// Bug: While the code checks if an entity pointer is set, it doesn't care for it's value
//      and just assumes an entity pointer based on the entityId.
int scriptIdToEntityId(targetId) {
  if(targetId == 253) // player
    return 0
  
  if(targetId == 252) // partner
    return 1
  
  for(i = 0; i < 8; i++) {
    entityPtr = load(0x12F344 + (i + 2) * 4)
    scriptId = load(0x15588D + i * 0x68)
    
    if(entityPtr != 0 && targetId == scriptId)
      return i + 2
  }
  
  return -1
}

0x00102144 addiu asmTemp,r0,0x00fd
0x00102148 bne a0,asmTemp,0x00102158
0x0010214c nop
0x00102150 beq r0,r0,0x001021e0
0x00102154 addu v0,r0,r0
0x00102158 addiu asmTemp,r0,0x00fc
0x0010215c bne a0,asmTemp,0x0010216c
0x00102160 addu a1,r0,r0
0x00102164 beq r0,r0,0x001021e0
0x00102168 addiu v0,r0,0x0001
0x0010216c addiu a2,r0,0x0002
0x00102170 beq r0,r0,0x001021d0
0x00102174 addu a3,r0,r0
0x00102178 lui v0,0x8013
0x0010217c sll v1,a2,0x02
0x00102180 addiu v0,v0,0xf344
0x00102184 addu v0,v0,v1
0x00102188 lw v0,0x0000(v0)
0x0010218c nop
0x00102190 beq v0,r0,0x001021c0
0x00102194 nop
0x00102198 lui v0,0x8015
0x0010219c addiu v0,v0,0x588d
0x001021a0 addu v0,v0,a3
0x001021a4 lbu v0,0x0000(v0)
0x001021a8 nop
0x001021ac bne a0,v0,0x001021c0
0x001021b0 nop
0x001021b4 addi v0,a1,0x0002
0x001021b8 beq r0,r0,0x001021e0
0x001021bc andi v0,v0,0x00ff
0x001021c0 addiu v0,a1,0x0001
0x001021c4 andi a1,v0,0x00ff
0x001021c8 addi a3,a3,0x0068
0x001021cc addi a2,a2,0x0001
0x001021d0 sltiu asmTemp,a1,0x0008
0x001021d4 bne asmTemp,r0,0x00102178
0x001021d8 nop
0x001021dc addiu v0,r0,0x00ff
0x001021e0 jr ra
0x001021e4 nop