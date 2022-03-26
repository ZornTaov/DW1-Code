0x00058874() {
  unknownTimer = load(0x134D80)
  
  if(unknownTimer > 0)
    store(0x134D80, unknownTimer - 1)
  
  combatHead = load(0x134D4C) // combat head
  
  for(combatId = 0; combatId < load(0x134D6C); combatId++) {
    combatPtr = combatHead + combatId * 0x168
    entityPtr = load(0x12F344 + load(combatHead + 0x66C + combatId) * 4)
    
    addFinisherValue(combatPtr, 1)
    
    targetId = load(combatPtr + 0x37)
    enemyPtr = 0
    
    if(targetId != -1) {
      enemyPtr = load(0x12F344 + load(combatHead + 0x66C + targetId) * 4)
    
    statusFlag = load(combatPtr + 0x34)
    
    if(statusFlag & 0x0020 != 0) // is attacking
      0x00059508(entityPtr, enemyPtr, combatId)
    else if(statusFlag & 0x0010 != 0 || statusFlag & 0x0080 != 0) // is knocked back or blocking
      0x00059608(entityPtr, combatPtr, combatId)
    else if(load(combatPtr + 0x36) == -1) // move range
      continue
    else if(statusFlag & 0x0008 != 0) // is flattened
      0x00059680(entityPtr, combatPtr, combatId)
    else if(statusFlag & 0x0004 != 0) // is stunned
      0x00059714(entityPtr)
    else if(statusFlag & 0x0002 != 0) // is confused
      0x0005975C(entityPtr, enemyPtr, combatPtr, combatId)
    else if(statusFlag & 0x2000 != 0) // is stupid
      0x00059978(entityPtr, combatPtr)
    else if(statusFlag & 0x0800 != 0) // is on chargeup
      0x000599DC(entityPtr, enemyPtr, combatPtr)
    else if(statusFlag & 0x1000 != 0) // is on cooldown
      0x00059C1C(entityPtr, enemyPtr, combatPtr)
    else
      0x00059CF0(entityPtr, enemyPtr, combatPtr, combatId)
  }
  
  0x0005C798()
  0x0005E674()
}

0x00058874 addiu sp,sp,0xffd8
0x00058878 sw ra,0x0020(sp)
0x0005887c sw s3,0x001c(sp)
0x00058880 sw s2,0x0018(sp)
0x00058884 sw s1,0x0014(sp)
0x00058888 lw v0,-0x6dac(gp)
0x0005888c nop
0x00058890 blez v0,0x000588a0
0x00058894 sw s0,0x0010(sp)
0x00058898 addi v0,v0,-0x0001
0x0005889c sw v0,-0x6dac(gp)
0x000588a0 lw v0,-0x6de0(gp)
0x000588a4 addu s2,r0,r0
0x000588a8 beq r0,r0,0x00058a64
0x000588ac addu s0,v0,r0
0x000588b0 lw v0,-0x6de0(gp)
0x000588b4 addiu s3,s0,0x0034
0x000588b8 addu v0,s2,v0
0x000588bc lbu v0,0x066c(v0)
0x000588c0 addu a0,s0,r0
0x000588c4 sll v1,v0,0x02
0x000588c8 lui v0,0x8013
0x000588cc addiu v0,v0,0xf344
0x000588d0 addu v0,v0,v1
0x000588d4 lw s1,0x0000(v0)
0x000588d8 jal 0x0005dfc8
0x000588dc addiu a1,r0,0x0001
0x000588e0 lbu v1,0x0037(s0)
0x000588e4 addiu asmTemp,r0,0x00ff
0x000588e8 beq v1,asmTemp,0x00058920
0x000588ec addu a1,r0,r0
0x000588f0 lw v0,-0x6de0(gp)
0x000588f4 nop
0x000588f8 addu v0,v1,v0
0x000588fc lbu v0,0x066c(v0)
0x00058900 nop
0x00058904 sll v1,v0,0x02
0x00058908 lui v0,0x8013
0x0005890c addiu v0,v0,0xf344
0x00058910 addu v0,v0,v1
0x00058914 lw a1,0x0000(v0)
0x00058918 beq r0,r0,0x00058924
0x0005891c lhu v0,0x0000(s3)
0x00058920 lhu v0,0x0000(s3)
0x00058924 nop
0x00058928 addu v1,v0,r0
0x0005892c andi v0,v0,0x0020
0x00058930 beq v0,r0,0x0005894c
0x00058934 nop
0x00058938 addu a0,s1,r0
0x0005893c jal 0x00059508
0x00058940 addu a2,s2,r0
0x00058944 beq r0,r0,0x00058a60
0x00058948 addi s2,s2,0x0001
0x0005894c andi v0,v1,0x0010
0x00058950 bne v0,r0,0x00058964
0x00058954 nop
0x00058958 andi v0,v1,0x0080
0x0005895c beq v0,r0,0x0005897c
0x00058960 nop
0x00058964 addu a0,s1,r0
0x00058968 addu a1,s0,r0
0x0005896c jal 0x00059608
0x00058970 addu a2,s2,r0
0x00058974 beq r0,r0,0x00058a60
0x00058978 addi s2,s2,0x0001
0x0005897c lb v0,0x0036(s0)
0x00058980 addiu asmTemp,r0,0xffff
0x00058984 beq v0,asmTemp,0x00058a5c
0x00058988 nop
0x0005898c andi v0,v1,0x0008
0x00058990 beq v0,r0,0x000589b0
0x00058994 nop
0x00058998 addu a0,s1,r0
0x0005899c addu a2,s0,r0
0x000589a0 jal 0x00059680
0x000589a4 addu a3,s2,r0
0x000589a8 beq r0,r0,0x00058a60
0x000589ac addi s2,s2,0x0001
0x000589b0 andi v0,v1,0x0004
0x000589b4 beq v0,r0,0x000589cc
0x000589b8 nop
0x000589bc jal 0x00059714
0x000589c0 addu a0,s1,r0
0x000589c4 beq r0,r0,0x00058a60
0x000589c8 addi s2,s2,0x0001
0x000589cc andi v0,v1,0x0002
0x000589d0 beq v0,r0,0x000589f0
0x000589d4 nop
0x000589d8 addu a0,s1,r0
0x000589dc addu a2,s0,r0
0x000589e0 jal 0x0005975c
0x000589e4 addu a3,s2,r0
0x000589e8 beq r0,r0,0x00058a60
0x000589ec addi s2,s2,0x0001
0x000589f0 andi v0,v1,0x2000
0x000589f4 beq v0,r0,0x00058a10
0x000589f8 nop
0x000589fc addu a0,s1,r0
0x00058a00 jal 0x00059978
0x00058a04 addu a1,s0,r0
0x00058a08 beq r0,r0,0x00058a60
0x00058a0c addi s2,s2,0x0001
0x00058a10 andi v0,v1,0x0800
0x00058a14 beq v0,r0,0x00058a30
0x00058a18 nop
0x00058a1c addu a0,s1,r0
0x00058a20 jal 0x000599dc
0x00058a24 addu a2,s0,r0
0x00058a28 beq r0,r0,0x00058a60
0x00058a2c addi s2,s2,0x0001
0x00058a30 andi v0,v1,0x1000
0x00058a34 beq v0,r0,0x00058a50
0x00058a38 addu a0,s1,r0
0x00058a3c addu a0,s1,r0
0x00058a40 jal 0x00059c1c
0x00058a44 addu a2,s0,r0
0x00058a48 beq r0,r0,0x00058a60
0x00058a4c addi s2,s2,0x0001
0x00058a50 addu a2,s0,r0
0x00058a54 jal 0x00059cf0
0x00058a58 addu a3,s2,r0
0x00058a5c addi s2,s2,0x0001
0x00058a60 addi s0,s0,0x0168
0x00058a64 lh v0,-0x6dc0(gp)
0x00058a68 nop
0x00058a6c slt asmTemp,v0,s2
0x00058a70 beq asmTemp,r0,0x000588b0
0x00058a74 nop
0x00058a78 jal 0x0005c798
0x00058a7c nop
0x00058a80 jal 0x0005e674
0x00058a84 nop
0x00058a88 lw ra,0x0020(sp)
0x00058a8c lw s3,0x001c(sp)
0x00058a90 lw s2,0x0018(sp)
0x00058a94 lw s1,0x0014(sp)
0x00058a98 lw s0,0x0010(sp)
0x00058a9c jr ra
0x00058aa0 addiu sp,sp,0x0028