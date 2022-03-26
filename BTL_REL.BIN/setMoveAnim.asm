/**
 * Sets a move's animation and range in the combat data, as well as some flags.
 */
void setMoveAnim(entityPtr, combatPtr, unused, attackId) {
  store(combatPtr + 0x2C, 0)
  
  animId = load(entityPtr + 0x44 + attackId)
  techId = getTechFromMove(entityPtr, animId)
  range = load(0x126244 + techId * 0x10)
  
  store(combatPtr + 0x36, range)
  store(combatPtr + 0x38, animId)
  
  setChargeupFlag(entityPtr, combatPtr, techId)
  
  flags = load(combatPtr + 0x34) | 0x0040 // some flag
  store(combatPtr + 0x34, flags)
}

0x0005d658 addiu sp,sp,0xffe0
0x0005d65c sw ra,0x0018(sp)
0x0005d660 sw s1,0x0014(sp)
0x0005d664 sw s0,0x0010(sp)
0x0005d668 addu s1,a0,r0
0x0005d66c addu s0,a1,r0
0x0005d670 sh r0,0x002c(s0)
0x0005d674 addu v0,a3,s1
0x0005d678 lbu v0,0x0044(v0)
0x0005d67c nop
0x0005d680 sb v0,0x0038(s0)
0x0005d684 lbu a1,0x0038(s0)
0x0005d688 jal 0x000e6000
0x0005d68c nop
0x0005d690 sll a2,v0,0x10
0x0005d694 sra a2,a2,0x10
0x0005d698 lui v0,0x8012
0x0005d69c sll v1,a2,0x04
0x0005d6a0 addiu v0,v0,0x6244
0x0005d6a4 addu v0,v0,v1
0x0005d6a8 lbu v0,0x0000(v0)
0x0005d6ac addu a0,s1,r0
0x0005d6b0 sb v0,0x0036(s0)
0x0005d6b4 jal 0x0005d6e0
0x0005d6b8 addu a1,s0,r0
0x0005d6bc lhu v0,0x0034(s0)
0x0005d6c0 nop
0x0005d6c4 ori v0,v0,0x0040
0x0005d6c8 sh v0,0x0034(s0)
0x0005d6cc lw ra,0x0018(sp)
0x0005d6d0 lw s1,0x0014(sp)
0x0005d6d4 lw s0,0x0010(sp)
0x0005d6d8 jr ra
0x0005d6dc addiu sp,sp,0x0020