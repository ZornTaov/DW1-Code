0x000D4884(playerPtr, partnerPtr, val1, val2) {
  flags = load(partnerPtr + 0x30) & 0x05
  store(partnerPtr + 0x30, flags)
  someFlagValue = 0
  
  if(entityCheckCollision(playerPtr, partnerPtr, val1, val2) == -1)
    return
  
  rotationPtr = load(partnerPtr + 0x04) + 0x72
  initRotation = load(rotationPtr)
  someOffset = initRotation / 512
  
  for(s3 = 0; s3 < 4; s3++) {
    tmpRotation = load(0x1289F4 + someOffset * 8 + s3 * 2)
    store(rotationPtr, tmpRotation)
    
    if(entityCheckCollision(playerPtr, partnerPtr, val1, val2) == -1) {
      rotation = load(rotationPtr)
      
      rotationDiff = initRotation - rotation
      if(rotationDiff < 0)
        rotationDiff = (rotationDiff + 0x1000) & 0x0FFF
      
      rotationSum = rotation + initRotation
      if(rotationSum < 0)
        rotationSum = (rotationSum + 0x1000) & 0x0FFF
      
      if(rotationDiff - rotationSum < 0) {
        if(rotationDiff < 80)
          newRotation = (initRotation + 0x0FB0) & 0x0FFF
        else
          newRotation = (initRotation + 0x1000 - rotationDiff) & 0x0FFF
      }
      else {
        if(rotationSum < 80)
          newRotation = (initRotation + 80) & 0x0FFF
        else
          newRotation = (initRotation + rotationSum) & 0x0FFF
      }
      
      store(rotationPtr, newRotation)
      
      flags = load(partnerPtr + 0x30) | someFlagValue
      store(partnerPtr + 0x30, flags)
      return
    }
    else {
      shiftVal = load(rotationPtr) / 1024
      someFlagValue = someFlagValue & (0x08 << shiftVal) & 0xFF
    }
  }
  
  store(rotationPtr, (initRotation + 0x20) & 0x0FFF)
  flags = load(partnerPtr + 0x30) | 2
  store(partnerPtr + 0x30, flags)
}

