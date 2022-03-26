void addDiscipline(int amount) {
  newDiscipline = load(0x138488) + amount
  store(0x138488, newDiscipline)
  
  if(newDiscipline > 100)
    store(0x138488, 100)
}

0x000c58ec lui asmTemp,0x8014
0x000c58f0 lh v0,-0x7b78(asmTemp)
0x000c58f4 nop
0x000c58f8 add v0,v0,a0
0x000c58fc lui asmTemp,0x8014
0x000c5900 sh v0,-0x7b78(asmTemp)
0x000c5904 lui asmTemp,0x8014
0x000c5908 lh v0,-0x7b78(asmTemp)
0x000c590c nop
0x000c5910 slti asmTemp,v0,0x0064
0x000c5914 bne asmTemp,r0,0x000c5928
0x000c5918 nop
0x000c591c addiu v0,r0,0x0064
0x000c5920 lui asmTemp,0x8014
0x000c5924 sh v0,-0x7b78(asmTemp)
0x000c5928 jr ra
0x000c592c nop