int getTechFromMove(int mapDataOffset, int move) {

  if(move == 0xFF)
    return 0xFF
    
  digimonType = load(mapDataOffset)
  
  if(digimonType == 0x3C && move == 0x3C) // if H-Kabuterimon 
    return 0x70 // H-Kabuterimon's finisher
      
  digimonDataOffset = 0x12ced7 + digimonType * 52
  moveId = move - 0x2E
  
  return load(digimonDataOffset + moveId)
}

// original code
0x000e6000 addiu asmTemp,r0,0x00ff
0x000e6004 bne a1,asmTemp,0x000e6014
0x000e6008 nop
0x000e600c beq r0,r0,0x000e6070
0x000e6010 addiu v0,r0,0x00ff
0x000e6014 lw v0,0x0000(a0)
0x000e6018 addiu asmTemp,r0,0x003c
0x000e601c bne v0,asmTemp,0x000e6038
0x000e6020 nop
0x000e6024 addiu asmTemp,r0,0x003c
0x000e6028 bne a1,asmTemp,0x000e6038
0x000e602c nop
0x000e6030 beq r0,r0,0x000e6070
0x000e6034 addiu v0,r0,0x0070
0x000e6038 lw v1,0x0000(a0)
0x000e603c nop
0x000e6040 sll v0,v1,0x01
0x000e6044 add v0,v0,v1
0x000e6048 sll v0,v0,0x02
0x000e604c add v0,v0,v1
0x000e6050 sll v1,v0,0x02
0x000e6054 lui v0,0x8013
0x000e6058 addiu v0,v0,0xced7
0x000e605c addu v1,v0,v1
0x000e6060 addi v0,a1,-0x002e
0x000e6064 addu v0,v0,v1
0x000e6068 lbu v0,0x0000(v0)
0x000e606c nop
0x000e6070 jr ra


0x588D8 // tick
goalCharge + 1

0x5ABEC // successful attack
goalCharge * 0.04

0x5CDC8 // blocked, defender
goalCharge * 0.06

0x5CE58 // blocked, attacker
goalCharge * 0.08