void handleBrainsTraining(digimonType, mode, multiplier) {
    oldBrains = load(0x1557E6) // brains

    brainsGains = 0
    mpGains = 0
    energyCost = 0
    tiredness = 0
    happinessCost = 0

    digimonType = digimonType
    mode = mode

    if(mode == 9) {
        brainsGains = 15
        mpGains = 0

        energyCost = 1
        tiredness = 6
        happinessCost = 1
    }
    else if(mode == 0) {
        brainsGains = 8
        mpGains = 10

        energyCost = 1
        tiredness = 6
        happinessCost = 1
    }

    trainingFactor = getTrainingFactor(digimonType, 1, mode)

    boostFlag = load(0x1384AC) 
    boostFactor = load(0x1384AE)

    if(boostFlag & 0x20 != 0) // MP boost flag
        mpGains = mpGains * trainingFactor * boostFactor / 100
    else 
        mpGains = mpGains * trainingFactor / 10
    
    if(boostFlag & 0x08 != 0) // Brains boost flag
        brainsGains = brainsGains * trainingFactor * boostFactor / 100
    else {
        brainsGains = brainsGains * trainingFactor / 10
    }

    mpGains = mpGains * multiplier / 10
    brainsGains = brainsGains * multiplier / 10

    if(load(0x138482) == 100) { // tiredness
        if(mode == 0)
            mpGains = 1
        
        brainsGains = 1
    }

    if(mpGains >= 1000)
        mpGains = 999
    if(brainsGains >= 1000)
        brainsGains = 999

    storeTrainingStats()

    store(0x13D468, 0)
    store(0x13D46A, mpGains)
    store(0x13D46C, 0)
    store(0x13D46E, 0)
    store(0x13D470, 0)
    store(0x13D472, brainsGains)

    renderTrainingResult()

    handleTrainingTimeSkip(tiredness, energyCost, happinessCost)

    newBrains = oldBrains + brainsGains
    commandLearned = 0
    lastLineYOffset = 132

    if(oldBrains < 100 && newBrains > 100) {
        setTextColor(7)
        renderString(0x8F0D8, 0, 120) // "Give it all you got!"
        commandLearned = 1
    }
    if(oldBrains < 200 && newBrains > 200) {
        setTextColor(7)
        renderString(0x8F0F0, 0, 120) // "Take it easy!"
        commandLearned = 1
    }
    if(oldBrains < 300 && newBrains > 300) {
        setTextColor(7)
        renderString(0x8F100, 0, 120) // "Get back!"
        renderString(0x8F10C, 0, 132) // "Change target!"
        lastLineYOffset = 148
        commandLearned = 1
    }
    if(oldBrains < 400 && newBrains > 400) {
        setTextColor(7)
        renderString(0x8F11C, 0, 120) // "Hang in there!"
        commandLearned = 1
    }
    if(oldBrains < 500 && newBrains > 500) {
        setTextColor(7)
        renderString(0x8F12C, 0, 120) // "Technique mastered"
        commandLearned = 1
    }

    if(commandLearned == 1) {
        setTextColor(1)
        renderString(0x8F140, 0, lastLineYOffset) // "New orders!"

        0x000B8E50(2, -88, 18, 176, 48, 2, 0, 0x8A6F8)
        store(0x135388, 1)
        return
    }

    if(oldBrains < 150 && newBrains > 150
    || oldBrains < 250 && newBrains > 250
    || oldBrains < 350 && newBrains > 350
    || oldBrains < 450 && newBrains > 450
    || oldBrains < 550 && newBrains > 550
    || oldBrains < 650 && newBrains > 650
    || oldBrains < 750 && newBrains > 750
    || oldBrains < 800 && newBrains > 800
    || oldBrains < 850 && newBrains > 850
    || oldBrains < 900 && newBrains > 900
    || oldBrains < 950 && newBrains > 950
    || newBrains == 999)
        handleBrainMoveLearnChance(digimonType)
}

