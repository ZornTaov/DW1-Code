/**
 * Checks whether a Digimon has 0 HP or has enough unattributed damage to have 0 HP.
 * Returns 1 if the HP are or will be <= 0, 0 otherwise.
 */
int hasZeroHP(combatId) {
  combatHead = load(0x134D4C)
  
  entityId = load(combatHead + 0x066C + combatId)
  entityPtr = load(0x12F344 + entityId * 4)
  currentHP = load(entityPtr + 0x4C)
  remainingDamage = load(combatHead + combatId * 0x168 + 0x2E)
  
  return currentHP - remainingDamage <= 0 ? 1 : 0
}

0x000601ac lw a2,-0x6de0(gp)
0x000601b0 nop
0x000601b4 addu v0,a0,a2
0x000601b8 lbu v0,0x066c(v0)
0x000601bc nop
0x000601c0 sll v1,v0,0x02
0x000601c4 lui v0,0x8013
0x000601c8 addiu v0,v0,0xf344
0x000601cc addu v0,v0,v1
0x000601d0 lw v0,0x0000(v0)
0x000601d4 nop
0x000601d8 lh a1,0x004c(v0)
0x000601dc sll v0,a0,0x04
0x000601e0 sub v1,v0,a0
0x000601e4 sll v0,v1,0x02
0x000601e8 sub v0,v0,v1
0x000601ec sll v0,v0,0x03
0x000601f0 addu v0,v0,a2
0x000601f4 lh v0,0x002e(v0)
0x000601f8 nop
0x000601fc sub v0,a1,v0
0x00060200 bgtz v0,0x00060210
0x00060204 addu v0,r0,r0
0x00060208 beq r0,r0,0x00060210
0x0006020c addiu v0,r0,0x0001
0x00060210 jr ra
0x00060214 nop