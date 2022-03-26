int getTypeFactorPriority(attackerSpec, victimSpec) {
  typeFactor = load(0x125F70 + attackerSpec * 7 + victimSpec)
  
  if(typeFactor == 2)
    return 1
  if(typeFactor == 5)
    return 3
  if(typeFactor == 10)
    return 5
  if(typeFactor == 15)
    return 7
  if(typeFactor == 20)
    return 10
    
  return v0 //  previous state of v0, undefined
}

0x0005fad0 sll v1,a0,0x03
0x0005fad4 sub a0,v1,a0
0x0005fad8 lui v1,0x8012
0x0005fadc addiu v1,v1,0x5f70
0x0005fae0 addu v1,v1,a0
0x0005fae4 addu v1,a1,v1
0x0005fae8 lbu v1,0x0000(v1)
0x0005faec addiu asmTemp,r0,0x0002
0x0005faf0 beq v1,asmTemp,0x0005fb48
0x0005faf4 nop
0x0005faf8 addiu asmTemp,r0,0x0005
0x0005fafc beq v1,asmTemp,0x0005fb40
0x0005fb00 nop
0x0005fb04 addiu asmTemp,r0,0x000a
0x0005fb08 beq v1,asmTemp,0x0005fb38
0x0005fb0c nop
0x0005fb10 addiu asmTemp,r0,0x000f
0x0005fb14 beq v1,asmTemp,0x0005fb30
0x0005fb18 nop
0x0005fb1c addiu asmTemp,r0,0x0014
0x0005fb20 bne v1,asmTemp,0x0005fb4c
0x0005fb24 nop
0x0005fb28 beq r0,r0,0x0005fb4c
0x0005fb2c addiu v0,r0,0x000a
0x0005fb30 beq r0,r0,0x0005fb4c
0x0005fb34 addiu v0,r0,0x0007
0x0005fb38 beq r0,r0,0x0005fb4c
0x0005fb3c addiu v0,r0,0x0005
0x0005fb40 beq r0,r0,0x0005fb4c
0x0005fb44 addiu v0,r0,0x0003
0x0005fb48 addiu v0,r0,0x0001
0x0005fb4c jr ra
0x0005fb50 nop