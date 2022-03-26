/**
 * gte_tr -> translation vector
 * gte_rt -> rotation matrix
 * gte_cr24 -> screen offset X
 * gte_cr25 -> screen offset Y
 * gte_cr26 -> projection plane distance (in map data)
 */
int entityCheckCombatArea(entityPtr, locationPtr, width, height) {
  if(load(0x134F0A) == 4)
    return 0
  
  setTransformationMatrix(0x136F84)
  
  entityPosition = load(entityPtr + 0x04)
  digimonType = load(entityPtr)
  radius = load(0x12CECC + digimonType * 52)
  
  for(s3 = 0; s3 < 2; s3++)
    for(s1 = 0; s1 < 4; s1++) {
      // calculate current screen position
      xPos = load(entityPosition + 0x78) + load(0x134398 + s3 * 2) * radius
      yPos = load(entityPosition + 0x7C) + s3 * -200
      zPos = load(entityPosition + 0x80) + load(0x134399 + s3 * 2) * radius
      
      // perspective transformation, done on GTE, using gte_registers
      ir1 = (gte_trx * 0x1000 + gte_rt11 * xPos + gte_rt12 * yPos + gte_rt13 * zPos) >> 12
      ir2 = (gte_try * 0x1000 + gte_rt21 * xPos + gte_rt22 * yPos + gte_rt23 * zPos) >> 12
      ir3 = (gte_trz * 0x1000 + gte_rt31 * xPos + gte_rt32 * yPos + gte_rt33 * zPos) >> 12
      
      sx2 = ((((gte_cr26 * 0x20000 / ir3) + 1) / 2) * ir1 + gte_cr24) / 0x10000
      sy2 = ((((gte_cr26 * 0x20000 / ir3) + 1) / 2) * ir2 + gte_cr25) / 0x10000
      
      screenPosNew = { sy2, sx2 }
      
      // calculate previous screen position
      xPos = load(locationPtr + 0x00) + load(0x134398 + s3 * 2) * radius
      yPos = load(locationPtr + 0x04) + s3 * -200
      zPos = load(locationPtr + 0x08) + load(0x134399 + s3 * 2) * radius
      
      // perspective transformation, done on GTE, using gte_registers
      ir1 = (gte_trx * 0x1000 + gte_rt11 * xPos + gte_rt12 * yPos + gte_rt13 * zPos) >> 12
      ir2 = (gte_try * 0x1000 + gte_rt21 * xPos + gte_rt22 * yPos + gte_rt23 * zPos) >> 12
      ir3 = (gte_trz * 0x1000 + gte_rt31 * xPos + gte_rt32 * yPos + gte_rt33 * zPos) >> 12
      
      sx2 = ((((gte_cr26 * 0x20000 / ir3) + 1) / 2) * ir1 + gte_cr24) / 0x10000
      sy2 = ((((gte_cr26 * 0x20000 / ir3) + 1) / 2) * ir2 + gte_cr25) / 0x10000
      
      screenPosOld = { sy2, sx2 }
      
      if(hasMovedOutsideCombatArea(screenPosOld, screenPosNew, width, height) != 0)
        return 1
    }
  
  return 0
}

