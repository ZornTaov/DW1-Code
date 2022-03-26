/**
 * Checks whether the chargeup flag should be set based on the Digimon's
 * chargeup mode, speed buffer status and used tech and sets it.
 */
void setChargeupFlag(entityPtr, combatPtr, techId) {
  chargeupMode = load(entityPtr + 0x56)
  movePower = load(0x126240 + techId * 0x10)
  speedBuffer = load(combatPtr + 0x32)
  
  if(  chargeupMode == 0 && speedBuffer < 0
    || chargeupMode == 1 && speedBuffer != 100 && speedBuffer < movePower
    || chargeupMode == 2 && speedBuffer < 100) {
    
    flags = load(combatPtr + 0x34) | 0x0800 // chargeup flag
    store(combatPtr + 0x34, flags)
  }
}

0x0005d6e0 lbu v0,0x0056(a0)
0x0005d6e4 addiu asmTemp,r0,0x0002
0x0005d6e8 beq v0,asmTemp,0x0005d770
0x0005d6ec nop
0x0005d6f0 addiu asmTemp,r0,0x0001
0x0005d6f4 beq v0,asmTemp,0x0005d728
0x0005d6f8 nop
0x0005d6fc bne v0,r0,0x0005d794
0x0005d700 nop
0x0005d704 lh v0,0x0032(a1)
0x0005d708 nop
0x0005d70c bgtz v0,0x0005d794
0x0005d710 nop
0x0005d714 lhu v0,0x0034(a1)
0x0005d718 nop
0x0005d71c ori v0,v0,0x0800
0x0005d720 beq r0,r0,0x0005d794
0x0005d724 sh v0,0x0034(a1)
0x0005d728 lh v0,0x0032(a1)
0x0005d72c addiu asmTemp,r0,0x0064
0x0005d730 beq v0,asmTemp,0x0005d794
0x0005d734 addu a0,v0,r0
0x0005d738 lui v0,0x8012
0x0005d73c sll v1,a2,0x04
0x0005d740 addiu v0,v0,0x6240
0x0005d744 addu v0,v0,v1
0x0005d748 lh v0,0x0000(v0)
0x0005d74c nop
0x0005d750 slt asmTemp,a0,v0
0x0005d754 beq asmTemp,r0,0x0005d794
0x0005d758 nop
0x0005d75c lhu v0,0x0034(a1)
0x0005d760 nop
0x0005d764 ori v0,v0,0x0800
0x0005d768 beq r0,r0,0x0005d794
0x0005d76c sh v0,0x0034(a1)
0x0005d770 lh v0,0x0032(a1)
0x0005d774 nop
0x0005d778 slti asmTemp,v0,0x0064
0x0005d77c beq asmTemp,r0,0x0005d794
0x0005d780 nop
0x0005d784 lhu v0,0x0034(a1)
0x0005d788 nop
0x0005d78c ori v0,v0,0x0800
0x0005d790 sh v0,0x0034(a1)
0x0005d794 jr ra
0x0005d798 nop