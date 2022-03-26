int getScriptSection(scriptPtr, id) {
  sectionPtr = scriptPtr + 2
  
  do {
    sectionId = load(sectionPtr)
  
    if(sectionId == id)
      return scriptPtr + load(sectionPtr + 0x02)
    
    sectionPtr += 4
  } while(sectionId != -1)
  
  return 0
}

0x0010629c addiu v1,a0,0x0002
0x001062a0 lhu v0,0x0000(v1)
0x001062a4 nop
0x001062a8 bne v0,a1,0x001062bc
0x001062ac addu a2,v0,r0
0x001062b0 lhu v0,0x0002(v1)
0x001062b4 beq r0,r0,0x001062d8
0x001062b8 addu v0,a0,v0
0x001062bc ori asmTemp,r0,0xffff
0x001062c0 bne a2,asmTemp,0x001062d0
0x001062c4 nop
0x001062c8 beq r0,r0,0x001062d8
0x001062cc addu v0,r0,r0
0x001062d0 beq r0,r0,0x001062a0
0x001062d4 addi v1,v1,0x0004
0x001062d8 jr ra
0x001062dc nop