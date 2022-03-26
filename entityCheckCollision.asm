/**
 * Checks whether checkedEntityPtr is colliding with anything and returns a response code.
 *
 * noCollideEntityPtr - ignored entity, no collision with it possible
 * checkedEntityPtr - entity checked for collision
 * width - used for screen space collision
 * height - used for screen space collision
 *
 * Response Codes:
 *  11  - screen space collision (see checkMapCollision function)
 *  10  - map collision
 * 0-9  - entity collision (entity ID)
 *  -1  - no collision
 */
int entityCheckCollision(noCollideEntityPtr, checkedEntityPtr, width, height) {
  
  locPtr = load(checkedEntityPtr + 0x04) + 0x78
  
  locationArray = int[4]
  locationArray[0] = load(locPtr + 0x00)
  locationArray[1] = load(locPtr + 0x04)
  locationArray[2] = load(locPtr + 0x08)
  locationArray[3] = load(locPtr + 0x0C)
  
  someFlag = load(checkedEntityPtr + 0x30) & 0x0005
  store(checkedEntityPtr + 0x30, someFlag)
  
  entityMoveForward(checkedEntityPtr)
  
  diffX = load(locPtr + 0x00) - locationArray[0]
  diffY = load(locPtr + 0x08) - locationArray[2]
  
  rotationPtr = load(checkedEntityPtr + 0x04) + 0x72
  rotation = load(rotationPtr) // rotation
  
  if(rotation == 0x0400 || rotation == 0x0C00)
    diffY = 0
    
  if(rotation == 0x0000 || rotation == 0x0800)
    diffX = 0
  
  store(locPtr + 0x00, locationArray[0])
  store(locPtr + 0x04, locationArray[1])
  store(locPtr + 0x08, locationArray[2])
  store(locPtr + 0x0C, locationArray[3])
  
  if(width != 0 && height != 0 && entityCheckCombatArea(checkedEntityPtr, locationArray, width, height) != 0)
    return 0x0B
  
  if(checkMapCollision(checkedEntityPtr, diffX, diffY) != 0)
    return 0x0A
  
  for(i = 0; i < 10; i++) {
    lEntityPtr = load(0x12F344 + i * 4)
    
    if(isInvisible(lEntityPtr) != 0)
      continue
      
    if(lEntityPtr == checkedEntityPtr)
      continue
    
    if(lEntityPtr == noCollideEntityPtr)
      continue
      
    if(i != 0) {
      if(load(lEntityPtr + 0x4C) == 0)
        continue
    }
    else if(load(0x134F0A) == 1) {
      animId = load(checkedEntityPtr + 0x2E)
      if(animId == 0x23 || animId == 0x24)
        continue
    }
    
    if(entityCheckEntityCollision(checkedEntityPtr, lEntityPtr, diffX, diffY) != 0)
      return i
  }
  
  return -1
}

