int,int,int getRotationDifference(locationPtr, targetPtr) {
  locationPtr = locationPtr
  
  posY1 = load(targetPtr + 0x08)
  posY2 = load(locationPtr + 0x80)
  diffY = posY1 - posY2
  
  posX1 = load(locationPtr + 0x78)
  posX2 = load(targetPtr)
  diffX = posX2 - posX1
  
  targetAngle = atan(diffY, diffX)
  currentRotation = load(locationPtr + 0x72)
  
  if(currentRotation < targetAngle) {
    clockwiseDiff = targetAngle - currentRotation
    counterClockwiseDiff = currentRotation - targetAngle + 0x1000
  }
  else {
    clockwiseDiff = targetAngle - currentRotation + 0x1000
    counterClockwiseDiff = currentRotation - targetAngle
  }
  
  return targetAngle, counterClockwiseDiff, clockwiseDiff
}

0x000b6edc addiu sp,sp,0xffd8
0x000b6ee0 sw ra,0x0020(sp)
0x000b6ee4 sw s3,0x001c(sp)
0x000b6ee8 sw s2,0x0018(sp)
0x000b6eec sw s1,0x0014(sp)
0x000b6ef0 sw s0,0x0010(sp)
0x000b6ef4 addu s0,a0,r0
0x000b6ef8 lw v1,0x0008(a1)
0x000b6efc lw v0,0x0080(s0)
0x000b6f00 lw s3,0x0038(sp)
0x000b6f04 sub v0,v1,v0
0x000b6f08 sll a0,v0,0x10
0x000b6f0c lw v1,0x0078(s0)
0x000b6f10 lw v0,0x0000(a1)
0x000b6f14 addu s1,a2,r0
0x000b6f18 sub v0,v0,v1
0x000b6f1c sll a1,v0,0x10
0x000b6f20 addu s2,a3,r0
0x000b6f24 sra a0,a0,0x10
0x000b6f28 jal 0x000a37fc
0x000b6f2c sra a1,a1,0x10
0x000b6f30 sh v0,0x0000(s1)
0x000b6f34 lh v1,0x0000(s1)
0x000b6f38 lh v0,0x0072(s0)
0x000b6f3c addu a1,v1,r0
0x000b6f40 slt asmTemp,v0,v1
0x000b6f44 beq asmTemp,r0,0x000b6f70
0x000b6f48 addu a0,v0,r0
0x000b6f4c sub v0,a1,a0
0x000b6f50 sh v0,0x0000(s3)
0x000b6f54 lh v1,0x0000(s1)
0x000b6f58 addiu v0,r0,0x1000
0x000b6f5c lh a0,0x0072(s0)
0x000b6f60 sub v0,v0,v1
0x000b6f64 add v0,a0,v0
0x000b6f68 beq r0,r0,0x000b6f94
0x000b6f6c sh v0,0x0000(s2)
0x000b6f70 addiu v0,r0,0x1000
0x000b6f74 sub v0,v0,a0
0x000b6f78 add v0,a1,v0
0x000b6f7c sh v0,0x0000(s3)
0x000b6f80 lh v1,0x0072(s0)
0x000b6f84 lh v0,0x0000(s1)
0x000b6f88 nop
0x000b6f8c sub v0,v1,v0
0x000b6f90 sh v0,0x0000(s2)
0x000b6f94 lw ra,0x0020(sp)
0x000b6f98 lw s3,0x001c(sp)
0x000b6f9c lw s2,0x0018(sp)
0x000b6fa0 lw s1,0x0014(sp)
0x000b6fa4 lw s0,0x0010(sp)
0x000b6fa8 jr ra
0x000b6fac addiu sp,sp,0x0028