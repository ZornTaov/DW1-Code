int getChanceToHit(attackerPtr, victimPtr, victimCombatPtr, usedMove) {
  victimType = load(victimPtr)
  
  if(load(0x12CED1 + victimType * 52) < 3) // level below Rookie
    return 100
  
  combatFlags = load(victimCombatPtr + 0x34) // status flags
  
  if(combatFlags & 0x200C != 0) // stunned, flattened, stupid
    return 100
  
  if(load(0x138460) & 0x0040 != 0) // partner is sick
    return 100
    
  if(load(victimCombatPtr + 0x32) <= 0) // victim speed buffer is <= 0
    return 100
  
  activeAnim = load(victimPtr + 0x2E)
  
  if(activeAnim >= 0x2E)
    return 100
  
  if(usedMove >= 0x3A && usedMove < 0x71) { // is finisher
    if(combatFlags & 0x0080 != 0) { // is blocking
      v0 = combatFlags & 0xFF7F // unset blocking
      store(victimCombatPtr + 0x34, v0)
      store(victimCombatPtr + 0x26, 0) // blocking timer?
    }
    return 100
  }
  
  if(combatFlags & 0x0080 != 0) // is blocking
    return 0
  
  attackerSpeed = load(attackerPtr + 0x3C) * 0.1
  victimSpeed = load(victimPtr + 0x3C)
  
  speedFactor = (victimSpeed - attackerSpeed) / 1000
  
  accuracy = load(0x126247 + usedMove * 0x10) // move accuracy
  
  blockFactor = (accuracy / 2) * speedFactor
  
  if(activeAnim == 0x21 || activeAnim == 0x22) // is in idle anim 
    blockFactor = blockFactor * 1.2
  
  chanceToHit = accuracy - blockFactor
  
  if(chanceToHit < 0)
    chanceToHit = 0
  if(chanceToHit > 100)
    chanceToHit = 100
  
  return chanceToHit
}

