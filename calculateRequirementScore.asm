int calculateRequirementScore(digimonType, targetType, isMaxCM, isMaxBattles, bestDigimonType) {
  requirementPtr = 0x12ABEC + targetType * 28
  statsPtr = 0x1557E0
  conditionPtr = 0x138460
  
  reqPoints = 0
  
  // care mistake requirement
  numCM = load(conditionPtr + 0x52)
  reqCM = load(requirementPtr + 0x0E)
    
  if(isMaxCM == 0)
    if(numCM >= reqCM)
      reqPoints++
  else if(reqCM >= numCM)
    reqPoints++
  
  // weight requirement
  reqWeight = load(requirementPtr + 0x10)
  weight = load(conditionPtr + 0x42)
  
  if(weight >= reqWeight - 5 && weight <= reqWeight + 5)
    reqPoints++
  
  // stat requirement
  if(load(0x12CED1 + targetType * 52) == 3) { // Target is Rookie Digimon
    statArray1 = int[6]
    statArray2 = int[6]
    reqArray = int[6]
    
    statArray1[0] = statArray2[0] = load(statsPtr + 0x10) / 10 // hp
    statArray1[1] = statArray2[1] = load(statsPtr + 0x12) / 10 // mp
    statArray1[2] = statArray2[2] = load(statsPtr + 0x00)      // off
    statArray1[3] = statArray2[3] = load(statsPtr + 0x02)      // def
    statArray1[4] = statArray2[4] = load(statsPtr + 0x04)      // speed
    statArray1[5] = statArray2[5] = load(statsPtr + 0x06)      // brains
    
    reqArray[0] = load(requirementPtr + 0x02) // hp
    reqArray[1] = load(requirementPtr + 0x04) // mp
    reqArray[2] = load(requirementPtr + 0x06) // off
    reqArray[3] = load(requirementPtr + 0x08) // def
    reqArray[4] = load(requirementPtr + 0x0A) // speed
    reqArray[5] = load(requirementPtr + 0x0C) // brains
    
    for(i = 0; i < 6; i++) {
      isHighest = 1
      
      for(j = 0; j < 6; j++)
        if(statArray1[i] < statArray1[j])
          isHighest = 0
    
      if(isHighest == 1)
        highestStat = i
    }
    
    if(reqArray[highestStat] == 1)
      reqPoints++
  }
  else { // Target is non-Rookie Digimon
    hp = load(statsPtr + 0x10) / 10
    mp = load(statsPtr + 0x12) / 10
    off = load(statsPtr + 0x00)
    def = load(statsPtr + 0x02)
    speed = load(statsPtr + 0x04)
    brains = load(statsPtr + 0x06)
    
    hpReq = load(requirementPtr + 0x02)
    mpReq = load(requirementPtr + 0x04)
    offReq = load(requirementPtr + 0x06)
    defReq = load(requirementPtr + 0x08)
    speedReq = load(requirementPtr + 0x0A)
    brainsReq = load(requirementPtr + 0x0C)
    
    if(hp >= hpReq && mp >= mpReq
    && off >= offReq && def >= defReq
    && speed >= speedReq && brains >= brainsReq)
      reqPoints++
  }
  
  // bonus requirements
  bonusPoints = 0
  bonusDigimon = load(requirementPtr + 0x00)
  bonusHappiness = load(requirementPtr + 0x12)
  bonusDiscipline = load(requirementPtr + 0x14)
  bonusBattles = load(requirementPtr + 0x16)
  bonusTechs = load(requirementPtr + 0x18)
  
  // bonus digimon
  if(bonusDigimon != -1 && bonusDigimon == digimonType)
    bonusPoints = 1
  
  // bonus discipline
  if(bonusDiscipline != -1 && load(conditionPtr + 0x28) >= bonusDiscipline)
    bonusPoints = 1
    
  // bonus happiness
  if(bonusHappiness != -1 && load(conditionPtr + 0x2A) >= bonusHappiness)
    bonusPoints = 1
  
  // bonus battles
  if(bonusBattles != -1) {
    if(isMaxBattles == 0) {
      if(load(conditionPtr + 0x54) >= bonusBattles)
        bonusPoints = 1
    }
    else {
      if(load(conditionPtr + 0x54) <= bonusBattles)
        bonusPoints = 1
    }
  }
   // bonus techs
  if(bonusTechs != -1 && getNumMasteredMoves() >= bonusTechs)
    bonusPoints = 1
  
  reqPoints = reqPoints + bonusPoints
  
  if(reqPoints < 3 || bestDigimonType == -1)
    return reqPoints
  
  // disable Digimon is you had it before, but not the current best Digimon
  raisedTarget = hasDigimonRaised(load(0x12B2DC + targetType * 14))
  raisedBest = hasDigimonRaised(load(0x12B2DC + bestDigimonType * 14))
  
  if(raisedTarget == 1 && raisedBest == 0)
    reqPoints = 0
  
  if(raisedTarget == 0 && raisedBest == 1)
    reqPoints++
  
  return reqPoints
}