0x000d45ec addiu sp,sp,0xffb8
0x000d45f0 sw ra,0x0030(sp)
0x000d45f4 sw s7,0x002c(sp)
0x000d45f8 sw s6,0x0028(sp)
0x000d45fc sw s5,0x0024(sp)
0x000d4600 sw s4,0x0020(sp)
0x000d4604 sw s3,0x001c(sp)
0x000d4608 sw s2,0x0018(sp)
0x000d460c sw s1,0x0014(sp)
0x000d4610 sw s0,0x0010(sp)
0x000d4614 addu s3,a1,r0
0x000d4618 lw v0,0x0004(s3)
0x000d461c addu s7,a0,r0
0x000d4620 addiu s0,v0,0x0078
0x000d4624 lw a1,0x0000(s0)
0x000d4628 lw a0,0x0004(s0)
0x000d462c lw v1,0x0008(s0)
0x000d4630 lw v0,0x000c(s0)
0x000d4634 addu s1,a2,r0
0x000d4638 sw a1,0x0038(sp)
0x000d463c sw a0,0x003c(sp)
0x000d4640 sw v1,0x0040(sp)
0x000d4644 sw v0,0x0044(sp)
0x000d4648 lbu v0,0x0030(s3)
0x000d464c addu s2,a3,r0
0x000d4650 andi v0,v0,0x0005
0x000d4654 sb v0,0x0030(s3)
0x000d4658 jal 0x000d4f10
0x000d465c addu a0,s3,r0
0x000d4660 lw v1,0x0000(s0)
0x000d4664 lw v0,0x0038(sp)
0x000d4668 addiu asmTemp,r0,0x0400
0x000d466c sub s6,v1,v0
0x000d4670 lw v1,0x0008(s0)
0x000d4674 lw v0,0x0040(sp)
0x000d4678 nop
0x000d467c sub s5,v1,v0
0x000d4680 lw v0,0x0004(s3)
0x000d4684 nop
0x000d4688 lh v0,0x0072(v0)
0x000d468c nop
0x000d4690 beq v0,asmTemp,0x000d46a4
0x000d4694 nop
0x000d4698 addiu asmTemp,r0,0x0c00
0x000d469c bne v0,asmTemp,0x000d46a8
0x000d46a0 nop
0x000d46a4 addu s5,r0,r0
0x000d46a8 beq v0,r0,0x000d46bc
0x000d46ac nop
0x000d46b0 addiu asmTemp,r0,0x0800
0x000d46b4 bne v0,asmTemp,0x000d46c0
0x000d46b8 nop
0x000d46bc addu s6,r0,r0
0x000d46c0 beq s1,r0,0x000d4714
0x000d46c4 nop
0x000d46c8 beq s2,r0,0x000d4714
0x000d46cc nop
0x000d46d0 addu a0,s3,r0
0x000d46d4 addiu a1,sp,0x0038
0x000d46d8 addu a2,s1,r0
0x000d46dc jal 0x000d3648
0x000d46e0 addu a3,s2,r0
0x000d46e4 beq v0,r0,0x000d4714
0x000d46e8 nop
0x000d46ec lw a1,0x0038(sp)
0x000d46f0 lw a0,0x003c(sp)
0x000d46f4 lw v1,0x0040(sp)
0x000d46f8 lw v0,0x0044(sp)
0x000d46fc sw a1,0x0000(s0)
0x000d4700 sw a0,0x0004(s0)
0x000d4704 sw v1,0x0008(s0)
0x000d4708 sw v0,0x000c(s0)
0x000d470c beq r0,r0,0x000d4858
0x000d4710 addiu v0,r0,0x000b
0x000d4714 addu a0,s3,r0
0x000d4718 addu a1,s6,r0
0x000d471c jal 0x000d5018
0x000d4720 addu a2,s5,r0
0x000d4724 beq v0,r0,0x000d4754
0x000d4728 addu s2,r0,r0
0x000d472c lw a1,0x0038(sp)
0x000d4730 lw a0,0x003c(sp)
0x000d4734 lw v1,0x0040(sp)
0x000d4738 lw v0,0x0044(sp)
0x000d473c sw a1,0x0000(s0)
0x000d4740 sw a0,0x0004(s0)
0x000d4744 sw v1,0x0008(s0)
0x000d4748 sw v0,0x000c(s0)
0x000d474c beq r0,r0,0x000d4858
0x000d4750 addiu v0,r0,0x000a
0x000d4754 beq r0,r0,0x000d4828
0x000d4758 addu s4,r0,r0
0x000d475c lui v0,0x8013
0x000d4760 addiu v0,v0,0xf344
0x000d4764 addu v0,v0,s4
0x000d4768 lw s1,0x0000(v0)
0x000d476c jal 0x000e61ac
0x000d4770 addu a0,s1,r0
0x000d4774 bne v0,r0,0x000d4820
0x000d4778 nop
0x000d477c beq s1,s3,0x000d4820
0x000d4780 nop
0x000d4784 beq s1,s7,0x000d4820
0x000d4788 nop
0x000d478c beq s2,r0,0x000d47ac
0x000d4790 nop
0x000d4794 lh v0,0x004c(s1)
0x000d4798 nop
0x000d479c bne v0,r0,0x000d47d8
0x000d47a0 nop
0x000d47a4 beq r0,r0,0x000d4824
0x000d47a8 addi s2,s2,0x0001
0x000d47ac lb v0,-0x6c22(gp)
0x000d47b0 addiu asmTemp,r0,0x0001
0x000d47b4 bne v0,asmTemp,0x000d47d8
0x000d47b8 nop
0x000d47bc lbu v0,0x002e(s3)
0x000d47c0 addiu asmTemp,r0,0x0024
0x000d47c4 beq v0,asmTemp,0x000d4820
0x000d47c8 addu v1,v0,r0
0x000d47cc addiu asmTemp,r0,0x0023
0x000d47d0 beq v1,asmTemp,0x000d4820
0x000d47d4 nop
0x000d47d8 addu a0,s3,r0
0x000d47dc addu a1,s1,r0
0x000d47e0 addu a2,s6,r0
0x000d47e4 jal 0x000d50dc
0x000d47e8 addu a3,s5,r0
0x000d47ec beq v0,r0,0x000d4820
0x000d47f0 nop
0x000d47f4 lw a1,0x0038(sp)
0x000d47f8 lw a0,0x003c(sp)
0x000d47fc lw v1,0x0040(sp)
0x000d4800 lw v0,0x0044(sp)
0x000d4804 sw a1,0x0000(s0)
0x000d4808 sw a0,0x0004(s0)
0x000d480c sw v1,0x0008(s0)
0x000d4810 sw v0,0x000c(s0)
0x000d4814 sll v0,s2,0x10
0x000d4818 beq r0,r0,0x000d4858
0x000d481c sra v0,v0,0x10
0x000d4820 addi s2,s2,0x0001
0x000d4824 addi s4,s4,0x0004
0x000d4828 slti asmTemp,s2,0x000a
0x000d482c bne asmTemp,r0,0x000d475c
0x000d4830 nop
0x000d4834 lw a1,0x0038(sp)
0x000d4838 lw a0,0x003c(sp)
0x000d483c lw v1,0x0040(sp)
0x000d4840 lw v0,0x0044(sp)
0x000d4844 sw a1,0x0000(s0)
0x000d4848 sw a0,0x0004(s0)
0x000d484c sw v1,0x0008(s0)
0x000d4850 sw v0,0x000c(s0)
0x000d4854 addiu v0,r0,0xffff
0x000d4858 lw ra,0x0030(sp)
0x000d485c lw s7,0x002c(sp)
0x000d4860 lw s6,0x0028(sp)
0x000d4864 lw s5,0x0024(sp)
0x000d4868 lw s4,0x0020(sp)
0x000d486c lw s3,0x001c(sp)
0x000d4870 lw s2,0x0018(sp)
0x000d4874 lw s1,0x0014(sp)
0x000d4878 lw s0,0x0010(sp)
0x000d487c jr ra
0x000d4880 addiu sp,sp,0x0048