0x000d4884 addiu sp,sp,0xffc8
0x000d4888 sw ra,0x0034(sp)
0x000d488c sw fp,0x0030(sp)
0x000d4890 sw s7,0x002c(sp)
0x000d4894 sw s6,0x0028(sp)
0x000d4898 sw s5,0x0024(sp)
0x000d489c sw s4,0x0020(sp)
0x000d48a0 sw s3,0x001c(sp)
0x000d48a4 sw s2,0x0018(sp)
0x000d48a8 sw s1,0x0014(sp)
0x000d48ac sw s0,0x0010(sp)
0x000d48b0 addu s1,a1,r0
0x000d48b4 lbu v0,0x0030(s1)
0x000d48b8 addu s6,a0,r0
0x000d48bc andi v0,v0,0x0005
0x000d48c0 addu s7,a2,r0
0x000d48c4 addu fp,a3,r0
0x000d48c8 sb v0,0x0030(s1)
0x000d48cc jal 0x000d45ec
0x000d48d0 addu s5,r0,r0
0x000d48d4 addiu asmTemp,r0,0xffff
0x000d48d8 beq v0,asmTemp,0x000d4aac
0x000d48dc nop
0x000d48e0 lw v0,0x0004(s1)
0x000d48e4 nop
0x000d48e8 addiu s0,v0,0x0072
0x000d48ec lh s2,0x0000(s0)
0x000d48f0 nop
0x000d48f4 addu v0,s2,r0
0x000d48f8 bgez v0,0x000d4908
0x000d48fc sra t9,v0,0x09
0x000d4900 addiu v0,v0,0x01ff
0x000d4904 sra t9,v0,0x09
0x000d4908 sll s4,t9,0x10
0x000d490c sra s4,s4,0x10
0x000d4910 beq r0,r0,0x000d4a84
0x000d4914 addu s3,r0,r0
0x000d4918 lui v0,0x8013
0x000d491c sll v1,s4,0x03
0x000d4920 addiu v0,v0,0x89f4
0x000d4924 addu v1,v0,v1
0x000d4928 sll v0,s3,0x01
0x000d492c addu v0,v0,v1
0x000d4930 lh v0,0x0000(v0)
0x000d4934 addu a0,s6,r0
0x000d4938 sh v0,0x0000(s0)
0x000d493c addu a1,s1,r0
0x000d4940 addu a2,s7,r0
0x000d4944 jal 0x000d45ec
0x000d4948 addu a3,fp,r0
0x000d494c addiu asmTemp,r0,0xffff
0x000d4950 bne v0,asmTemp,0x000d4a54
0x000d4954 nop
0x000d4958 lh v0,0x0000(s0)
0x000d495c nop
0x000d4960 addu a1,v0,r0
0x000d4964 sub v0,s2,v0
0x000d4968 sll v1,v0,0x10
0x000d496c sra v1,v1,0x10
0x000d4970 bgez v1,0x000d4988
0x000d4974 addu a0,s2,r0
0x000d4978 addi v0,v1,0x1000
0x000d497c andi v0,v0,0x0fff
0x000d4980 sll v1,v0,0x10
0x000d4984 sra v1,v1,0x10
0x000d4988 sub v0,a1,a0
0x000d498c sll a0,v0,0x10
0x000d4990 sra a0,a0,0x10
0x000d4994 bgez a0,0x000d49ac
0x000d4998 nop
0x000d499c addi v0,a0,0x1000
0x000d49a0 andi v0,v0,0x0fff
0x000d49a4 sll a0,v0,0x10
0x000d49a8 sra a0,a0,0x10
0x000d49ac sub v0,v1,a0
0x000d49b0 sll v0,v0,0x10
0x000d49b4 sh s2,0x0000(s0)
0x000d49b8 addu a1,v1,r0
0x000d49bc sra v0,v0,0x10
0x000d49c0 bgez v0,0x000d4a08
0x000d49c4 addu a2,a0,r0
0x000d49c8 slti asmTemp,v1,0x0051
0x000d49cc bne asmTemp,r0,0x000d49ec
0x000d49d0 nop
0x000d49d4 lh v0,0x0000(s0)
0x000d49d8 nop
0x000d49dc addi v0,v0,0x0fb0
0x000d49e0 andi v0,v0,0x0fff
0x000d49e4 beq r0,r0,0x000d4a40
0x000d49e8 sh v0,0x0000(s0)
0x000d49ec lh v0,0x0000(s0)
0x000d49f0 nop
0x000d49f4 addi v0,v0,0x1000
0x000d49f8 sub v0,v0,a1
0x000d49fc andi v0,v0,0x0fff
0x000d4a00 beq r0,r0,0x000d4a40
0x000d4a04 sh v0,0x0000(s0)
0x000d4a08 slti asmTemp,a0,0x0051
0x000d4a0c bne asmTemp,r0,0x000d4a2c
0x000d4a10 nop
0x000d4a14 lh v0,0x0000(s0)
0x000d4a18 nop
0x000d4a1c addi v0,v0,0x0050
0x000d4a20 andi v0,v0,0x0fff
0x000d4a24 beq r0,r0,0x000d4a40
0x000d4a28 sh v0,0x0000(s0)
0x000d4a2c lh v0,0x0000(s0)
0x000d4a30 nop
0x000d4a34 add v0,v0,a2
0x000d4a38 andi v0,v0,0x0fff
0x000d4a3c sh v0,0x0000(s0)
0x000d4a40 lbu v0,0x0030(s1)
0x000d4a44 nop
0x000d4a48 or v0,v0,s5
0x000d4a4c beq r0,r0,0x000d4aac
0x000d4a50 sb v0,0x0030(s1)
0x000d4a54 lh v0,0x0000(s0)
0x000d4a58 nop
0x000d4a5c bgez v0,0x000d4a6c
0x000d4a60 sra t9,v0,0x0a
0x000d4a64 addiu v0,v0,0x03ff
0x000d4a68 sra t9,v0,0x0a
0x000d4a6c addiu v0,r0,0x0008
0x000d4a70 sllv v0,v0,t9
0x000d4a74 andi v0,v0,0x00ff
0x000d4a78 or v0,s5,v0
0x000d4a7c andi s5,v0,0x00ff
0x000d4a80 addi s3,s3,0x0001
0x000d4a84 slti asmTemp,s3,0x0004
0x000d4a88 bne asmTemp,r0,0x000d4918
0x000d4a8c nop
0x000d4a90 addi v0,s2,0x0020
0x000d4a94 andi v0,v0,0x0fff
0x000d4a98 sh v0,0x0000(s0)
0x000d4a9c lbu v0,0x0030(s1)
0x000d4aa0 nop
0x000d4aa4 ori v0,v0,0x0002
0x000d4aa8 sb v0,0x0030(s1)
0x000d4aac lw ra,0x0034(sp)
0x000d4ab0 lw fp,0x0030(sp)
0x000d4ab4 lw s7,0x002c(sp)
0x000d4ab8 lw s6,0x0028(sp)
0x000d4abc lw s5,0x0024(sp)
0x000d4ac0 lw s4,0x0020(sp)
0x000d4ac4 lw s3,0x001c(sp)
0x000d4ac8 lw s2,0x0018(sp)
0x000d4acc lw s1,0x0014(sp)
0x000d4ad0 lw s0,0x0010(sp)
0x000d4ad4 jr ra
0x000d4ad8 addiu sp,sp,0x0038