0x000e26b8 addiu sp,sp,0xffb0
0x000e26bc sw ra,0x0024(sp)
0x000e26c0 sw s4,0x0020(sp)
0x000e26c4 sw s3,0x001c(sp)
0x000e26c8 sll v1,a1,0x03
0x000e26cc sw s2,0x0018(sp)
0x000e26d0 sw s1,0x0014(sp)
0x000e26d4 sw s0,0x0010(sp)
0x000e26d8 addu s3,a1,r0
0x000e26dc sub v1,v1,a1
0x000e26e0 sll a1,v1,0x02
0x000e26e4 lui v1,0x8013
0x000e26e8 addiu v1,v1,0xabec
0x000e26ec addu s1,v1,a1
0x000e26f0 lui a1,0x8015
0x000e26f4 lui v1,0x8014
0x000e26f8 lb s4,0x0060(sp)
0x000e26fc addiu a1,a1,0x57e0
0x000e2700 addiu v1,v1,0x8460
0x000e2704 bne a2,r0,0x000e2734
0x000e2708 addu s0,r0,r0
0x000e270c lh t0,0x0052(v1)
0x000e2710 lh a2,0x000e(s1)
0x000e2714 nop
0x000e2718 slt asmTemp,t0,a2
0x000e271c bne asmTemp,r0,0x000e2758
0x000e2720 nop
0x000e2724 addi a2,s0,0x0001
0x000e2728 sll s0,a2,0x18
0x000e272c beq r0,r0,0x000e2758
0x000e2730 sra s0,s0,0x18
0x000e2734 lh t0,0x0052(v1)
0x000e2738 lh a2,0x000e(s1)
0x000e273c nop
0x000e2740 slt asmTemp,a2,t0
0x000e2744 bne asmTemp,r0,0x000e2758
0x000e2748 nop
0x000e274c addi a2,s0,0x0001
0x000e2750 sll s0,a2,0x18
0x000e2754 sra s0,s0,0x18
0x000e2758 lh t0,0x0010(s1)
0x000e275c lh a2,0x0042(v1)
0x000e2760 addu t1,t0,r0
0x000e2764 addi t0,t0,-0x0005
0x000e2768 slt asmTemp,a2,t0
0x000e276c bne asmTemp,r0,0x000e2790
0x000e2770 addu t2,a2,r0
0x000e2774 addi a2,t1,0x0005
0x000e2778 slt asmTemp,a2,t2
0x000e277c bne asmTemp,r0,0x000e2790
0x000e2780 nop
0x000e2784 addi a2,s0,0x0001
0x000e2788 sll s0,a2,0x18
0x000e278c sra s0,s0,0x18
0x000e2790 sll a2,s3,0x01
0x000e2794 add a2,a2,s3
0x000e2798 sll a2,a2,0x02
0x000e279c add a2,a2,s3
0x000e27a0 sll t0,a2,0x02
0x000e27a4 lui a2,0x8013
0x000e27a8 addiu a2,a2,0xced1
0x000e27ac addu a2,a2,t0
0x000e27b0 lbu a2,0x0000(a2)
0x000e27b4 addiu asmTemp,r0,0x0003
0x000e27b8 bne a2,asmTemp,0x000e2930
0x000e27bc nop
0x000e27c0 lui a2,0x6666
0x000e27c4 lh t0,0x0010(a1)
0x000e27c8 ori t1,a2,0x6667
0x000e27cc mult t1,t0
0x000e27d0 mfhi a2
0x000e27d4 srl t0,t0,0x1f
0x000e27d8 sra a2,a2,0x02
0x000e27dc addu a2,a2,t0
0x000e27e0 sh a2,0x0038(sp)
0x000e27e4 sh a2,0x002c(sp)
0x000e27e8 lh a2,0x0012(a1)
0x000e27ec nop
0x000e27f0 mult t1,a2
0x000e27f4 srl t0,a2,0x1f
0x000e27f8 mfhi a2
0x000e27fc sra a2,a2,0x02
0x000e2800 addu a2,a2,t0
0x000e2804 sh a2,0x003a(sp)
0x000e2808 sh a2,0x002e(sp)
0x000e280c lh a2,0x0000(a1)
0x000e2810 addu t0,r0,r0
0x000e2814 sh a2,0x003c(sp)
0x000e2818 sh a2,0x0030(sp)
0x000e281c lh a2,0x0002(a1)
0x000e2820 nop
0x000e2824 sh a2,0x003e(sp)
0x000e2828 sh a2,0x0032(sp)
0x000e282c lh a2,0x0004(a1)
0x000e2830 nop
0x000e2834 sh a2,0x0040(sp)
0x000e2838 sh a2,0x0034(sp)
0x000e283c lh a1,0x0006(a1)
0x000e2840 nop
0x000e2844 sh a1,0x0042(sp)
0x000e2848 sh a1,0x0036(sp)
0x000e284c lh a1,0x0002(s1)
0x000e2850 nop
0x000e2854 sh a1,0x0044(sp)
0x000e2858 lh a1,0x0004(s1)
0x000e285c nop
0x000e2860 sh a1,0x0046(sp)
0x000e2864 lh a1,0x0006(s1)
0x000e2868 nop
0x000e286c sh a1,0x0048(sp)
0x000e2870 lh a1,0x0008(s1)
0x000e2874 nop
0x000e2878 sh a1,0x004a(sp)
0x000e287c lh a1,0x000a(s1)
0x000e2880 nop
0x000e2884 sh a1,0x004c(sp)
0x000e2888 lh a1,0x000c(s1)
0x000e288c nop
0x000e2890 sh a1,0x004e(sp)
0x000e2894 beq r0,r0,0x000e28fc
0x000e2898 addu a1,r0,r0
0x000e289c addu a2,sp,a1
0x000e28a0 lh t4,0x002c(a2)
0x000e28a4 addiu t2,r0,0x0001
0x000e28a8 addu t1,r0,r0
0x000e28ac beq r0,r0,0x000e28d8
0x000e28b0 addu t3,r0,r0
0x000e28b4 addu a2,sp,t3
0x000e28b8 lh a2,0x002c(a2)
0x000e28bc nop
0x000e28c0 slt asmTemp,t4,a2
0x000e28c4 beq asmTemp,r0,0x000e28d0
0x000e28c8 nop
0x000e28cc addu t2,r0,r0
0x000e28d0 addi t1,t1,0x0001
0x000e28d4 addi t3,t3,0x0002
0x000e28d8 slti asmTemp,t1,0x0006
0x000e28dc bne asmTemp,r0,0x000e28b4
0x000e28e0 nop
0x000e28e4 addiu asmTemp,r0,0x0001
0x000e28e8 bne t2,asmTemp,0x000e28f4
0x000e28ec nop
0x000e28f0 addu v0,t0,r0
0x000e28f4 addi t0,t0,0x0001
0x000e28f8 addi a1,a1,0x0002
0x000e28fc slti asmTemp,t0,0x0006
0x000e2900 bne asmTemp,r0,0x000e289c
0x000e2904 nop
0x000e2908 sll v0,v0,0x01
0x000e290c addu v0,sp,v0
0x000e2910 lh v0,0x0044(v0)
0x000e2914 addiu asmTemp,r0,0x0001
0x000e2918 bne v0,asmTemp,0x000e29f8
0x000e291c nop
0x000e2920 addi v0,s0,0x0001
0x000e2924 sll s0,v0,0x18
0x000e2928 beq r0,r0,0x000e29f8
0x000e292c sra s0,s0,0x18
0x000e2930 lh v0,0x0010(a1)
0x000e2934 lui t2,0x6666
0x000e2938 ori t1,t2,0x6667
0x000e293c mult t1,v0
0x000e2940 srl t0,v0,0x1f
0x000e2944 mfhi v0
0x000e2948 sra a2,v0,0x02
0x000e294c lh v0,0x0002(s1)
0x000e2950 addu a2,a2,t0
0x000e2954 slt asmTemp,a2,v0
0x000e2958 bne asmTemp,r0,0x000e29f8
0x000e295c nop
0x000e2960 lh v0,0x0012(a1)
0x000e2964 nop
0x000e2968 mult t1,v0
0x000e296c srl t0,v0,0x1f
0x000e2970 mfhi v0
0x000e2974 sra a2,v0,0x02
0x000e2978 lh v0,0x0004(s1)
0x000e297c addu a2,a2,t0
0x000e2980 slt asmTemp,a2,v0
0x000e2984 bne asmTemp,r0,0x000e29f8
0x000e2988 nop
0x000e298c lh a2,0x0000(a1)
0x000e2990 lh v0,0x0006(s1)
0x000e2994 nop
0x000e2998 slt asmTemp,a2,v0
0x000e299c bne asmTemp,r0,0x000e29f8
0x000e29a0 nop
0x000e29a4 lh a2,0x0002(a1)
0x000e29a8 lh v0,0x0008(s1)
0x000e29ac nop
0x000e29b0 slt asmTemp,a2,v0
0x000e29b4 bne asmTemp,r0,0x000e29f8
0x000e29b8 nop
0x000e29bc lh a2,0x0004(a1)
0x000e29c0 lh v0,0x000a(s1)
0x000e29c4 nop
0x000e29c8 slt asmTemp,a2,v0
0x000e29cc bne asmTemp,r0,0x000e29f8
0x000e29d0 nop
0x000e29d4 lh a1,0x0006(a1)
0x000e29d8 lh v0,0x000c(s1)
0x000e29dc nop
0x000e29e0 slt asmTemp,a1,v0
0x000e29e4 bne asmTemp,r0,0x000e29f8
0x000e29e8 nop
0x000e29ec addi v0,s0,0x0001
0x000e29f0 sll s0,v0,0x18
0x000e29f4 sra s0,s0,0x18
0x000e29f8 lh v0,0x0000(s1)
0x000e29fc addu s2,r0,r0
0x000e2a00 addiu asmTemp,r0,0xffff
0x000e2a04 beq v0,asmTemp,0x000e2a18
0x000e2a08 addu a1,v0,r0
0x000e2a0c bne a0,a1,0x000e2a18
0x000e2a10 nop
0x000e2a14 addiu s2,r0,0x0001
0x000e2a18 lh v0,0x0012(s1)
0x000e2a1c addiu asmTemp,r0,0xffff
0x000e2a20 beq v0,asmTemp,0x000e2a40
0x000e2a24 addu a0,v0,r0
0x000e2a28 lh v0,0x0028(v1)
0x000e2a2c nop
0x000e2a30 slt asmTemp,v0,a0
0x000e2a34 bne asmTemp,r0,0x000e2a40
0x000e2a38 nop
0x000e2a3c addiu s2,r0,0x0001
0x000e2a40 lh v0,0x0014(s1)
0x000e2a44 addiu asmTemp,r0,0xffff
0x000e2a48 beq v0,asmTemp,0x000e2a68
0x000e2a4c addu a0,v0,r0
0x000e2a50 lh v0,0x002a(v1)
0x000e2a54 nop
0x000e2a58 slt asmTemp,v0,a0
0x000e2a5c bne asmTemp,r0,0x000e2a68
0x000e2a60 nop
0x000e2a64 addiu s2,r0,0x0001
0x000e2a68 lh v0,0x0016(s1)
0x000e2a6c addiu asmTemp,r0,0xffff
0x000e2a70 beq v0,asmTemp,0x000e2ab4
0x000e2a74 addu a0,v0,r0
0x000e2a78 bne a3,r0,0x000e2a9c
0x000e2a7c nop
0x000e2a80 lh v0,0x0054(v1)
0x000e2a84 nop
0x000e2a88 slt asmTemp,v0,a0
0x000e2a8c bne asmTemp,r0,0x000e2ab4
0x000e2a90 nop
0x000e2a94 beq r0,r0,0x000e2ab4
0x000e2a98 addiu s2,r0,0x0001
0x000e2a9c lh v0,0x0054(v1)
0x000e2aa0 nop
0x000e2aa4 slt asmTemp,a0,v0
0x000e2aa8 bne asmTemp,r0,0x000e2ab4
0x000e2aac nop
0x000e2ab0 addiu s2,r0,0x0001
0x000e2ab4 lh v0,0x0018(s1)
0x000e2ab8 addiu asmTemp,r0,0xffff
0x000e2abc beq v0,asmTemp,0x000e2ae8
0x000e2ac0 nop
0x000e2ac4 jal 0x000e3510
0x000e2ac8 nop
0x000e2acc sll v1,v0,0x18
0x000e2ad0 lh v0,0x0018(s1)
0x000e2ad4 sra v1,v1,0x18
0x000e2ad8 slt asmTemp,v1,v0
0x000e2adc bne asmTemp,r0,0x000e2ae8
0x000e2ae0 nop
0x000e2ae4 addiu s2,r0,0x0001
0x000e2ae8 add v0,s0,s2
0x000e2aec sll s0,v0,0x18
0x000e2af0 sra s0,s0,0x18
0x000e2af4 slti asmTemp,s0,0x0003
0x000e2af8 bne asmTemp,r0,0x000e2b90
0x000e2afc nop
0x000e2b00 addiu asmTemp,r0,0xffff
0x000e2b04 beq s4,asmTemp,0x000e2b90
0x000e2b08 nop
0x000e2b0c sll v0,s3,0x03
0x000e2b10 sub v0,v0,s3
0x000e2b14 sll v1,v0,0x01
0x000e2b18 lui v0,0x8013
0x000e2b1c addiu v0,v0,0xb2d0
0x000e2b20 addu v0,v0,v1
0x000e2b24 lh a0,0x000c(v0)
0x000e2b28 jal 0x000ff824
0x000e2b2c nop
0x000e2b30 addu s1,v0,r0
0x000e2b34 sll v0,s4,0x03
0x000e2b38 sub v0,v0,s4
0x000e2b3c sll v1,v0,0x01
0x000e2b40 lui v0,0x8013
0x000e2b44 addiu v0,v0,0xb2d0
0x000e2b48 addu v0,v0,v1
0x000e2b4c lh a0,0x000c(v0)
0x000e2b50 jal 0x000ff824
0x000e2b54 nop
0x000e2b58 addiu asmTemp,r0,0x0001
0x000e2b5c bne s1,asmTemp,0x000e2b70
0x000e2b60 nop
0x000e2b64 bne v0,r0,0x000e2b70
0x000e2b68 nop
0x000e2b6c addu s0,r0,r0
0x000e2b70 bne s1,r0,0x000e2b90
0x000e2b74 nop
0x000e2b78 addiu asmTemp,r0,0x0001
0x000e2b7c bne v0,asmTemp,0x000e2b90
0x000e2b80 nop
0x000e2b84 addi v0,s0,0x0001
0x000e2b88 sll s0,v0,0x18
0x000e2b8c sra s0,s0,0x18
0x000e2b90 addu v0,s0,r0
0x000e2b94 lw ra,0x0024(sp)
0x000e2b98 lw s4,0x0020(sp)
0x000e2b9c lw s3,0x001c(sp)
0x000e2ba0 lw s2,0x0018(sp)
0x000e2ba4 lw s1,0x0014(sp)
0x000e2ba8 lw s0,0x0010(sp)
0x000e2bac jr ra
0x000e2bb0 addiu sp,sp,0x0050