0x000d3648 addiu sp,sp,0xffb0
0x000d364c sw ra,0x0034(sp)
0x000d3650 sw fp,0x0030(sp)
0x000d3654 sw s7,0x002c(sp)
0x000d3658 sw s6,0x0028(sp)
0x000d365c sw s5,0x0024(sp)
0x000d3660 sw s4,0x0020(sp)
0x000d3664 sw s3,0x001c(sp)
0x000d3668 sw s2,0x0018(sp)
0x000d366c sw s1,0x0014(sp)
0x000d3670 sw s0,0x0010(sp)
0x000d3674 lb v0,-0x6c22(gp)
0x000d3678 addu s1,a0,r0
0x000d367c addu s0,a1,r0
0x000d3680 addu s5,a2,r0
0x000d3684 addiu asmTemp,r0,0x0004
0x000d3688 bne v0,asmTemp,0x000d3698
0x000d368c addu s6,a3,r0
0x000d3690 beq r0,r0,0x000d3828
0x000d3694 addu v0,r0,r0
0x000d3698 lui a0,0x8013
0x000d369c jal 0x00097dd8
0x000d36a0 addiu a0,a0,0x6f84
0x000d36a4 lw v0,0x0004(s1)
0x000d36a8 lw v1,0x0000(s1)
0x000d36ac addiu s7,v0,0x0078
0x000d36b0 sll v0,v1,0x01
0x000d36b4 add v0,v0,v1
0x000d36b8 sll v0,v0,0x02
0x000d36bc add v0,v0,v1
0x000d36c0 sll v1,v0,0x02
0x000d36c4 lui v0,0x8013
0x000d36c8 addiu v0,v0,0xcecc
0x000d36cc addu v0,v0,v1
0x000d36d0 lh v0,0x0000(v0)
0x000d36d4 addu s3,r0,r0
0x000d36d8 beq r0,r0,0x000d3818
0x000d36dc sw v0,0x003c(sp)
0x000d36e0 sll v0,s3,0x02
0x000d36e4 sub v0,s3,v0
0x000d36e8 sll v0,v0,0x03
0x000d36ec sub v0,v0,s3
0x000d36f0 lw s2,0x003c(sp)
0x000d36f4 addu s1,r0,r0
0x000d36f8 sll fp,s3,0x01
0x000d36fc beq r0,r0,0x000d3808
0x000d3700 sll s4,v0,0x03
0x000d3704 addiu v0,gp,0x886c
0x000d3708 addu a2,v0,fp
0x000d370c lb v1,0x0000(a2)
0x000d3710 lw v0,0x0000(s7)
0x000d3714 mult s2,v1
0x000d3718 mflo v1
0x000d371c add v0,v0,v1
0x000d3720 sh v0,0x0048(sp)
0x000d3724 lw v0,0x0004(s7)
0x000d3728 nop
0x000d372c add v0,v0,s4
0x000d3730 sh v0,0x004a(sp)
0x000d3734 addiu v0,gp,0x886d
0x000d3738 addu v1,v0,fp
0x000d373c lb a0,0x0000(v1)
0x000d3740 lw v0,0x0008(s7)
0x000d3744 mult s2,a0
0x000d3748 mflo a0
0x000d374c add v0,v0,a0
0x000d3750 sh v0,0x004c(sp)
0x000d3754 addiu v0,sp,0x0048
0x000d3758 addu a0,v0,r0
0x000d375c lwc2 gtedr00_vxy0,0x0000(a0)
0x000d3760 lwc2 gtedr01_vz0,0x0004(a0)
0x000d3764 nop
0x000d3768 nop
0x000d376c rtps
0x000d3770 addiu a1,sp,0x0044
0x000d3774 addu a0,a1,r0
0x000d3778 swc2 gtedr14_sxy2,0x0000(a0)
0x000d377c lb a2,0x0000(a2)
0x000d3780 lw a0,0x0000(s0)
0x000d3784 mult s2,a2
0x000d3788 mflo a2
0x000d378c add a0,a0,a2
0x000d3790 sh a0,0x0048(sp)
0x000d3794 lw a0,0x0004(s0)
0x000d3798 nop
0x000d379c add a0,a0,s4
0x000d37a0 sh a0,0x004a(sp)
0x000d37a4 lb a0,0x0000(v1)
0x000d37a8 nop
0x000d37ac mult s2,a0
0x000d37b0 lw v1,0x0008(s0)
0x000d37b4 mflo a0
0x000d37b8 add v1,v1,a0
0x000d37bc sh v1,0x004c(sp)
0x000d37c0 addu a0,v0,r0
0x000d37c4 lwc2 gtedr00_vxy0,0x0000(a0)
0x000d37c8 lwc2 gtedr01_vz0,0x0004(a0)
0x000d37cc nop
0x000d37d0 nop
0x000d37d4 rtps
0x000d37d8 addiu a0,sp,0x0040
0x000d37dc swc2 gtedr14_sxy2,0x0000(a0)
0x000d37e0 sll a2,s5,0x10
0x000d37e4 sll a3,s6,0x10
0x000d37e8 sra a2,a2,0x10
0x000d37ec jal 0x000d38d4
0x000d37f0 sra a3,a3,0x10
0x000d37f4 beq v0,r0,0x000d3804
0x000d37f8 nop
0x000d37fc beq r0,r0,0x000d3828
0x000d3800 addiu v0,r0,0x0001
0x000d3804 addi s1,s1,0x0001
0x000d3808 slti asmTemp,s1,0x0004
0x000d380c bne asmTemp,r0,0x000d3704
0x000d3810 nop
0x000d3814 addi s3,s3,0x0001
0x000d3818 slti asmTemp,s3,0x0002
0x000d381c bne asmTemp,r0,0x000d36e0
0x000d3820 nop
0x000d3824 addu v0,r0,r0
0x000d3828 lw ra,0x0034(sp)
0x000d382c lw fp,0x0030(sp)
0x000d3830 lw s7,0x002c(sp)
0x000d3834 lw s6,0x0028(sp)
0x000d3838 lw s5,0x0024(sp)
0x000d383c lw s4,0x0020(sp)
0x000d3840 lw s3,0x001c(sp)
0x000d3844 lw s2,0x0018(sp)
0x000d3848 lw s1,0x0014(sp)
0x000d384c lw s0,0x0010(sp)
0x000d3850 jr ra
0x000d3854 addiu sp,sp,0x0050