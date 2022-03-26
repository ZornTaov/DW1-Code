int atan(diffY, diffX) {
  if(diffY < 0)
    orientation = diffX < 0 ? 2 : 1
  else
    orientation = diffX < 0 ? 3 : 0
  
  if(diffY < 0)
    diffY = -diffY
  if(diffX < 0)
    diffX = -diffX
  
  if(diffY >= diffX) {
    lookupId = diffX * 512 / diffY
    
    if(lookupId >= 0x200)
      lookupId = 511
    
    // approx f(x)=((-x-256)/37.5)^2+46.5
    angle = load(0x11FA1C + lookupId * 2) 
  }
  else {
    lookupId = diffY * 512 / diffX
    
    if(lookupId >= 0x200)
      lookupId = 511
      
    // approx f(x)=((-x-256)/37.5)^2+46.5
    angle = 1023 - load(0x11FA1C + lookupId * 2) 
  }
  
  if(orientation == 1 || orientation == 2)
    angle = 2048 - angle
  
  if(orientation >= 2)
    angle = -angle
  
  return (angle + 2048) & 0x0FFF
}

0x000a37fc bgez a0,0x000a381c
0x000a3800 nop
0x000a3804 bgez a1,0x000a3814
0x000a3808 nop
0x000a380c beq r0,r0,0x000a382c
0x000a3810 addiu v0,r0,0x0002
0x000a3814 beq r0,r0,0x000a382c
0x000a3818 addiu v0,r0,0x0001
0x000a381c bgez a1,0x000a382c
0x000a3820 addu v0,r0,r0
0x000a3824 beq r0,r0,0x000a382c
0x000a3828 addiu v0,r0,0x0003
0x000a382c bgez a0,0x000a383c
0x000a3830 nop
0x000a3834 beq r0,r0,0x000a383c
0x000a3838 sub a0,r0,a0
0x000a383c bgez a1,0x000a384c
0x000a3840 nop
0x000a3844 beq r0,r0,0x000a384c
0x000a3848 sub a1,r0,a1
0x000a384c slt asmTemp,a0,a1
0x000a3850 bne asmTemp,r0,0x000a38a0
0x000a3854 nop
0x000a3858 blez a0,0x000a3870
0x000a385c sll a1,a1,0x09
0x000a3860 div a1,a0
0x000a3864 mflo v1
0x000a3868 beq r0,r0,0x000a3874
0x000a386c nop
0x000a3870 addu v1,r0,r0
0x000a3874 slti asmTemp,v1,0x0200
0x000a3878 bne asmTemp,r0,0x000a3884
0x000a387c nop
0x000a3880 addiu v1,r0,0x01ff
0x000a3884 sll a0,v1,0x01
0x000a3888 lui v1,0x8012
0x000a388c addiu v1,v1,0xfa1c
0x000a3890 addu v1,v1,a0
0x000a3894 lh a0,0x0000(v1)
0x000a3898 beq r0,r0,0x000a38ec
0x000a389c addiu asmTemp,r0,0x0001
0x000a38a0 blez a1,0x000a38b8
0x000a38a4 sll a0,a0,0x09
0x000a38a8 div a0,a1
0x000a38ac mflo v1
0x000a38b0 beq r0,r0,0x000a38bc
0x000a38b4 nop
0x000a38b8 addu v1,r0,r0
0x000a38bc slti asmTemp,v1,0x0200
0x000a38c0 bne asmTemp,r0,0x000a38cc
0x000a38c4 nop
0x000a38c8 addiu v1,r0,0x01ff
0x000a38cc sll a0,v1,0x01
0x000a38d0 lui v1,0x8012
0x000a38d4 addiu v1,v1,0xfa1c
0x000a38d8 addu v1,v1,a0
0x000a38dc lh a0,0x0000(v1)
0x000a38e0 addiu v1,r0,0x03ff
0x000a38e4 sub a0,v1,a0
0x000a38e8 addiu asmTemp,r0,0x0001
0x000a38ec beq v0,asmTemp,0x000a3900
0x000a38f0 nop
0x000a38f4 addiu asmTemp,r0,0x0002
0x000a38f8 bne v0,asmTemp,0x000a3908
0x000a38fc nop
0x000a3900 addiu v1,r0,0x0800
0x000a3904 sub a0,v1,a0
0x000a3908 slti asmTemp,v0,0x0002
0x000a390c bne asmTemp,r0,0x000a3918
0x000a3910 nop
0x000a3914 sub a0,r0,a0
0x000a3918 addi v0,a0,0x0800
0x000a391c jr ra
0x000a3920 andi v0,v0,0x0fff