0x0005bbe4 lw v1,0x0000(a1)
0x0005bbe8 nop
0x0005bbec sll v0,v1,0x01
0x0005bbf0 add v0,v0,v1
0x0005bbf4 sll v0,v0,0x02
0x0005bbf8 add v0,v0,v1
0x0005bbfc sll v1,v0,0x02
0x0005bc00 lui v0,0x8013
0x0005bc04 addiu v0,v0,0xced1
0x0005bc08 addu v0,v0,v1
0x0005bc0c lbu v0,0x0000(v0)
0x0005bc10 nop
0x0005bc14 sltiu asmTemp,v0,0x0003
0x0005bc18 beq asmTemp,r0,0x0005bc28
0x0005bc1c nop
0x0005bc20 beq r0,r0,0x0005bdd0
0x0005bc24 addiu v0,r0,0x0064
0x0005bc28 lhu t0,0x0034(a2)
0x0005bc2c nop
0x0005bc30 andi v0,t0,0x200c
0x0005bc34 beq v0,r0,0x0005bc44
0x0005bc38 addu t1,t0,r0
0x0005bc3c beq r0,r0,0x0005bdd0
0x0005bc40 addiu v0,r0,0x0064
0x0005bc44 lui asmTemp,0x8014
0x0005bc48 lw v0,-0x7ba0(asmTemp)
0x0005bc4c nop
0x0005bc50 andi v0,v0,0x0040
0x0005bc54 beq v0,r0,0x0005bc64
0x0005bc58 nop
0x0005bc5c beq r0,r0,0x0005bdd0
0x0005bc60 addiu v0,r0,0x0064
0x0005bc64 lh v0,0x0032(a2)
0x0005bc68 nop
0x0005bc6c bgtz v0,0x0005bc7c
0x0005bc70 nop
0x0005bc74 beq r0,r0,0x0005bdd0
0x0005bc78 addiu v0,r0,0x0064
0x0005bc7c lbu v1,0x002e(a1)
0x0005bc80 nop
0x0005bc84 sltiu asmTemp,v1,0x002e
0x0005bc88 bne asmTemp,r0,0x0005bc98
0x0005bc8c addu v0,v1,r0
0x0005bc90 beq r0,r0,0x0005bdd0
0x0005bc94 addiu v0,r0,0x0064
0x0005bc98 slti asmTemp,a3,0x003a
0x0005bc9c bne asmTemp,r0,0x0005bcd0
0x0005bca0 nop
0x0005bca4 slti asmTemp,a3,0x0071
0x0005bca8 beq asmTemp,r0,0x0005bcd0
0x0005bcac nop
0x0005bcb0 andi v0,t1,0x0080
0x0005bcb4 beq v0,r0,0x0005bcc8
0x0005bcb8 nop
0x0005bcbc andi v0,t0,0xff7f
0x0005bcc0 sh v0,0x0034(a2)
0x0005bcc4 sh r0,0x0026(a2)
0x0005bcc8 beq r0,r0,0x0005bdd0
0x0005bccc addiu v0,r0,0x0064
0x0005bcd0 andi v1,t1,0x0080
0x0005bcd4 beq v1,r0,0x0005bce4
0x0005bcd8 nop
0x0005bcdc beq r0,r0,0x0005bdd0
0x0005bce0 addu v0,r0,r0
0x0005bce4 lh a0,0x003c(a0)
0x0005bce8 lui v1,0x6666
0x0005bcec ori v1,v1,0x6667
0x0005bcf0 mult v1,a0
0x0005bcf4 srl a2,a0,0x1f
0x0005bcf8 mfhi v1
0x0005bcfc sra a0,v1,0x02
0x0005bd00 lh v1,0x003c(a1)
0x0005bd04 addu a0,a0,a2
0x0005bd08 sub a1,v1,a0
0x0005bd0c lui v1,0x8012
0x0005bd10 sll a0,a3,0x04
0x0005bd14 addiu v1,v1,0x6247
0x0005bd18 addu v1,v1,a0
0x0005bd1c lbu a0,0x0000(v1)
0x0005bd20 nop
0x0005bd24 addu v1,a0,r0
0x0005bd28 bgez a0,0x0005bd38
0x0005bd2c sra t9,a0,0x01
0x0005bd30 addiu a0,a0,0x0001
0x0005bd34 sra t9,a0,0x01
0x0005bd38 mult t9,a1
0x0005bd3c lui a0,0x8334
0x0005bd40 mflo a2
0x0005bd44 ori a0,a0,0x0521
0x0005bd48 nop
0x0005bd4c mult a0,a2
0x0005bd50 srl a1,a2,0x1f
0x0005bd54 mfhi a0
0x0005bd58 addu a0,a0,a2
0x0005bd5c sra a0,a0,0x09
0x0005bd60 addiu asmTemp,r0,0x0021
0x0005bd64 beq v0,asmTemp,0x0005bd78
0x0005bd68 addu a0,a0,a1
0x0005bd6c addiu asmTemp,r0,0x0022
0x0005bd70 bne v0,asmTemp,0x0005bda0
0x0005bd74 nop
0x0005bd78 sll v0,a0,0x01
0x0005bd7c add v0,v0,a0
0x0005bd80 sll a0,v0,0x01
0x0005bd84 lui v0,0x6666
0x0005bd88 ori v0,v0,0x6667
0x0005bd8c mult v0,a0
0x0005bd90 mfhi v0
0x0005bd94 srl a0,a0,0x1f
0x0005bd98 sra v0,v0,0x01
0x0005bd9c addu a0,v0,a0
0x0005bda0 sub v0,v1,a0
0x0005bda4 sll v0,v0,0x10
0x0005bda8 sra v0,v0,0x10
0x0005bdac bgez v0,0x0005bdb8
0x0005bdb0 nop
0x0005bdb4 addu v0,r0,r0
0x0005bdb8 slti asmTemp,v0,0x0065
0x0005bdbc bne asmTemp,r0,0x0005bdd0
0x0005bdc0 nop
0x0005bdc4 addiu v0,r0,0x0064
0x0005bdc8 sll v0,v0,0x10
0x0005bdcc sra v0,v0,0x10
0x0005bdd0 jr ra
0x0005bdd4 nop