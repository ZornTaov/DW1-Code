void tickSleepMechanics() {
  currentFrame = load(0x134F08)
  lastHandledFrame = load(0x134F06)
  currentHour = load(0x134EBC)
  isSleepy = load(0x138460) & 1 // is sleepy
  partnerType = load(0x1557A8)
  partnerLevel = load(0x12CED1 + partnerType * 52)
  
  // handle tiredness sleep timer
  if(currentFrame % 20 == 0 && currentFrame != lastHandledFrame) {
    tiredness = load(0x138482) // tiredness
    store(0x138476, load(0x138476) + (tiredness * 3) / 10) // tiredness sleep timer
  }
  
  // handle tiredness sleep time increase
  if(isSleepy == 0 && load(0x138476) >= 180 && currentFrame % 200 == 0 && currentFrame != lastHandledFrame) {
    store(0x138470, load(0x138470) - 1) // awake time this day
    store(0x138476, 0) // tiredness sleep timer
    
    standardAwakeTime = load(0x13846C) * 6 // standard awake time
    currentAwakeTime = load(0x138470) // awake time this day
    
    awakeDiff = standardAwakeTime - currentAwakeTime
    awakeDiffHours = awakeDiff / 6
    
    if(awakeDiff % 6 != 0)
      awakeDiffHours++
    
    newSleepyHour = load(0x138468) - load(0x13846E) // wakeup hour - standard sleep time
    newSleepyHour = newSleepyHour - awakeDiffHours
    newSleepyHour = newSleepyHour < 0 ? newSleepyHour - 24 : newSleepyHour
    
    store(0x138464, newSleepyHour) // sleepy hour
    store(0x138466, currentAwakeTime % 6 * 10) // sleepy minute
  }
  
  // handle negative effects of staying up too long
  if(isSleepy != 0 && currentFrame != lastHandledFrame) {
    if(partnerLevel == 1 && currentFrame % 200 == 0) {
      store(0x13848A, load(0x13848A) - 1) // happiness
      store(0x138488, load(0x138488) - 1) // discipline
    }
    else if(partnerLevel == 2 && currentFrame % 300 == 0)) {
      store(0x13848A, load(0x13848A) - 1) // happiness
      store(0x138488, load(0x138488) - 1) // discipline
    }
    else if(currentFrame % 1200 == 0) {
      store(0x13848A, load(0x13848A) - 2) // happiness
      store(0x138488, load(0x138488) - 4) // discipline
    }
    
    if(currentFrame % 1200 == 0 && currentHour != load(0x138464)) { // sleepy hour
      store(0x138472, load(0x138472) + 1) // sickness counter
      store(0x138474, load(0x138474) + 1) // missed sleep hours counter
    }
  }
  
  // handle staying awake a night, i.e. updating sleep times and adding a care mistake
  if(isSleepy != 0) {
    sleepyHour = load(0x138464)
    wakeupHour = load(0x138468)
    
    if((sleepyHour < wakeupHour && sleepyHour < currentHour && currentHour < wakeupHour)
    || (wakeupHour < sleepyHour && currentHour < sleepyHour && currentHour < wakeupHour)) {
      
      if(partnerLevel < 3) {
        newSleepyHour = load(0x13846C) + wakeupHour
        newSleepyHour = newSleepyHour >= 24 ? newSleepyHour - 24 : newSleepyHour
        
        store(0x138464, newSleepyHour)
        store(0x138466, 0) // sleepy Minute
        
        newWakeupHour = newSleepyHour + load(0x13846E) // standard sleep time
        newWakeupHour = newWakeupHour >= 24 ? newWakeupHour - 24 : newWakeupHour
        
        store(0x138468, newWakeupHour)
        store(0x13846A, 0)
      }
      else {
        sleepCycle = load(0x1225CE + partnerType * 28) // sleep cycle
        
        store(0x138464, load(0x122CF4 + sleepCycle * 6)) // sleepy hour 
        store(0x138466, load(0x122CF5 + sleepCycle * 6)) // sleepy minute
        store(0x138468, load(0x122CF6 + sleepCycle * 6)) // wakeup hour
        store(0x13846A, load(0x122CF7 + sleepCycle * 6)) // wakeup minute
      }
      
      store(0x138470, load(0x13846C) * 6) // awake time this day
      store(0x138476, 0) // tiredness sleep counter
      
      store(0x138460, load(0x138460) & 0xFFFE) // reset sleepy flag
      store(0x1384B2, load(0x1384B2) + 1) // add care mistake
      
      setConditionAnimation()
      addTamerLevel(1, -1) // 1% chance of losing a tamer level
    }
  }
  
  // set sleepy flag
  if(isSleepy == 0) {
    wakeupHour = load(0x138468)
    sleepyHour = load(0x138464)
    
    if(wakeupHour < sleepyHour) {
      if(currentHour >= sleepyHour || currentHour < wakeupHour)
        store(0x138460, load(0x138460) | 1)
    }
    else if(sleepyHour < wakeupHour) {
      if(currentHour >= sleepyHour && currentHour < wakeupHour)
        store(0x138460, load(0x138460) | 1)
    }
  }
  
  if(load(0x138460) & 1 != 0) // is still sleepy
    store(0x123ED6, 0) // deferred via 0x000BA40C(0)
  else
    store(0x123ED6, 1) // deferred via 0x000BA40C(1)
}

