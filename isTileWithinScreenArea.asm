int isTileWithinScreenArea(tileX, tileY) {
  xPos = (tileX - 50) * 100 + 50
  yPos = 0
  zPos = (50 - tileY) * 100 - 50
  
  // perspective transformation, done on GTE, using gte_registers
  ir1 = (gte_trx * 0x1000 + gte_rt11 * xPos + gte_rt12 * yPos + gte_rt13 * zPos) >> 12
  ir2 = (gte_try * 0x1000 + gte_rt21 * xPos + gte_rt22 * yPos + gte_rt23 * zPos) >> 12
  ir3 = (gte_trz * 0x1000 + gte_rt31 * xPos + gte_rt32 * yPos + gte_rt33 * zPos) >> 12
  
  sx2 = ((((gte_cr26 * 0x20000 / ir3) + 1) / 2) * ir1 + gte_cr24) / 0x10000
  sy2 = ((((gte_cr26 * 0x20000 / ir3) + 1) / 2) * ir2 + gte_cr25) / 0x10000
  
  sx2 = sx2 - 160 + load(0x134EC0) // x center
  sy2 = sy2 - 120 + load(0x134EC4) // y center
  
  if(sx2 < -200 || sx2 > 200 || sy2 < -160 || sy2 > 160)
    return 1
  
  return 0
}

0x000d3078 addi v1,a0,-0x0032
0x000d307c sll v0,v1,0x02
0x000d3080 add v1,v0,v1
0x000d3084 sll v0,v1,0x02
0x000d3088 add v0,v1,v0
0x000d308c sll v0,v0,0x02
0x000d3090 addiu sp,sp,0xfff0
0x000d3094 addi v0,v0,0x0032
0x000d3098 sh v0,0x0008(sp)
0x000d309c addiu v0,r0,0x0032
0x000d30a0 sub v1,v0,a1
0x000d30a4 sll v0,v1,0x02
0x000d30a8 add v1,v0,v1
0x000d30ac sll v0,v1,0x02
0x000d30b0 add v0,v1,v0
0x000d30b4 sll v0,v0,0x02
0x000d30b8 sh r0,0x000a(sp)
0x000d30bc addi v0,v0,-0x0032
0x000d30c0 sh v0,0x000c(sp)
0x000d30c4 addiu a0,sp,0x0008
0x000d30c8 lwc2 gtedr00_vxy0,0x0000(a0)
0x000d30cc lwc2 gtedr01_vz0,0x0004(a0)
0x000d30d0 nop
0x000d30d4 nop
0x000d30d8 rtps
0x000d30dc addiu a0,sp,0x0004
0x000d30e0 swc2 gtedr14_sxy2,0x0000(a0)
0x000d30e4 lw v0,-0x6c6c(gp)
0x000d30e8 addiu v1,r0,0x00a0
0x000d30ec sub v1,v1,v0
0x000d30f0 sll v1,v1,0x10
0x000d30f4 lh v0,0x0004(sp)
0x000d30f8 sra v1,v1,0x10
0x000d30fc sub v0,v0,v1
0x000d3100 sh v0,0x0004(sp)
0x000d3104 lw v0,-0x6c68(gp)
0x000d3108 addiu v1,r0,0x0078
0x000d310c sub v1,v1,v0
0x000d3110 sll v1,v1,0x10
0x000d3114 lh v0,0x0006(sp)
0x000d3118 sra v1,v1,0x10
0x000d311c sub v0,v0,v1
0x000d3120 sh v0,0x0006(sp)
0x000d3124 lh v0,0x0004(sp)
0x000d3128 nop
0x000d312c slti asmTemp,v0,-0x00c8
0x000d3130 bne asmTemp,r0,0x000d3164
0x000d3134 nop
0x000d3138 slti asmTemp,v0,0x00c9
0x000d313c beq asmTemp,r0,0x000d3164
0x000d3140 nop
0x000d3144 lh v0,0x0006(sp)
0x000d3148 nop
0x000d314c slti asmTemp,v0,-0x00a0
0x000d3150 bne asmTemp,r0,0x000d3164
0x000d3154 addu v1,v0,r0
0x000d3158 slti asmTemp,v1,0x00a1
0x000d315c bne asmTemp,r0,0x000d316c
0x000d3160 addu v0,r0,r0
0x000d3164 beq r0,r0,0x000d316c
0x000d3168 addiu v0,r0,0x0001
0x000d316c jr ra
0x000d3170 addiu sp,sp,0x0010