0x000897f8 addiu sp,sp,0xffb8
0x000897fc sw ra,0x0044(sp)
0x00089800 sw fp,0x0040(sp)
0x00089804 sw s7,0x003c(sp)
0x00089808 sw s6,0x0038(sp)
0x0008980c sw s5,0x0034(sp)
0x00089810 sw s4,0x0030(sp)
0x00089814 sw s3,0x002c(sp)
0x00089818 sw s2,0x0028(sp)
0x0008981c sw s1,0x0024(sp)
0x00089820 lui asmTemp,0x8015
0x00089824 lh s2,0x57e6(asmTemp)
0x00089828 sw s0,0x0020(sp)
0x0008982c sll s1,r0,0x10
0x00089830 sll s3,r0,0x10
0x00089834 sll s4,r0,0x10
0x00089838 addu fp,a0,r0
0x0008983c addu s6,a1,r0
0x00089840 addu s7,a2,r0
0x00089844 sw r0,-0x67a4(gp)
0x00089848 addu s0,r0,r0
0x0008984c sra s1,s1,0x10
0x00089850 addu s5,r0,r0
0x00089854 sra s3,s3,0x10
0x00089858 addiu asmTemp,r0,0x0009
0x0008985c beq s6,asmTemp,0x000898a8
0x00089860 sra s4,s4,0x10
0x00089864 bne s6,r0,0x000898d4
0x00089868 nop
0x0008986c addiu v0,r0,0x000a
0x00089870 sll s1,v0,0x10
0x00089874 addiu v0,r0,0x0008
0x00089878 sll s0,v0,0x10
0x0008987c addiu v0,r0,0x0006
0x00089880 sll s4,v0,0x10
0x00089884 addiu v0,r0,0x0001
0x00089888 sll s3,v0,0x10
0x0008988c sll s5,v0,0x10
0x00089890 sra s1,s1,0x10
0x00089894 sra s0,s0,0x10
0x00089898 sra s4,s4,0x10
0x0008989c sra s3,s3,0x10
0x000898a0 beq r0,r0,0x000898d4
0x000898a4 sra s5,s5,0x10
0x000898a8 addiu v0,r0,0x000f
0x000898ac sll s0,v0,0x10
0x000898b0 addiu v0,r0,0x0006
0x000898b4 sll s4,v0,0x10
0x000898b8 addiu v0,r0,0x0001
0x000898bc sll s3,v0,0x10
0x000898c0 sll s5,v0,0x10
0x000898c4 sra s0,s0,0x10
0x000898c8 sra s4,s4,0x10
0x000898cc sra s3,s3,0x10
0x000898d0 sra s5,s5,0x10
0x000898d4 addu a0,fp,r0
0x000898d8 addiu a1,r0,0x0001
0x000898dc jal 0x00089e08
0x000898e0 addu a2,s6,r0
0x000898e4 lui asmTemp,0x8014
0x000898e8 lh a0,-0x7b54(asmTemp)
0x000898ec sll v0,v0,0x10
0x000898f0 addu v1,a0,r0
0x000898f4 andi a0,a0,0x0020
0x000898f8 beq a0,r0,0x00089950
0x000898fc sra v0,v0,0x10
0x00089900 lui asmTemp,0x8014
0x00089904 lh a0,-0x7b52(asmTemp)
0x00089908 nop
0x0008990c mult v0,a0
0x00089910 mflo a0
0x00089914 nop
0x00089918 nop
0x0008991c mult s1,a0
0x00089920 lui a0,0x51eb
0x00089924 mflo a1
0x00089928 ori a0,a0,0x851f
0x0008992c nop
0x00089930 mult a0,a1
0x00089934 mfhi a0
0x00089938 srl a1,a1,0x1f
0x0008993c sra a0,a0,0x05
0x00089940 addu a0,a0,a1
0x00089944 sll s1,a0,0x10
0x00089948 beq r0,r0,0x00089980
0x0008994c sra s1,s1,0x10
0x00089950 mult s1,v0
0x00089954 lui a0,0x6666
0x00089958 mflo a1
0x0008995c ori a0,a0,0x6667
0x00089960 nop
0x00089964 mult a0,a1
0x00089968 mfhi a0
0x0008996c srl a1,a1,0x1f
0x00089970 sra a0,a0,0x02
0x00089974 addu a0,a0,a1
0x00089978 sll s1,a0,0x10
0x0008997c sra s1,s1,0x10
0x00089980 andi v1,v1,0x0008
0x00089984 beq v1,r0,0x000899dc
0x00089988 nop
0x0008998c lui asmTemp,0x8014
0x00089990 lh v1,-0x7b52(asmTemp)
0x00089994 nop
0x00089998 mult v0,v1
0x0008999c mflo v0
0x000899a0 nop
0x000899a4 nop
0x000899a8 mult s0,v0
0x000899ac lui v0,0x51eb
0x000899b0 mflo v1
0x000899b4 ori v0,v0,0x851f
0x000899b8 nop
0x000899bc mult v0,v1
0x000899c0 mfhi v0
0x000899c4 srl v1,v1,0x1f
0x000899c8 sra v0,v0,0x05
0x000899cc addu v0,v0,v1
0x000899d0 sll s0,v0,0x10
0x000899d4 beq r0,r0,0x00089a0c
0x000899d8 sra s0,s0,0x10
0x000899dc mult s0,v0
0x000899e0 lui v0,0x6666
0x000899e4 mflo v1
0x000899e8 ori v0,v0,0x6667
0x000899ec nop
0x000899f0 mult v0,v1
0x000899f4 mfhi v0
0x000899f8 srl v1,v1,0x1f
0x000899fc sra v0,v0,0x02
0x00089a00 addu v0,v0,v1
0x00089a04 sll s0,v0,0x10
0x00089a08 sra s0,s0,0x10
0x00089a0c mult s1,s7
0x00089a10 lui v0,0x6666
0x00089a14 mflo v1
0x00089a18 ori a0,v0,0x6667
0x00089a1c nop
0x00089a20 mult a0,v1
0x00089a24 lui asmTemp,0x8014
0x00089a28 mfhi v0
0x00089a2c srl v1,v1,0x1f
0x00089a30 sra v0,v0,0x02
0x00089a34 addu v0,v0,v1
0x00089a38 sll s1,v0,0x10
0x00089a3c mult s0,s7
0x00089a40 sra s1,s1,0x10
0x00089a44 mflo v0
0x00089a48 nop
0x00089a4c nop
0x00089a50 mult a0,v0
0x00089a54 srl v1,v0,0x1f
0x00089a58 mfhi v0
0x00089a5c sra v0,v0,0x02
0x00089a60 addu v0,v0,v1
0x00089a64 sll s0,v0,0x10
0x00089a68 lh v0,-0x7b7e(asmTemp)
0x00089a6c addiu asmTemp,r0,0x0064
0x00089a70 bne v0,asmTemp,0x00089a98
0x00089a74 sra s0,s0,0x10
0x00089a78 bne s6,r0,0x00089a8c
0x00089a7c nop
0x00089a80 addiu v0,r0,0x0001
0x00089a84 sll s1,v0,0x10
0x00089a88 sra s1,s1,0x10
0x00089a8c addiu v0,r0,0x0001
0x00089a90 sll s0,v0,0x10
0x00089a94 sra s0,s0,0x10
0x00089a98 slti asmTemp,s1,0x03e8
0x00089a9c bne asmTemp,r0,0x00089ab0
0x00089aa0 nop
0x00089aa4 addiu v0,r0,0x03e7
0x00089aa8 sll s1,v0,0x10
0x00089aac sra s1,s1,0x10
0x00089ab0 slti asmTemp,s0,0x03e8
0x00089ab4 bne asmTemp,r0,0x00089ac8
0x00089ab8 nop
0x00089abc addiu v0,r0,0x03e7
0x00089ac0 sll s0,v0,0x10
0x00089ac4 sra s0,s0,0x10
0x00089ac8 jal 0x0008d4cc
0x00089acc nop
0x00089ad0 lui asmTemp,0x8014
0x00089ad4 sh r0,-0x2b98(asmTemp)
0x00089ad8 lui asmTemp,0x8014
0x00089adc sh s1,-0x2b96(asmTemp)
0x00089ae0 lui asmTemp,0x8014
0x00089ae4 sh r0,-0x2b94(asmTemp)
0x00089ae8 lui asmTemp,0x8014
0x00089aec sh r0,-0x2b92(asmTemp)
0x00089af0 lui asmTemp,0x8014
0x00089af4 sh r0,-0x2b90(asmTemp)
0x00089af8 lui asmTemp,0x8014
0x00089afc sh s0,-0x2b8e(asmTemp)
0x00089b00 jal 0x0008d594
0x00089b04 nop
0x00089b08 addu a0,s4,r0
0x00089b0c addu a1,s3,r0
0x00089b10 jal 0x0008a284
0x00089b14 addu a2,s5,r0
0x00089b18 add v0,s2,s0
0x00089b1c sll s0,v0,0x10
0x00089b20 sra s0,s0,0x10
0x00089b24 addu v0,r0,r0
0x00089b28 slti asmTemp,s2,0x0064
0x00089b2c beq asmTemp,r0,0x00089b60
0x00089b30 addiu s1,r0,0x0084
0x00089b34 slti asmTemp,s0,0x0064
0x00089b38 bne asmTemp,r0,0x00089b60
0x00089b3c nop
0x00089b40 jal 0x0010cc0c
0x00089b44 addiu a0,r0,0x0007
0x00089b48 lui a0,0x8009
0x00089b4c addiu a0,a0,0xf0d8
0x00089b50 addu a1,r0,r0
0x00089b54 jal 0x0010cf24
0x00089b58 addiu a2,r0,0x0078
0x00089b5c addiu v0,r0,0x0001
0x00089b60 slti asmTemp,s2,0x00c8
0x00089b64 beq asmTemp,r0,0x00089b98
0x00089b68 nop
0x00089b6c slti asmTemp,s0,0x00c8
0x00089b70 bne asmTemp,r0,0x00089b98
0x00089b74 nop
0x00089b78 jal 0x0010cc0c
0x00089b7c addiu a0,r0,0x0007
0x00089b80 lui a0,0x8009
0x00089b84 addiu a0,a0,0xf0f0
0x00089b88 addu a1,r0,r0
0x00089b8c jal 0x0010cf24
0x00089b90 addiu a2,r0,0x0078
0x00089b94 addiu v0,r0,0x0001
0x00089b98 slti asmTemp,s2,0x012c
0x00089b9c beq asmTemp,r0,0x00089be8
0x00089ba0 nop
0x00089ba4 slti asmTemp,s0,0x012c
0x00089ba8 bne asmTemp,r0,0x00089be8
0x00089bac nop
0x00089bb0 jal 0x0010cc0c
0x00089bb4 addiu a0,r0,0x0007
0x00089bb8 lui a0,0x8009
0x00089bbc addiu a0,a0,0xf100
0x00089bc0 addu a1,r0,r0
0x00089bc4 jal 0x0010cf24
0x00089bc8 addiu a2,r0,0x0078
0x00089bcc lui a0,0x8009
0x00089bd0 addiu a0,a0,0xf10c
0x00089bd4 addu a1,r0,r0
0x00089bd8 jal 0x0010cf24
0x00089bdc addiu a2,r0,0x0084
0x00089be0 addiu v0,r0,0x0001
0x00089be4 addiu s1,r0,0x0094
0x00089be8 slti asmTemp,s2,0x0190
0x00089bec beq asmTemp,r0,0x00089c20
0x00089bf0 nop
0x00089bf4 slti asmTemp,s0,0x0190
0x00089bf8 bne asmTemp,r0,0x00089c20
0x00089bfc nop
0x00089c00 jal 0x0010cc0c
0x00089c04 addiu a0,r0,0x0007
0x00089c08 lui a0,0x8009
0x00089c0c addiu a0,a0,0xf11c
0x00089c10 addu a1,r0,r0
0x00089c14 jal 0x0010cf24
0x00089c18 addiu a2,r0,0x0078
0x00089c1c addiu v0,r0,0x0001
0x00089c20 slti asmTemp,s2,0x01f4
0x00089c24 beq asmTemp,r0,0x00089c58
0x00089c28 nop
0x00089c2c slti asmTemp,s0,0x01f4
0x00089c30 bne asmTemp,r0,0x00089c58
0x00089c34 nop
0x00089c38 jal 0x0010cc0c
0x00089c3c addiu a0,r0,0x0007
0x00089c40 lui a0,0x8009
0x00089c44 addiu a0,a0,0xf12c
0x00089c48 addu a1,r0,r0
0x00089c4c jal 0x0010cf24
0x00089c50 addiu a2,r0,0x0078
0x00089c54 addiu v0,r0,0x0001
0x00089c58 addiu asmTemp,r0,0x0001
0x00089c5c bne v0,asmTemp,0x00089cbc
0x00089c60 nop
0x00089c64 jal 0x0010cc0c
0x00089c68 addiu a0,r0,0x0001
0x00089c6c lui a0,0x8009
0x00089c70 addiu a0,a0,0xf140
0x00089c74 addu a1,r0,r0
0x00089c78 jal 0x0010cf24
0x00089c7c addu a2,s1,r0
0x00089c80 addiu v0,r0,0x0030
0x00089c84 sw v0,0x0010(sp)
0x00089c88 addiu a0,r0,0x0002
0x00089c8c sw a0,0x0014(sp)
0x00089c90 lui v0,0x8009
0x00089c94 sw r0,0x0018(sp)
0x00089c98 addiu v0,v0,0xa6f8
0x00089c9c sw v0,0x001c(sp)
0x00089ca0 addiu a1,r0,0xffa8
0x00089ca4 addiu a2,r0,0x0012
0x00089ca8 jal 0x000b8e50
0x00089cac addiu a3,r0,0x00b0
0x00089cb0 addiu v0,r0,0x0001
0x00089cb4 beq r0,r0,0x00089dd8
0x00089cb8 sw v0,-0x67a4(gp)
0x00089cbc slti asmTemp,s2,0x0096
0x00089cc0 beq asmTemp,r0,0x00089cd4
0x00089cc4 nop
0x00089cc8 slti asmTemp,s0,0x0096
0x00089ccc beq asmTemp,r0,0x00089dd0
0x00089cd0 nop
0x00089cd4 slti asmTemp,s2,0x00fa
0x00089cd8 beq asmTemp,r0,0x00089cec
0x00089cdc nop
0x00089ce0 slti asmTemp,s0,0x00fa
0x00089ce4 beq asmTemp,r0,0x00089dd0
0x00089ce8 nop
0x00089cec slti asmTemp,s2,0x015e
0x00089cf0 beq asmTemp,r0,0x00089d04
0x00089cf4 nop
0x00089cf8 slti asmTemp,s0,0x015e
0x00089cfc beq asmTemp,r0,0x00089dd0
0x00089d00 nop
0x00089d04 slti asmTemp,s2,0x01c2
0x00089d08 beq asmTemp,r0,0x00089d1c
0x00089d0c nop
0x00089d10 slti asmTemp,s0,0x01c2
0x00089d14 beq asmTemp,r0,0x00089dd0
0x00089d18 nop
0x00089d1c slti asmTemp,s2,0x0226
0x00089d20 beq asmTemp,r0,0x00089d34
0x00089d24 nop
0x00089d28 slti asmTemp,s0,0x0226
0x00089d2c beq asmTemp,r0,0x00089dd0
0x00089d30 nop
0x00089d34 slti asmTemp,s2,0x028a
0x00089d38 beq asmTemp,r0,0x00089d4c
0x00089d3c nop
0x00089d40 slti asmTemp,s0,0x028a
0x00089d44 beq asmTemp,r0,0x00089dd0
0x00089d48 nop
0x00089d4c slti asmTemp,s2,0x02ee
0x00089d50 beq asmTemp,r0,0x00089d64
0x00089d54 nop
0x00089d58 slti asmTemp,s0,0x02ee
0x00089d5c beq asmTemp,r0,0x00089dd0
0x00089d60 nop
0x00089d64 slti asmTemp,s2,0x0320
0x00089d68 beq asmTemp,r0,0x00089d7c
0x00089d6c nop
0x00089d70 slti asmTemp,s0,0x0320
0x00089d74 beq asmTemp,r0,0x00089dd0
0x00089d78 nop
0x00089d7c slti asmTemp,s2,0x0352
0x00089d80 beq asmTemp,r0,0x00089d94
0x00089d84 nop
0x00089d88 slti asmTemp,s0,0x0352
0x00089d8c beq asmTemp,r0,0x00089dd0
0x00089d90 nop
0x00089d94 slti asmTemp,s2,0x0384
0x00089d98 beq asmTemp,r0,0x00089dac
0x00089d9c nop
0x00089da0 slti asmTemp,s0,0x0384
0x00089da4 beq asmTemp,r0,0x00089dd0
0x00089da8 nop
0x00089dac slti asmTemp,s2,0x03b6
0x00089db0 beq asmTemp,r0,0x00089dc4
0x00089db4 nop
0x00089db8 slti asmTemp,s0,0x03b6
0x00089dbc beq asmTemp,r0,0x00089dd0
0x00089dc0 nop
0x00089dc4 addiu asmTemp,r0,0x03e7
0x00089dc8 bne s0,asmTemp,0x00089dd8
0x00089dcc nop
0x00089dd0 jal 0x0008a744
0x00089dd4 addu a0,fp,r0
0x00089dd8 lw ra,0x0044(sp)
0x00089ddc lw fp,0x0040(sp)
0x00089de0 lw s7,0x003c(sp)
0x00089de4 lw s6,0x0038(sp)
0x00089de8 lw s5,0x0034(sp)
0x00089dec lw s4,0x0030(sp)
0x00089df0 lw s3,0x002c(sp)
0x00089df4 lw s2,0x0028(sp)
0x00089df8 lw s1,0x0024(sp)
0x00089dfc lw s0,0x0020(sp)
0x00089e00 jr ra
0x00089e04 addiu sp,sp,0x0048