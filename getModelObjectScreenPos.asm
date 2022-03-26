short, short getModelObjectScreenPos(entitiyPtr, val) {
  setTransformationMatrix(0x136F84)
  
  posPtr = load(entityPtr + 0x04) + val * 0x88 + 0x34
  
  xPos = load(posPtr + 0x14)
  yPos = load(posPtr + 0x18)
  zPos = load(posPtr + 0x1C)
  
  // perspective transformation, done on GTE, using gte_registers
  ir1 = (gte_trx * 0x1000 + gte_rt11 * xPos + gte_rt12 * yPos + gte_rt13 * zPos) >> 12
  ir2 = (gte_try * 0x1000 + gte_rt21 * xPos + gte_rt22 * yPos + gte_rt23 * zPos) >> 12
  ir3 = (gte_trz * 0x1000 + gte_rt31 * xPos + gte_rt32 * yPos + gte_rt33 * zPos) >> 12
  
  sx2 = ((((gte_cr26 * 0x20000 / ir3) + 1) / 2) * ir1 + gte_cr24) / 0x10000
  sy2 = ((((gte_cr26 * 0x20000 / ir3) + 1) / 2) * ir2 + gte_cr25) / 0x10000
  
  sx2 = sx2 - (160 - load(0x134EC0))
  sy2 = sy2 - (120 - load(0x134EC4))
  
  return sx2, sy2
}

0x000e52d8 addiu sp,sp,0xffd8
0x000e52dc sw ra,0x001c(sp)
0x000e52e0 sw s2,0x0018(sp)
0x000e52e4 sw s1,0x0014(sp)
0x000e52e8 addu s2,a0,r0
0x000e52ec sw s0,0x0010(sp)
0x000e52f0 lui a0,0x8013
0x000e52f4 addu s1,a1,r0
0x000e52f8 addu s0,a2,r0
0x000e52fc jal 0x00097dd8
0x000e5300 addiu a0,a0,0x6f84
0x000e5304 sll v0,s1,0x04
0x000e5308 add v1,v0,s1
0x000e530c lw v0,0x0004(s2)
0x000e5310 sll v1,v1,0x03
0x000e5314 addu v0,v0,v1
0x000e5318 addiu v1,v0,0x0034
0x000e531c lw v0,0x0014(v1)
0x000e5320 addiu a0,sp,0x0020
0x000e5324 sh v0,0x0020(sp)
0x000e5328 lw v0,0x0018(v1)
0x000e532c nop
0x000e5330 sh v0,0x0022(sp)
0x000e5334 lw v0,0x001c(v1)
0x000e5338 nop
0x000e533c sh v0,0x0024(sp)
0x000e5340 lwc2 gtedr00_vxy0,0x0000(a0)
0x000e5344 lwc2 gtedr01_vz0,0x0004(a0)
0x000e5348 nop
0x000e534c nop
0x000e5350 rtps
0x000e5354 addu a0,s0,r0
0x000e5358 swc2 gtedr14_sxy2,0x0000(a0)
0x000e535c lw v0,-0x6c6c(gp)
0x000e5360 addiu v1,r0,0x00a0
0x000e5364 sub v1,v1,v0
0x000e5368 sll v1,v1,0x10
0x000e536c lh v0,0x0000(s0)
0x000e5370 sra v1,v1,0x10
0x000e5374 sub v0,v0,v1
0x000e5378 sh v0,0x0000(s0)
0x000e537c lw v0,-0x6c68(gp)
0x000e5380 addiu v1,r0,0x0078
0x000e5384 sub v1,v1,v0
0x000e5388 sll v1,v1,0x10
0x000e538c lh v0,0x0002(s0)
0x000e5390 sra v1,v1,0x10
0x000e5394 sub v0,v0,v1
0x000e5398 sh v0,0x0002(s0)
0x000e539c lw ra,0x001c(sp)
0x000e53a0 lw s2,0x0018(sp)
0x000e53a4 lw s1,0x0014(sp)
0x000e53a8 lw s0,0x0010(sp)
0x000e53ac jr ra
0x000e53b0 addiu sp,sp,0x0028