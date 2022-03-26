void decreasePoopLevel() {
  poopLevel = load(0x138478) - 1
  store(0x138478, poopLevel) 
}

0x000c5994 lui asmTemp,0x8014
0x000c5998 lh v0,-0x7b88(asmTemp)
0x000c599c nop
0x000c59a0 addi v0,v0,-0x0001
0x000c59a4 lui asmTemp,0x8014
0x000c59a8 jr ra
0x000c59ac sh v0,-0x7b88(asmTemp)