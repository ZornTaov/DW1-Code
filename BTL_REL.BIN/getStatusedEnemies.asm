/**
 * Gets an array and count of statused and alive enemies for a given Digimon.
 * The values get stored in addresses given by a1 (array) and a2 (count), 
 * typically on the stack.
 */
int[], int getStatusedEnemies(entityPtr) {
  count = 0
  array = new int[4]
  combatHead = load(0x134D4C) // combat head
  
  // for each enemy
  for(i = 0; i <= load(0x134D6C); i++) {
    entityId = load(combatHead + 0x066C + i)
    localEntityPtr = load(0x12F344 + entityId * 4)
    
    if(entityPtr == localEntityPtr)
      continue
      
    if(hasZeroHP(i))
      continue
    
    // is poisoned, confused, stunned or flattened
    flags = load(combatHead + i * 0x168 + 0x34) & 0x000F
    
    if(flags == 0)
      continue
      
    array[count] = i
    count++;
  }
  
  return count
}

0x0005f51c addiu sp,sp,0xffd0
0x0005f520 sw ra,0x0028(sp)
0x0005f524 sw s5,0x0024(sp)
0x0005f528 sw s4,0x0020(sp)
0x0005f52c sw s3,0x001c(sp)
0x0005f530 sw s2,0x0018(sp)
0x0005f534 sw s1,0x0014(sp)
0x0005f538 sw s0,0x0010(sp)
0x0005f53c addu s1,a2,r0
0x0005f540 sh r0,0x0000(s1)
0x0005f544 lw s3,-0x6de0(gp)
0x0005f548 addu s5,a0,r0
0x0005f54c addu s4,a1,r0
0x0005f550 addu s0,r0,r0
0x0005f554 beq r0,r0,0x0005f5e4
0x0005f558 addu s2,r0,r0
0x0005f55c lw v0,-0x6de0(gp)
0x0005f560 nop
0x0005f564 addu v0,s0,v0
0x0005f568 lbu v0,0x066c(v0)
0x0005f56c nop
0x0005f570 sll v1,v0,0x02
0x0005f574 lui v0,0x8013
0x0005f578 addiu v0,v0,0xf344
0x0005f57c addu v0,v0,v1
0x0005f580 lw v0,0x0000(v0)
0x0005f584 nop
0x0005f588 beq s5,v0,0x0005f5dc
0x0005f58c nop
0x0005f590 jal 0x000601ac
0x0005f594 andi a0,s0,0x00ff
0x0005f598 bne v0,r0,0x0005f5dc
0x0005f59c nop
0x0005f5a0 addu v0,s2,s3
0x0005f5a4 lhu v0,0x0034(v0)
0x0005f5a8 nop
0x0005f5ac andi v0,v0,0x000f
0x0005f5b0 beq v0,r0,0x0005f5dc
0x0005f5b4 nop
0x0005f5b8 lh v0,0x0000(s1)
0x0005f5bc nop
0x0005f5c0 sll v0,v0,0x01
0x0005f5c4 addu v0,s4,v0
0x0005f5c8 sh s0,0x0000(v0)
0x0005f5cc lh v0,0x0000(s1)
0x0005f5d0 nop
0x0005f5d4 addi v0,v0,0x0001
0x0005f5d8 sh v0,0x0000(s1)
0x0005f5dc addi s0,s0,0x0001
0x0005f5e0 addi s2,s2,0x0168
0x0005f5e4 lh v0,-0x6dc0(gp)
0x0005f5e8 nop
0x0005f5ec slt asmTemp,v0,s0
0x0005f5f0 beq asmTemp,r0,0x0005f55c
0x0005f5f4 nop
0x0005f5f8 lw ra,0x0028(sp)
0x0005f5fc lw s5,0x0024(sp)
0x0005f600 lw s4,0x0020(sp)
0x0005f604 lw s3,0x001c(sp)
0x0005f608 lw s2,0x0018(sp)
0x0005f60c lw s1,0x0014(sp)
0x0005f610 lw s0,0x0010(sp)
0x0005f614 jr ra
0x0005f618 addiu sp,sp,0x0030