/**
 * Calculates a score for an enemy of the given Digimon, used to determine
 * the weakest enemy to target.
 * 
 * This function is most likely bugged, since it is using the first Digimon's
 * stats, which are always the same, causing the type factor being the only
 * variable when iterating over the list of enemies.
 */
int getWeaknessScore(entityPtr, enemyEntityPtr) {
  entitySpec = load(0x12CED2 + load(entityPtr) * 0x34)
  enemySpec = load(0x12CED2 + load(enemyEntityPtr) * 0x34)
  
  typeFactor = load(0x125F70 + entitySpec * 7 + enemySpec)
  
  if(typeFactor == 2)
    typeFactor = 20
  else if(typeFactor == 5)
    typeFactor = 15
  else if(typeFactor == 15)
    typeFactor = 5
  else if(typeFactor == 20)
    typeFactor = 2
  
  defense = load(entityPtr + 0x3A) // defense
  currentHP = load(entityPtr + 0x4C) * 100 // currentHP
  maxHP = load(entityPtr + 0x48) // maxHP
  
  return (currentHP * 100 / maxHP) + (typeFactor * defense / 100)
}

0x0005f764 addiu v1,a0,0x0038
0x0005f768 lw a0,0x0000(a0)
0x0005f76c lui a3,0x8013
0x0005f770 sll v0,a0,0x01
0x0005f774 add v0,v0,a0
0x0005f778 sll v0,v0,0x02
0x0005f77c add v0,v0,a0
0x0005f780 sll v0,v0,0x02
0x0005f784 addiu a3,a3,0xced2
0x0005f788 addu v0,a3,v0
0x0005f78c lbu a0,0x0000(v0)
0x0005f790 addiu asmTemp,r0,0x0002
0x0005f794 sll v0,a0,0x03
0x0005f798 sub a2,v0,a0
0x0005f79c lui v0,0x8012
0x0005f7a0 lw a0,0x0000(a1)
0x0005f7a4 addiu v0,v0,0x5f70
0x0005f7a8 addu a1,v0,a2
0x0005f7ac sll v0,a0,0x01
0x0005f7b0 add v0,v0,a0
0x0005f7b4 sll v0,v0,0x02
0x0005f7b8 add v0,v0,a0
0x0005f7bc sll v0,v0,0x02
0x0005f7c0 addu v0,a3,v0
0x0005f7c4 lbu v0,0x0000(v0)
0x0005f7c8 nop
0x0005f7cc addu v0,v0,a1
0x0005f7d0 lbu v0,0x0000(v0)
0x0005f7d4 nop
0x0005f7d8 sll v0,v0,0x10
0x0005f7dc sra v0,v0,0x10
0x0005f7e0 beq v0,asmTemp,0x0005f83c
0x0005f7e4 nop
0x0005f7e8 addiu asmTemp,r0,0x0005
0x0005f7ec beq v0,asmTemp,0x0005f82c
0x0005f7f0 nop
0x0005f7f4 addiu asmTemp,r0,0x000f
0x0005f7f8 beq v0,asmTemp,0x0005f81c
0x0005f7fc nop
0x0005f800 addiu asmTemp,r0,0x0014
0x0005f804 bne v0,asmTemp,0x0005f848
0x0005f808 nop
0x0005f80c addiu v0,r0,0x0002
0x0005f810 sll v0,v0,0x10
0x0005f814 beq r0,r0,0x0005f848
0x0005f818 sra v0,v0,0x10
0x0005f81c addiu v0,r0,0x0005
0x0005f820 sll v0,v0,0x10
0x0005f824 beq r0,r0,0x0005f848
0x0005f828 sra v0,v0,0x10
0x0005f82c addiu v0,r0,0x000f
0x0005f830 sll v0,v0,0x10
0x0005f834 beq r0,r0,0x0005f848
0x0005f838 sra v0,v0,0x10
0x0005f83c addiu v0,r0,0x0014
0x0005f840 sll v0,v0,0x10
0x0005f844 sra v0,v0,0x10
0x0005f848 lh a1,0x0002(v1)
0x0005f84c nop
0x0005f850 sll a0,a1,0x02
0x0005f854 add a1,a0,a1
0x0005f858 sll a0,a1,0x02
0x0005f85c add a0,a1,a0
0x0005f860 sll a2,a0,0x02
0x0005f864 lui a0,0x8334
0x0005f868 ori a0,a0,0x0521
0x0005f86c mult a0,a2
0x0005f870 srl a1,a2,0x1f
0x0005f874 mfhi a0
0x0005f878 addu a0,a0,a2
0x0005f87c sra a0,a0,0x09
0x0005f880 addu a0,a0,a1
0x0005f884 mult v0,a0
0x0005f888 lui v0,0x6666
0x0005f88c mflo a0
0x0005f890 ori v0,v0,0x6667
0x0005f894 nop
0x0005f898 mult v0,a0
0x0005f89c srl a1,a0,0x1f
0x0005f8a0 mfhi v0
0x0005f8a4 sra v0,v0,0x02
0x0005f8a8 lh a0,0x0014(v1)
0x0005f8ac addu a1,v0,a1
0x0005f8b0 sll v0,a0,0x02
0x0005f8b4 add a0,v0,a0
0x0005f8b8 sll v0,a0,0x02
0x0005f8bc add a0,a0,v0
0x0005f8c0 lh v0,0x0010(v1)
0x0005f8c4 sll v1,a0,0x02
0x0005f8c8 div v1,v0
0x0005f8cc mflo v0
0x0005f8d0 add v0,v0,a1
0x0005f8d4 sll v0,v0,0x10
0x0005f8d8 jr ra
0x0005f8dc sra v0,v0,0x10