/**
 * Handle whether battle idle animation should be started or not.
 */
void handleBattleIdle(entityPtr, statsPtr, flags) {
  
  // check noAI flag and unknown ptr
  if(load(0x134D74) != 0 && load(0x134D60) == entityPtr)
    return
  
  currentAnimId = load(entityPtr + 0x002E)
  
  if(currentAnimId == 0x21 || currentAnimId == 0x22)
    return
    
  startBattleIdleAnimation(entityPtr, statsPtr, flags)
}

0x000e7d40 addiu sp,sp,0xffe8
0x000e7d44 lw v0,-0x6db8(gp)
0x000e7d48 sw ra,0x0010(sp)
0x000e7d4c beq v0,r0,0x000e7d64
0x000e7d50 addu a1,a0,r0
0x000e7d54 lw v0,-0x6dcc(gp)
0x000e7d58 nop
0x000e7d5c beq a1,v0,0x000e7d8c
0x000e7d60 nop
0x000e7d64 lbu v0,0x002e(a1)
0x000e7d68 addiu asmTemp,r0,0x0021
0x000e7d6c beq v0,asmTemp,0x000e7d8c
0x000e7d70 addu v1,v0,r0
0x000e7d74 addiu asmTemp,r0,0x0022
0x000e7d78 beq v1,asmTemp,0x000e7d8c
0x000e7d7c nop
0x000e7d80 addu a0,a1,r0
0x000e7d84 jal 0x000e8970
0x000e7d88 addiu a1,a1,0x0038
0x000e7d8c lw ra,0x0010(sp)
0x000e7d90 nop
0x000e7d94 jr ra
0x000e7d98 addiu sp,sp,0x0018