void healValue(int valueAddress, int amount, int upperLimit) {

  newValue = load(valueAddress) + amount
  store(valueAddress, newValue)

  if(upperLimit < newValue)
    store(valueAddress, upperLimit)
}

0x000c563c lh v0,0x0000(a0)
0x000c5640 nop
0x000c5644 add v0,v0,a1
0x000c5648 sh v0,0x0000(a0)
0x000c564c lh v0,0x0000(a0)
0x000c5650 nop
0x000c5654 slt asmTemp,a2,v0
0x000c5658 beq asmTemp,r0,0x000c5664
0x000c565c nop
0x000c5660 sh a2,0x0000(a0)
0x000c5664 jr ra
0x000c5668 nop