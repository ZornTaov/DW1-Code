int increaseSpeedBuffer(int combatData, int statsData) {
  int currentBuffer = load(combatData + 0x32);

  if(currentBuffer >= 100) // current speed buffer state
    return 100;
    
  if(load(0x134D66) % 2 == 0) {
    speed = load(statsData + 4)
    
    currentBuffer += speed / 100 + 1
    store(combatData + 0x32, currentBuffer)
  }
  
  if(currentBuffer > 100) 
    store(combatData + 0x32, 100)

  return load(combatData + 0x32)
}

0x0005af44 lh v0,0x0032(a0)
0x0005af48 nop
0x0005af4c slti asmTemp,v0,0x0064
0x0005af50 beq asmTemp,r0,0x0005afd0
0x0005af54 nop
0x0005af58 lh v1,-0x6dc6(gp)
0x0005af5c nop
0x0005af60 bgez v1,0x0005af74
0x0005af64 andi v0,v1,0x0001
0x0005af68 beq v0,r0,0x0005af74
0x0005af6c nop
0x0005af70 addiu v0,v0,0xfffe
0x0005af74 bne v0,r0,0x0005afb4
0x0005af78 nop
0x0005af7c lui v0,0x51eb
0x0005af80 lh v1,0x0004(a1)
0x0005af84 ori v0,v0,0x851f
0x0005af88 mult v0,v1
0x0005af8c mfhi v0
0x0005af90 srl v1,v1,0x1f
0x0005af94 sra v0,v0,0x05
0x0005af98 addu v0,v0,v1
0x0005af9c addi v1,v0,0x0001
0x0005afa0 sll v1,v1,0x10
0x0005afa4 lh v0,0x0032(a0)
0x0005afa8 sra v1,v1,0x10
0x0005afac add v0,v0,v1
0x0005afb0 sh v0,0x0032(a0)
0x0005afb4 lh v0,0x0032(a0)
0x0005afb8 nop
0x0005afbc slti asmTemp,v0,0x0065
0x0005afc0 bne asmTemp,r0,0x0005afd0
0x0005afc4 nop
0x0005afc8 addiu v0,r0,0x0064
0x0005afcc sh v0,0x0032(a0)
0x0005afd0 jr ra
0x0005afd4 nop
