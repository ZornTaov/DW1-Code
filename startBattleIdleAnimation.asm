/**
 * Starts the battle idle animation, using the normal/tired variation 
 * depending on poison/health status.
 */
void startBattleIdleAnimation(entityPtr, statsPtr, flags) {
  useTiredAnim = 1
  
  if(flags & 0x01 == 0) { // check if not poisoned
    maxHP = load(statsPtr + 0x10)
    currentHP = load(statsPtr + 0x14)
    
    if(maxHP * 0.3 < currentHP)
      useTiredAnim = 0
  }
  
  animId = useTiredAnim == 0 ? 0x21 : 0x22
    
  startAnimation(entityPtr, animId)
}

0x000e8970 andi v0,a2,0x0001
0x000e8974 bne v0,r0,0x000e89b0
0x000e8978 addiu a3,r0,0x0001
0x000e897c lui v0,0x6666
0x000e8980 lh v1,0x0010(a1)
0x000e8984 ori v0,v0,0x6667
0x000e8988 mult v0,v1
0x000e898c lh a2,0x0014(a1)
0x000e8990 mfhi v0
0x000e8994 srl v1,v1,0x1f
0x000e8998 sra v0,v0,0x01
0x000e899c addu v0,v0,v1
0x000e89a0 slt asmTemp,v0,a2
0x000e89a4 beq asmTemp,r0,0x000e89b0
0x000e89a8 nop
0x000e89ac addu a3,r0,r0
0x000e89b0 beq a3,r0,0x000e89c0
0x000e89b4 addiu v0,r0,0x0021
0x000e89b8 beq r0,r0,0x000e89c0
0x000e89bc addiu v0,r0,0x0022
0x000e89c0 j 0x000c1a04
0x000e89c4 andi a1,v0,0x00ff