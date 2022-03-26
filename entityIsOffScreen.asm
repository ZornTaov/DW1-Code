int entityIsOffScreen(entityPtr, width, height) {
  entityType = load(entityPtr)
  positionPtr = load(entityPtr + 0x04) + 0x78
  radius = load(0x12CECC + load(entityPtr) * 52)
  
  if(entityType == 152 && load(entityPtr + 0x2E) == 24) // is NPC Kunemon in anim 24
    return 0
  
  setTransformationMatrix(0x136F84)
  
  for(s2 = 0; s2 < 2; s2++) {
    for(s0 = 0; s0 < 4; s0++) {
      xPos = load(positionPtr + 0x00) + load(0x134398 + s0 * 2) * radius
      yPos = load(positionPtr + 0x04) + s2 * -radius
      zPos = load(positionPtr + 0x08) + load(0x134399 + s0 * 2) * radius
      
      // perspective transformation, done on GTE, using gte_registers
      ir1 = (gte_trx * 0x1000 + gte_rt11 * xPos + gte_rt12 * yPos + gte_rt13 * zPos) >> 12
      ir2 = (gte_try * 0x1000 + gte_rt21 * xPos + gte_rt22 * yPos + gte_rt23 * zPos) >> 12
      ir3 = (gte_trz * 0x1000 + gte_rt31 * xPos + gte_rt32 * yPos + gte_rt33 * zPos) >> 12
      
      sx2 = ((((gte_cr26 * 0x20000 / ir3) + 1) / 2) * ir1 + gte_cr24) / 0x10000
      sy2 = ((((gte_cr26 * 0x20000 / ir3) + 1) / 2) * ir2 + gte_cr25) / 0x10000
      
      screenPos = { sy2, sx2 }
      
      if(isOffScreen(screenPos, width, height) == 0)
        return 0
    }
  }
  
  return 1
}

0x000d5430 addiu sp,sp,0xffb8
0x000d5434 sw ra,0x0034(sp)
0x000d5438 sw fp,0x0030(sp)
0x000d543c sw s7,0x002c(sp)
0x000d5440 sw s6,0x0028(sp)
0x000d5444 sw s5,0x0024(sp)
0x000d5448 sw s4,0x0020(sp)
0x000d544c sw s3,0x001c(sp)
0x000d5450 sw s2,0x0018(sp)
0x000d5454 sw s1,0x0014(sp)
0x000d5458 sw s0,0x0010(sp)
0x000d545c addu s7,a0,r0
0x000d5460 lw v0,0x0000(s7)
0x000d5464 addu s3,a1,r0
0x000d5468 addiu asmTemp,r0,0x0098
0x000d546c bne v0,asmTemp,0x000d548c
0x000d5470 addu s4,a2,r0
0x000d5474 lbu v0,0x002e(s7)
0x000d5478 addiu asmTemp,r0,0x001c
0x000d547c bne v0,asmTemp,0x000d548c
0x000d5480 nop
0x000d5484 beq r0,r0,0x000d55d8
0x000d5488 addu v0,r0,r0
0x000d548c lui a0,0x8013
0x000d5490 jal 0x00097dd8
0x000d5494 addiu a0,a0,0x6f84
0x000d5498 lw v0,0x0004(s7)
0x000d549c lw v1,0x0000(s7)
0x000d54a0 addiu s5,v0,0x0078
0x000d54a4 sll v0,v1,0x01
0x000d54a8 add v0,v0,v1
0x000d54ac sll v0,v0,0x02
0x000d54b0 add v0,v0,v1
0x000d54b4 sll v1,v0,0x02
0x000d54b8 lui v0,0x8013
0x000d54bc addiu v0,v0,0xcecc
0x000d54c0 addu v0,v0,v1
0x000d54c4 lh fp,0x0000(v0)
0x000d54c8 beq r0,r0,0x000d55c8
0x000d54cc addu s2,r0,r0
0x000d54d0 addu s1,r0,r0
0x000d54d4 beq r0,r0,0x000d55b8
0x000d54d8 addu s6,fp,r0
0x000d54dc addiu v0,gp,0x886c
0x000d54e0 addu v0,v0,s1
0x000d54e4 lb v1,0x0000(v0)
0x000d54e8 addiu a0,sp,0x0040
0x000d54ec mult s6,v1
0x000d54f0 lw v0,0x0000(s5)
0x000d54f4 mflo v1
0x000d54f8 add v0,v0,v1
0x000d54fc sh v0,0x0040(sp)
0x000d5500 lw v1,0x0000(s7)
0x000d5504 nop
0x000d5508 sll v0,v1,0x01
0x000d550c add v0,v0,v1
0x000d5510 sll v0,v0,0x02
0x000d5514 add v0,v0,v1
0x000d5518 sll v1,v0,0x02
0x000d551c lui v0,0x8013
0x000d5520 addiu v0,v0,0xcece
0x000d5524 addu v0,v0,v1
0x000d5528 lh v0,0x0000(v0)
0x000d552c nop
0x000d5530 sub v1,r0,v0
0x000d5534 mult s2,v1
0x000d5538 lw v0,0x0004(s5)
0x000d553c mflo v1
0x000d5540 add v0,v0,v1
0x000d5544 sh v0,0x0042(sp)
0x000d5548 addiu v0,gp,0x886d
0x000d554c addu v0,v0,s1
0x000d5550 lb v1,0x0000(v0)
0x000d5554 nop
0x000d5558 mult s6,v1
0x000d555c lw v0,0x0008(s5)
0x000d5560 mflo v1
0x000d5564 add v0,v0,v1
0x000d5568 sh v0,0x0044(sp)
0x000d556c lwc2 gtedr00_vxy0,0x0000(a0)
0x000d5570 lwc2 gtedr01_vz0,0x0004(a0)
0x000d5574 nop
0x000d5578 nop
0x000d557c rtps
0x000d5580 addiu v0,sp,0x003c
0x000d5584 addu a0,v0,r0
0x000d5588 swc2 gtedr14_sxy2,0x0000(a0)
0x000d558c sll a1,s3,0x10
0x000d5590 sll a2,s4,0x10
0x000d5594 sra a1,a1,0x10
0x000d5598 jal 0x000d5608
0x000d559c sra a2,a2,0x10
0x000d55a0 bne v0,r0,0x000d55b0
0x000d55a4 nop
0x000d55a8 beq r0,r0,0x000d55d8
0x000d55ac addu v0,r0,r0
0x000d55b0 addi s0,s0,0x0001
0x000d55b4 addi s1,s1,0x0002
0x000d55b8 slti asmTemp,s0,0x0004
0x000d55bc bne asmTemp,r0,0x000d54dc
0x000d55c0 nop
0x000d55c4 addi s2,s2,0x0001
0x000d55c8 slti asmTemp,s2,0x0002
0x000d55cc bne asmTemp,r0,0x000d54d0
0x000d55d0 addu s0,r0,r0
0x000d55d4 addiu v0,r0,0x0001
0x000d55d8 lw ra,0x0034(sp)
0x000d55dc lw fp,0x0030(sp)
0x000d55e0 lw s7,0x002c(sp)
0x000d55e4 lw s6,0x0028(sp)
0x000d55e8 lw s5,0x0024(sp)
0x000d55ec lw s4,0x0020(sp)
0x000d55f0 lw s3,0x001c(sp)
0x000d55f4 lw s2,0x0018(sp)
0x000d55f8 lw s1,0x0014(sp)
0x000d55fc lw s0,0x0010(sp)
0x000d5600 jr ra
0x000d5604 addiu sp,sp,0x0048