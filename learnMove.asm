void learnMove(int moveId) {
  if(moveId == 0x2C || moveId == 0x30) {
    moveValue = load(0x155804)
    moveValue |= 0x00011000 // Dynamite Kick bit mask
    store(0x155804, moveValue)
  }
  else if(moveId == 0x37 || mvoeId == 0x39) {
    moveValue = load(0x155804)
    moveValue |= 0x02800000 // Horizontal Kick bit mask
    store(0x155804, moveValue)
  }
  else {
    moveBit = moveId & 0x1F
    
    if(moveId < 0 && moveBit != 0) // negative input, should never happen, will bug out
      moveBit += 0xFFE0
    
    moveBitflag = 0x1 << moveBit
    moveByte = moveId >> 5
    
    if(moveId < 0) // negative input, should never happen, will bug out
      moveByte = (moveId + 0x1F) >> 5
  
    newMoveValue = load(0x155800 + moveByte * 4) | moveBitflag
    store(0x155800 + moveByte * 4, newMoveValue)
  }
}


0x000e5f14 addiu asmTemp,r0,0x002c
0x000e5f18 beq a0,asmTemp,0x000e5f2c
0x000e5f1c nop
0x000e5f20 addiu asmTemp,r0,0x0030
0x000e5f24 bne a0,asmTemp,0x000e5f60
0x000e5f28 nop
0x000e5f2c lui asmTemp,0x8015
0x000e5f30 lw v0,0x5804(asmTemp)
0x000e5f34 nop
0x000e5f38 ori v0,v0,0x1000
0x000e5f3c lui asmTemp,0x8015
0x000e5f40 sw v0,0x5804(asmTemp)
0x000e5f44 lui asmTemp,0x8015
0x000e5f48 lw v1,0x5804(asmTemp)
0x000e5f4c lui v0,0x0001
0x000e5f50 or v0,v1,v0
0x000e5f54 lui asmTemp,0x8015
0x000e5f58 beq r0,r0,0x000e5ff8
0x000e5f5c sw v0,0x5804(asmTemp)
0x000e5f60 addiu asmTemp,r0,0x0037
0x000e5f64 beq a0,asmTemp,0x000e5f78
0x000e5f68 nop
0x000e5f6c addiu asmTemp,r0,0x0039
0x000e5f70 bne a0,asmTemp,0x000e5fac
0x000e5f74 nop
0x000e5f78 lui asmTemp,0x8015
0x000e5f7c lw v1,0x5804(asmTemp)
0x000e5f80 lui v0,0x0080
0x000e5f84 or v0,v1,v0
0x000e5f88 lui asmTemp,0x8015
0x000e5f8c sw v0,0x5804(asmTemp)
0x000e5f90 lui asmTemp,0x8015
0x000e5f94 lw v1,0x5804(asmTemp)
0x000e5f98 lui v0,0x0200
0x000e5f9c or v0,v1,v0
0x000e5fa0 lui asmTemp,0x8015
0x000e5fa4 beq r0,r0,0x000e5ff8
0x000e5fa8 sw v0,0x5804(asmTemp)
0x000e5fac bgez a0,0x000e5fc0
0x000e5fb0 andi v1,a0,0x001f
0x000e5fb4 beq v1,r0,0x000e5fc0
0x000e5fb8 nop
0x000e5fbc addiu v1,v1,0xffe0
0x000e5fc0 addiu v0,r0,0x0001
0x000e5fc4 sllv a1,v0,v1
0x000e5fc8 bgez a0,0x000e5fd8
0x000e5fcc sra t9,a0,0x05
0x000e5fd0 addiu v0,a0,0x001f
0x000e5fd4 sra t9,v0,0x05
0x000e5fd8 lui v0,0x8015
0x000e5fdc sll v1,t9,0x02
0x000e5fe0 addiu v0,v0,0x5800
0x000e5fe4 addu v1,v0,v1
0x000e5fe8 lw v0,0x0000(v1)
0x000e5fec nop
0x000e5ff0 or v0,v0,a1
0x000e5ff4 sw v0,0x0000(v1)
0x000e5ff8 jr ra
0x000e5ffc nop