/**
 * Gets the closest, living, enemy.
 */
int getClosestEnemy(entityPtr, hostileMap) {
  minDistance = 0xFFFF
  closestEntity = -1
  
  for(i = 0; load(0x134D6C) < i; i++) { // enemy count
  
    if(load(hostileMap + i * 2) != 1)
      continue
      
    combatPtr = load(0x134D4C) // combatPtr
    
    entityId = load(combatPtr + 0x66C + i)
    enemyEntityPtr = load(0x12F344 + entityId * 4) // entityList?
    
    if(entityPtr == enemyEntityPtr)
      continue
    
    if(hasZeroHP(i) != 0)
      continue
    
    distance = distanceSquared(entityPtr, enemyEntityPtr)
    
    if(distance >= minDistance)
      continue
    
    minDistance = distance
    closestEntity = i
  }
  
  return closestEntity
}

0x00060218 addiu sp,sp,0xffd0
0x0006021c sw ra,0x002c(sp)
0x00060220 sw s6,0x0028(sp)
0x00060224 sw s5,0x0024(sp)
0x00060228 sw s4,0x0020(sp)
0x0006022c sw s3,0x001c(sp)
0x00060230 sw s2,0x0018(sp)
0x00060234 sw s1,0x0014(sp)
0x00060238 addiu v0,r0,0x00ff
0x0006023c sw s0,0x0010(sp)
0x00060240 sll s1,v0,0x10
0x00060244 addu s3,a0,r0
0x00060248 addu s6,a1,r0
0x0006024c sra s1,s1,0x10
0x00060250 addiu s5,r0,0xffff
0x00060254 addu s0,r0,r0
0x00060258 beq r0,r0,0x000602e4
0x0006025c addu s4,r0,r0
0x00060260 addu v0,s6,s4
0x00060264 lh v0,0x0000(v0)
0x00060268 addiu asmTemp,r0,0x0001
0x0006026c bne v0,asmTemp,0x000602dc
0x00060270 nop
0x00060274 lw v0,-0x6de0(gp)
0x00060278 nop
0x0006027c addu v0,s0,v0
0x00060280 lbu v0,0x066c(v0)
0x00060284 nop
0x00060288 sll v1,v0,0x02
0x0006028c lui v0,0x8013
0x00060290 addiu v0,v0,0xf344
0x00060294 addu v0,v0,v1
0x00060298 lw s2,0x0000(v0)
0x0006029c nop
0x000602a0 beq s3,s2,0x000602dc
0x000602a4 nop
0x000602a8 jal 0x000601ac
0x000602ac andi a0,s0,0x00ff
0x000602b0 bne v0,r0,0x000602dc
0x000602b4 nop
0x000602b8 addu a0,s3,r0
0x000602bc jal 0x0005d608
0x000602c0 addu a1,s2,r0
0x000602c4 sltu asmTemp,v0,s5
0x000602c8 beq asmTemp,r0,0x000602dc
0x000602cc nop
0x000602d0 sll s1,s0,0x10
0x000602d4 addu s5,v0,r0
0x000602d8 sra s1,s1,0x10
0x000602dc addi s0,s0,0x0001
0x000602e0 addi s4,s4,0x0002
0x000602e4 lh v0,-0x6dc0(gp)
0x000602e8 nop
0x000602ec slt asmTemp,v0,s0
0x000602f0 beq asmTemp,r0,0x00060260
0x000602f4 nop
0x000602f8 addu v0,s1,r0
0x000602fc lw ra,0x002c(sp)
0x00060300 lw s6,0x0028(sp)
0x00060304 lw s5,0x0024(sp)
0x00060308 lw s4,0x0020(sp)
0x0006030c lw s3,0x001c(sp)
0x00060310 lw s2,0x0018(sp)
0x00060314 lw s1,0x0014(sp)
0x00060318 lw s0,0x0010(sp)
0x0006031c jr ra
0x00060320 addiu sp,sp,0x0030