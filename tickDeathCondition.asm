void tickDeathCondition() {
  transLockActive = load(0x134CA8)
  transLockHour = load(0x134CA4)
  currentHour = load(0x134EBC)
  
  if(transLockActive == 1 && transLockHour == currentHour)
    return
  
  if(load(0x1384A8) > 0) // remaining Lifetime
    return
  
  if(load(0x134C5B) == 8) // is in dying state
    return
  
  if(loadMenuState() != 0)
    return
  
  if(load(0x134FF4) != 1) // is script running
    return
  
  store(0x134C4C, 1)
  writePStat(255, 0)
  store(0x1384A8, 0)
  
  callScriptSection(0, 0x4DE, 0)
}

0x000a8a3c addiu sp,sp,0xffe8
0x000a8a40 lw v0,-0x6e84(gp)
0x000a8a44 addiu asmTemp,r0,0x0001
0x000a8a48 bne v0,asmTemp,0x000a8a64
0x000a8a4c sw ra,0x0010(sp)
0x000a8a50 lb v1,-0x6e88(gp)
0x000a8a54 lh v0,-0x6c70(gp)
0x000a8a58 nop
0x000a8a5c beq v1,v0,0x000a8ad4
0x000a8a60 nop
0x000a8a64 lui asmTemp,0x8014
0x000a8a68 lh v0,-0x7b58(asmTemp)
0x000a8a6c nop
0x000a8a70 bgtz v0,0x000a8ad4
0x000a8a74 nop
0x000a8a78 lb v0,-0x6ed1(gp)
0x000a8a7c addiu asmTemp,r0,0x0008
0x000a8a80 beq v0,asmTemp,0x000a8ad4
0x000a8a84 nop
0x000a8a88 jal 0x000ac050
0x000a8a8c nop
0x000a8a90 bne v0,r0,0x000a8ad4
0x000a8a94 nop
0x000a8a98 lw v0,-0x6b38(gp)
0x000a8a9c addiu asmTemp,r0,0x0001
0x000a8aa0 bne v0,asmTemp,0x000a8ad4
0x000a8aa4 nop
0x000a8aa8 addiu v0,r0,0x0001
0x000a8aac sw v0,-0x6ee0(gp)
0x000a8ab0 addiu a0,r0,0x00ff
0x000a8ab4 jal 0x00106474
0x000a8ab8 addu a1,r0,r0
0x000a8abc lui asmTemp,0x8014
0x000a8ac0 sh r0,-0x7b58(asmTemp)
0x000a8ac4 addu a0,r0,r0
0x000a8ac8 addiu a1,r0,0x04de
0x000a8acc jal 0x00105b14
0x000a8ad0 addu a2,r0,r0
0x000a8ad4 lw ra,0x0010(sp)
0x000a8ad8 nop
0x000a8adc jr ra
0x000a8ae0 addiu sp,sp,0x0018