0x000a5804 lhu v1,-0x6c24(gp)
0x000a5808 addiu sp,sp,0xffe8
0x000a580c lui asmTemp,0x8014
0x000a5810 sw ra,0x0014(sp)
0x000a5814 lw v0,-0x7ba0(asmTemp)
0x000a5818 sw s0,0x0010(sp)
0x000a581c andi s0,v0,0x0001
0x000a5820 addiu v0,r0,0x0014
0x000a5824 div v1,v0
0x000a5828 addu a0,v1,r0
0x000a582c mfhi v0
0x000a5830 bne v0,r0,0x000a5894
0x000a5834 addu a1,v1,r0
0x000a5838 lhu v0,-0x6c26(gp)
0x000a583c nop
0x000a5840 beq a0,v0,0x000a5894
0x000a5844 nop
0x000a5848 lui asmTemp,0x8014
0x000a584c lh v1,-0x7b7e(asmTemp)
0x000a5850 nop
0x000a5854 sll v0,v1,0x01
0x000a5858 add v1,v0,v1
0x000a585c lui v0,0x6666
0x000a5860 ori v0,v0,0x6667
0x000a5864 mult v0,v1
0x000a5868 lui asmTemp,0x8014
0x000a586c mfhi v0
0x000a5870 srl v1,v1,0x1f
0x000a5874 sra v0,v0,0x02
0x000a5878 addu v1,v0,v1
0x000a587c lh v0,-0x7b8a(asmTemp)
0x000a5880 sll v1,v1,0x10
0x000a5884 sra v1,v1,0x10
0x000a5888 add v0,v0,v1
0x000a588c lui asmTemp,0x8014
0x000a5890 sh v0,-0x7b8a(asmTemp)
0x000a5894 bne s0,r0,0x000a59c8
0x000a5898 nop
0x000a589c lui asmTemp,0x8014
0x000a58a0 lh v0,-0x7b8a(asmTemp)
0x000a58a4 nop
0x000a58a8 slti asmTemp,v0,0x00b4
0x000a58ac bne asmTemp,r0,0x000a59c8
0x000a58b0 nop
0x000a58b4 addiu v0,r0,0x00c8
0x000a58b8 div a1,v0
0x000a58bc mfhi v0
0x000a58c0 bne v0,r0,0x000a59c8
0x000a58c4 nop
0x000a58c8 lhu v0,-0x6c26(gp)
0x000a58cc nop
0x000a58d0 beq a0,v0,0x000a59c8
0x000a58d4 nop
0x000a58d8 lui asmTemp,0x8014
0x000a58dc lh v0,-0x7b90(asmTemp)
0x000a58e0 nop
0x000a58e4 addi v0,v0,-0x0001
0x000a58e8 lui asmTemp,0x8014
0x000a58ec sh v0,-0x7b90(asmTemp)
0x000a58f0 lui asmTemp,0x8014
0x000a58f4 sh r0,-0x7b8a(asmTemp)
0x000a58f8 lui asmTemp,0x8014
0x000a58fc lh v1,-0x7b94(asmTemp)
0x000a5900 nop
0x000a5904 sll v0,v1,0x01
0x000a5908 add v1,v0,v1
0x000a590c lui asmTemp,0x8014
0x000a5910 lh v0,-0x7b90(asmTemp)
0x000a5914 sll v1,v1,0x01
0x000a5918 sub v1,v1,v0
0x000a591c addu t0,v0,r0
0x000a5920 lui v0,0x2aaa
0x000a5924 ori v0,v0,0xaaab
0x000a5928 mult v0,v1
0x000a592c addu a3,v1,r0
0x000a5930 srl v1,v1,0x1f
0x000a5934 mfhi v0
0x000a5938 addu v0,v0,v1
0x000a593c sll a2,v0,0x18
0x000a5940 addiu v0,r0,0x0006
0x000a5944 div a3,v0
0x000a5948 mfhi v0
0x000a594c beq v0,r0,0x000a5960
0x000a5950 sra a2,a2,0x18
0x000a5954 addi v0,a2,0x0001
0x000a5958 sll a2,v0,0x18
0x000a595c sra a2,a2,0x18
0x000a5960 addiu v0,r0,0x0006
0x000a5964 div t0,v0
0x000a5968 lui asmTemp,0x8014
0x000a596c lh v1,-0x7b98(asmTemp)
0x000a5970 mfhi v0
0x000a5974 sll a3,v0,0x18
0x000a5978 lui asmTemp,0x8014
0x000a597c lh v0,-0x7b92(asmTemp)
0x000a5980 nop
0x000a5984 sub v0,v1,v0
0x000a5988 sub v0,v0,a2
0x000a598c lui asmTemp,0x8014
0x000a5990 sh v0,-0x7b9c(asmTemp)
0x000a5994 lui asmTemp,0x8014
0x000a5998 lh v0,-0x7b9c(asmTemp)
0x000a599c nop
0x000a59a0 bgez v0,0x000a59b4
0x000a59a4 sra a3,a3,0x18
0x000a59a8 addi v0,v0,0x0018
0x000a59ac lui asmTemp,0x8014
0x000a59b0 sh v0,-0x7b9c(asmTemp)
0x000a59b4 sll v0,a3,0x02
0x000a59b8 add v0,v0,a3
0x000a59bc sll v0,v0,0x01
0x000a59c0 lui asmTemp,0x8014
0x000a59c4 sh v0,-0x7b9a(asmTemp)
0x000a59c8 lui asmTemp,0x8015
0x000a59cc lw v0,0x57a8(asmTemp)
0x000a59d0 nop
0x000a59d4 addu a2,v0,r0
0x000a59d8 sll v1,a2,0x01
0x000a59dc add v1,v1,a2
0x000a59e0 sll v1,v1,0x02
0x000a59e4 add v1,v1,a2
0x000a59e8 sll a2,v1,0x02
0x000a59ec lui v1,0x8013
0x000a59f0 addiu v1,v1,0xced1
0x000a59f4 addu v1,v1,a2
0x000a59f8 lbu v1,0x0000(v1)
0x000a59fc lui asmTemp,0x8014
0x000a5a00 lw a2,-0x7ba0(asmTemp)
0x000a5a04 sll v1,v1,0x10
0x000a5a08 andi a2,a2,0x0001
0x000a5a0c beq a2,r0,0x000a5b9c
0x000a5a10 sra v1,v1,0x10
0x000a5a14 addiu asmTemp,r0,0x0001
0x000a5a18 bne v1,asmTemp,0x000a5a78
0x000a5a1c nop
0x000a5a20 addiu a2,r0,0x00c8
0x000a5a24 div a1,a2
0x000a5a28 mfhi a2
0x000a5a2c bne a2,r0,0x000a5b30
0x000a5a30 nop
0x000a5a34 lhu a2,-0x6c26(gp)
0x000a5a38 nop
0x000a5a3c beq a0,a2,0x000a5b30
0x000a5a40 nop
0x000a5a44 lui asmTemp,0x8014
0x000a5a48 lh a2,-0x7b76(asmTemp)
0x000a5a4c nop
0x000a5a50 addi a2,a2,-0x0001
0x000a5a54 lui asmTemp,0x8014
0x000a5a58 sh a2,-0x7b76(asmTemp)
0x000a5a5c lui asmTemp,0x8014
0x000a5a60 lh a2,-0x7b78(asmTemp)
0x000a5a64 nop
0x000a5a68 addi a2,a2,-0x0001
0x000a5a6c lui asmTemp,0x8014
0x000a5a70 beq r0,r0,0x000a5b30
0x000a5a74 sh a2,-0x7b78(asmTemp)
0x000a5a78 addiu asmTemp,r0,0x0002
0x000a5a7c bne v1,asmTemp,0x000a5adc
0x000a5a80 nop
0x000a5a84 addiu a2,r0,0x012c
0x000a5a88 div a1,a2
0x000a5a8c mfhi a2
0x000a5a90 bne a2,r0,0x000a5b30
0x000a5a94 nop
0x000a5a98 lhu a2,-0x6c26(gp)
0x000a5a9c nop
0x000a5aa0 beq a0,a2,0x000a5b30
0x000a5aa4 nop
0x000a5aa8 lui asmTemp,0x8014
0x000a5aac lh a2,-0x7b76(asmTemp)
0x000a5ab0 nop
0x000a5ab4 addi a2,a2,-0x0001
0x000a5ab8 lui asmTemp,0x8014
0x000a5abc sh a2,-0x7b76(asmTemp)
0x000a5ac0 lui asmTemp,0x8014
0x000a5ac4 lh a2,-0x7b78(asmTemp)
0x000a5ac8 nop
0x000a5acc addi a2,a2,-0x0001
0x000a5ad0 lui asmTemp,0x8014
0x000a5ad4 beq r0,r0,0x000a5b30
0x000a5ad8 sh a2,-0x7b78(asmTemp)
0x000a5adc addiu a2,r0,0x04b0
0x000a5ae0 div a1,a2
0x000a5ae4 mfhi a2
0x000a5ae8 bne a2,r0,0x000a5b30
0x000a5aec nop
0x000a5af0 lhu a2,-0x6c26(gp)
0x000a5af4 nop
0x000a5af8 beq a0,a2,0x000a5b30
0x000a5afc nop
0x000a5b00 lui asmTemp,0x8014
0x000a5b04 lh a2,-0x7b76(asmTemp)
0x000a5b08 nop
0x000a5b0c addi a2,a2,-0x0002
0x000a5b10 lui asmTemp,0x8014
0x000a5b14 sh a2,-0x7b76(asmTemp)
0x000a5b18 lui asmTemp,0x8014
0x000a5b1c lh a2,-0x7b78(asmTemp)
0x000a5b20 nop
0x000a5b24 addi a2,a2,-0x0004
0x000a5b28 lui asmTemp,0x8014
0x000a5b2c sh a2,-0x7b78(asmTemp)
0x000a5b30 addiu a2,r0,0x04b0
0x000a5b34 div a1,a2
0x000a5b38 mfhi a1
0x000a5b3c bne a1,r0,0x000a5b9c
0x000a5b40 nop
0x000a5b44 lhu a1,-0x6c26(gp)
0x000a5b48 nop
0x000a5b4c beq a0,a1,0x000a5b9c
0x000a5b50 nop
0x000a5b54 lui asmTemp,0x8014
0x000a5b58 lh a1,-0x6c70(gp)
0x000a5b5c lh a0,-0x7b9c(asmTemp)
0x000a5b60 nop
0x000a5b64 beq a1,a0,0x000a5b9c
0x000a5b68 nop
0x000a5b6c lui asmTemp,0x8014
0x000a5b70 lh a0,-0x7b8e(asmTemp)
0x000a5b74 nop
0x000a5b78 addi a0,a0,0x0001
0x000a5b7c lui asmTemp,0x8014
0x000a5b80 sh a0,-0x7b8e(asmTemp)
0x000a5b84 lui asmTemp,0x8014
0x000a5b88 lh a0,-0x7b8c(asmTemp)
0x000a5b8c nop
0x000a5b90 addi a0,a0,0x0001
0x000a5b94 lui asmTemp,0x8014
0x000a5b98 sh a0,-0x7b8c(asmTemp)
0x000a5b9c lui asmTemp,0x8014
0x000a5ba0 lw a0,-0x7ba0(asmTemp)
0x000a5ba4 nop
0x000a5ba8 andi a0,a0,0x0001
0x000a5bac beq a0,r0,0x000a5db8
0x000a5bb0 nop
0x000a5bb4 lui asmTemp,0x8014
0x000a5bb8 lh a1,-0x7b9c(asmTemp)
0x000a5bbc lui asmTemp,0x8014
0x000a5bc0 lh a0,-0x7b98(asmTemp)
0x000a5bc4 addu a2,a1,r0
0x000a5bc8 slt asmTemp,a1,a0
0x000a5bcc beq asmTemp,r0,0x000a5bf4
0x000a5bd0 addu a3,a0,r0
0x000a5bd4 lh a0,-0x6c70(gp)
0x000a5bd8 nop
0x000a5bdc slt asmTemp,a2,a0
0x000a5be0 beq asmTemp,r0,0x000a5bf4
0x000a5be4 addu a1,a0,r0
0x000a5be8 slt asmTemp,a1,a3
0x000a5bec beq asmTemp,r0,0x000a5c20
0x000a5bf0 nop
0x000a5bf4 slt asmTemp,a3,a2
0x000a5bf8 beq asmTemp,r0,0x000a5db8
0x000a5bfc nop
0x000a5c00 lh a0,-0x6c70(gp)
0x000a5c04 nop
0x000a5c08 slt asmTemp,a0,a2
0x000a5c0c beq asmTemp,r0,0x000a5db8
0x000a5c10 addu a1,a0,r0
0x000a5c14 slt asmTemp,a1,a3
0x000a5c18 bne asmTemp,r0,0x000a5db8
0x000a5c1c nop
0x000a5c20 slti asmTemp,v1,0x0003
0x000a5c24 beq asmTemp,r0,0x000a5cc0
0x000a5c28 nop
0x000a5c2c lui asmTemp,0x8014
0x000a5c30 lh v0,-0x7b94(asmTemp)
0x000a5c34 nop
0x000a5c38 add v0,a3,v0
0x000a5c3c lui asmTemp,0x8014
0x000a5c40 sh v0,-0x7b9c(asmTemp)
0x000a5c44 lui asmTemp,0x8014
0x000a5c48 lh v0,-0x7b9c(asmTemp)
0x000a5c4c nop
0x000a5c50 slti asmTemp,v0,0x0018
0x000a5c54 bne asmTemp,r0,0x000a5c68
0x000a5c58 nop
0x000a5c5c addi v0,v0,-0x0018
0x000a5c60 lui asmTemp,0x8014
0x000a5c64 sh v0,-0x7b9c(asmTemp)
0x000a5c68 lui asmTemp,0x8014
0x000a5c6c sh r0,-0x7b9a(asmTemp)
0x000a5c70 lui asmTemp,0x8014
0x000a5c74 lh v1,-0x7b9c(asmTemp)
0x000a5c78 lui asmTemp,0x8014
0x000a5c7c lh v0,-0x7b92(asmTemp)
0x000a5c80 nop
0x000a5c84 add v0,v1,v0
0x000a5c88 lui asmTemp,0x8014
0x000a5c8c sh v0,-0x7b98(asmTemp)
0x000a5c90 lui asmTemp,0x8014
0x000a5c94 lh v0,-0x7b98(asmTemp)
0x000a5c98 nop
0x000a5c9c slti asmTemp,v0,0x0018
0x000a5ca0 bne asmTemp,r0,0x000a5cb4
0x000a5ca4 nop
0x000a5ca8 addi v0,v0,-0x0018
0x000a5cac lui asmTemp,0x8014
0x000a5cb0 sh v0,-0x7b98(asmTemp)
0x000a5cb4 lui asmTemp,0x8014
0x000a5cb8 beq r0,r0,0x000a5d4c
0x000a5cbc sh r0,-0x7b96(asmTemp)
0x000a5cc0 sll v1,v0,0x03
0x000a5cc4 sub v0,v1,v0
0x000a5cc8 sll v1,v0,0x02
0x000a5ccc lui v0,0x8012
0x000a5cd0 addiu v0,v0,0x25ce
0x000a5cd4 addu v0,v0,v1
0x000a5cd8 lbu v1,0x0000(v0)
0x000a5cdc lui asmTemp,0x8014
0x000a5ce0 sll v0,v1,0x01
0x000a5ce4 add v0,v0,v1
0x000a5ce8 sll v1,v0,0x01
0x000a5cec lui v0,0x8012
0x000a5cf0 addiu v0,v0,0x2cf4
0x000a5cf4 addu v0,v0,v1
0x000a5cf8 lbu v0,0x0000(v0)
0x000a5cfc addu a0,v1,r0
0x000a5d00 sh v0,-0x7b9c(asmTemp)
0x000a5d04 lui v0,0x8012
0x000a5d08 addiu v0,v0,0x2cf5
0x000a5d0c addu v0,v0,a0
0x000a5d10 lbu v0,0x0000(v0)
0x000a5d14 lui asmTemp,0x8014
0x000a5d18 sh v0,-0x7b9a(asmTemp)
0x000a5d1c lui v0,0x8012
0x000a5d20 addiu v0,v0,0x2cf6
0x000a5d24 addu v0,v0,a0
0x000a5d28 lbu v0,0x0000(v0)
0x000a5d2c lui asmTemp,0x8014
0x000a5d30 sh v0,-0x7b98(asmTemp)
0x000a5d34 lui v0,0x8012
0x000a5d38 addiu v0,v0,0x2cf7
0x000a5d3c addu v0,v0,a0
0x000a5d40 lbu v0,0x0000(v0)
0x000a5d44 lui asmTemp,0x8014
0x000a5d48 sh v0,-0x7b96(asmTemp)
0x000a5d4c lui asmTemp,0x8014
0x000a5d50 lh v1,-0x7b94(asmTemp)
0x000a5d54 nop
0x000a5d58 sll v0,v1,0x01
0x000a5d5c add v0,v0,v1
0x000a5d60 sll v0,v0,0x01
0x000a5d64 lui asmTemp,0x8014
0x000a5d68 sh v0,-0x7b90(asmTemp)
0x000a5d6c lui asmTemp,0x8014
0x000a5d70 sh r0,-0x7b8a(asmTemp)
0x000a5d74 lui asmTemp,0x8014
0x000a5d78 lw v1,-0x7ba0(asmTemp)
0x000a5d7c addiu v0,r0,0xfffe
0x000a5d80 and v0,v1,v0
0x000a5d84 lui asmTemp,0x8014
0x000a5d88 sw v0,-0x7ba0(asmTemp)
0x000a5d8c lui asmTemp,0x8014
0x000a5d90 lh v0,-0x7b4e(asmTemp)
0x000a5d94 nop
0x000a5d98 addi v0,v0,0x0001
0x000a5d9c lui asmTemp,0x8014
0x000a5da0 sh v0,-0x7b4e(asmTemp)
0x000a5da4 jal 0x000df2d0
0x000a5da8 nop
0x000a5dac addiu a0,r0,0x0001
0x000a5db0 jal 0x000acbf4
0x000a5db4 addiu a1,r0,0xffff
0x000a5db8 bne s0,r0,0x000a5e60
0x000a5dbc nop
0x000a5dc0 lui asmTemp,0x8014
0x000a5dc4 lh v1,-0x7b98(asmTemp)
0x000a5dc8 lui asmTemp,0x8014
0x000a5dcc lh v0,-0x7b9c(asmTemp)
0x000a5dd0 addu a1,v1,r0
0x000a5dd4 slt asmTemp,v1,v0
0x000a5dd8 beq asmTemp,r0,0x000a5e1c
0x000a5ddc addu a0,v0,r0
0x000a5de0 lh v0,-0x6c70(gp)
0x000a5de4 nop
0x000a5de8 slt asmTemp,v0,a0
0x000a5dec beq asmTemp,r0,0x000a5e00
0x000a5df0 addu v1,v0,r0
0x000a5df4 slt asmTemp,v1,a1
0x000a5df8 beq asmTemp,r0,0x000a5e60
0x000a5dfc nop
0x000a5e00 lui asmTemp,0x8014
0x000a5e04 lw v0,-0x7ba0(asmTemp)
0x000a5e08 nop
0x000a5e0c ori v0,v0,0x0001
0x000a5e10 lui asmTemp,0x8014
0x000a5e14 beq r0,r0,0x000a5e60
0x000a5e18 sw v0,-0x7ba0(asmTemp)
0x000a5e1c slt asmTemp,a0,a1
0x000a5e20 beq asmTemp,r0,0x000a5e60
0x000a5e24 nop
0x000a5e28 lh v0,-0x6c70(gp)
0x000a5e2c nop
0x000a5e30 slt asmTemp,v0,a0
0x000a5e34 bne asmTemp,r0,0x000a5e60
0x000a5e38 addu v1,v0,r0
0x000a5e3c slt asmTemp,v1,a1
0x000a5e40 beq asmTemp,r0,0x000a5e60
0x000a5e44 nop
0x000a5e48 lui asmTemp,0x8014
0x000a5e4c lw v0,-0x7ba0(asmTemp)
0x000a5e50 nop
0x000a5e54 ori v0,v0,0x0001
0x000a5e58 lui asmTemp,0x8014
0x000a5e5c sw v0,-0x7ba0(asmTemp)
0x000a5e60 lui asmTemp,0x8014
0x000a5e64 lw v0,-0x7ba0(asmTemp)
0x000a5e68 nop
0x000a5e6c andi v0,v0,0x0001
0x000a5e70 beq v0,r0,0x000a5e88
0x000a5e74 nop
0x000a5e78 jal 0x000ba40c
0x000a5e7c addu a0,r0,r0
0x000a5e80 beq r0,r0,0x000a5e94
0x000a5e84 lw ra,0x0014(sp)
0x000a5e88 jal 0x000ba40c
0x000a5e8c addiu a0,r0,0x0001
0x000a5e90 lw ra,0x0014(sp)
0x000a5e94 lw s0,0x0010(sp)
0x000a5e98 jr ra
0x000a5e9c addiu sp,sp,0x0018