//(hopefully) equivalent pseudocode
void setFoodTimer(a0 = digimonId) {
  if(digimonLevel == 1) { // Fresh, next even hour
    v0 = ((currentHour / 2) + 1) * 2 
    
    if(v0 > 24)
      v0 -= 24
    
    store(v0, 0x13849A)
  }
  else if(digimonLevel == 2) { // In-Training, next by 3 dividable hour
    v0 = ((currentHour / 3) + 1) * 3
    
    if(v0 > 24)
      v0 -= 24
  
    store(v0, 0x13849A)
  }
  else { // Everything else
    for(i = 0; i < 8; i++) { // Loop over hunger times
      hungerTime = hungerTimes[i];
    
      if(nextHungerHour >= currentHour) { // stored nextHungerHour is after the currentHour (-> new day)
        if(nextHungerHour < hungerTime) { // hungerTime must be after nextHungerTime
          store(hungerTime, 0x13849A)
          break
        }
      }
      else { // stored nextHungerHour is before currentHour (-> same day)
        if(currentHour < hungerTime) { // hungerTime must be after currentHour
          store(hungerTime, 0x13849A)
          break
        }
      }
      
      hungerTime = hungerTimes[i + 1]
      if(hungerTime == -1 || i == 7) { // no time matched, so either nextHungerHour or currentHour is 23
        for(j = 0; j < 8; j++) {
          hungerTime = hungerTimes[j]
          if(currentHour < hungerTime) {
            store(hungerTime, 0x13849A)
            break
          } 
          else {
            hungerTime = hungerTimes[j + 1]
            
            if(hungerTime == -1 || j == 7) { // still no match, use first time
              hungerTime = hungerTimes[0]
              store(hungerTime, 0x13849A)
              break
            }
          }
        }
        
        break
      }
    }
  }

  if(calculatedNextFeed >= currentHour)
    tmp = (calculatedNextFeed - currentHour) * 60
  else
    tmp = (24 - currentHour + calculatedNextFeed) * 60
    
  store(tmp, 0x13849E)
  
  if(currentMinute == 0)
    return
  
  store(tmp - currentMinute, 0x13849E)
}

//original ASM code
0x000a4a08 sll v1,a0,0x01
0x000a4a0c add v1,v1,a0
0x000a4a10 sll v1,v1,0x02
0x000a4a14 addu v0,a0,r0
0x000a4a18 add v1,v1,a0
0x000a4a1c sll a0,v1,0x02
0x000a4a20 lui v1,0x8013
0x000a4a24 addiu v1,v1,0xced1
0x000a4a28 addu v1,v1,a0
0x000a4a2c lbu v1,0x0000(v1)
0x000a4a30 addiu asmTemp,r0,0x0001
0x000a4a34 bne v1,asmTemp,0x000a4a8c
0x000a4a38 nop
0x000a4a3c lh v0,-0x6c70(gp)
0x000a4a40 nop
0x000a4a44 bgez v0,0x000a4a54
0x000a4a48 sra t9,v0,0x01
0x000a4a4c addiu v0,v0,0x0001
0x000a4a50 sra t9,v0,0x01
0x000a4a54 sll v0,t9,0x01
0x000a4a58 addi v0,v0,0x0002
0x000a4a5c lui asmTemp,0x8014
0x000a4a60 sh v0,-0x7b66(asmTemp)
0x000a4a64 lui asmTemp,0x8014
0x000a4a68 lh v0,-0x7b66(asmTemp)
0x000a4a6c nop
0x000a4a70 slti asmTemp,v0,0x0018
0x000a4a74 bne asmTemp,r0,0x000a4cc0
0x000a4a78 nop
0x000a4a7c addi v0,v0,-0x0018
0x000a4a80 lui asmTemp,0x8014
0x000a4a84 beq r0,r0,0x000a4cc0
0x000a4a88 sh v0,-0x7b66(asmTemp)
0x000a4a8c addiu asmTemp,r0,0x0002
0x000a4a90 bne v1,asmTemp,0x000a4af0
0x000a4a94 nop
0x000a4a98 lui v0,0x5555
0x000a4a9c lh v1,-0x6c70(gp)
0x000a4aa0 ori v0,v0,0x5556
0x000a4aa4 mult v0,v1
0x000a4aa8 lui asmTemp,0x8014
0x000a4aac srl v1,v1,0x1f
0x000a4ab0 mfhi v0
0x000a4ab4 addu v1,v0,v1
0x000a4ab8 sll v0,v1,0x01
0x000a4abc add v0,v0,v1
0x000a4ac0 addi v0,v0,0x0003
0x000a4ac4 sh v0,-0x7b66(asmTemp)
0x000a4ac8 lui asmTemp,0x8014
0x000a4acc lh v0,-0x7b66(asmTemp)
0x000a4ad0 nop
0x000a4ad4 slti asmTemp,v0,0x0018
0x000a4ad8 bne asmTemp,r0,0x000a4cc0
0x000a4adc nop
0x000a4ae0 addi v0,v0,-0x0018
0x000a4ae4 lui asmTemp,0x8014
0x000a4ae8 beq r0,r0,0x000a4cc0
0x000a4aec sh v0,-0x7b66(asmTemp)
0x000a4af0 lh t1,-0x6c70(gp)
0x000a4af4 lui asmTemp,0x8014
0x000a4af8 lh t0,-0x7b66(asmTemp)
0x000a4afc sll a3,v0,0x03
0x000a4b00 sub a3,a3,v0
0x000a4b04 addu v1,r0,r0
0x000a4b08 addiu a0,r0,0x0001
0x000a4b0c addu a1,t0,r0
0x000a4b10 addu a2,t1,r0
0x000a4b14 sll a3,a3,0x02
0x000a4b18 beq r0,r0,0x000a4cb4
0x000a4b1c addu t2,t1,r0
0x000a4b20 slt asmTemp,a1,a2
0x000a4b24 bne asmTemp,r0,0x000a4b74
0x000a4b28 nop
0x000a4b2c lui t4,0x8012
0x000a4b30 addiu t4,t4,0x25bc
0x000a4b34 addu t3,t4,a3
0x000a4b38 addu t3,v1,t3
0x000a4b3c lb t3,0x0000(t3)
0x000a4b40 nop
0x000a4b44 slt asmTemp,t0,t3
0x000a4b48 beq asmTemp,r0,0x000a4bbc
0x000a4b4c nop
0x000a4b50 sll a0,v0,0x03
0x000a4b54 sub v0,a0,v0
0x000a4b58 sll v0,v0,0x02
0x000a4b5c addu v0,t4,v0
0x000a4b60 addu v0,v1,v0
0x000a4b64 lb v0,0x0000(v0)
0x000a4b68 lui asmTemp,0x8014
0x000a4b6c beq r0,r0,0x000a4cc0
0x000a4b70 sh v0,-0x7b66(asmTemp)
0x000a4b74 lui t4,0x8012
0x000a4b78 addiu t4,t4,0x25bc
0x000a4b7c addu t3,t4,a3
0x000a4b80 addu t3,v1,t3
0x000a4b84 lb t3,0x0000(t3)
0x000a4b88 nop
0x000a4b8c slt asmTemp,t1,t3
0x000a4b90 beq asmTemp,r0,0x000a4bbc
0x000a4b94 nop
0x000a4b98 sll a0,v0,0x03
0x000a4b9c sub v0,a0,v0
0x000a4ba0 sll v0,v0,0x02
0x000a4ba4 addu v0,t4,v0
0x000a4ba8 addu v0,v1,v0
0x000a4bac lb v0,0x0000(v0)
0x000a4bb0 lui asmTemp,0x8014
0x000a4bb4 beq r0,r0,0x000a4cc0
0x000a4bb8 sh v0,-0x7b66(asmTemp)
0x000a4bbc lui t3,0x8012
0x000a4bc0 addiu t3,t3,0x25bc
0x000a4bc4 addu t3,t3,a3
0x000a4bc8 addu t3,a0,t3
0x000a4bcc lb t3,0x0000(t3)
0x000a4bd0 addiu asmTemp,r0,0xffff
0x000a4bd4 beq t3,asmTemp,0x000a4be8
0x000a4bd8 nop
0x000a4bdc addiu asmTemp,r0,0x0007
0x000a4be0 bne v1,asmTemp,0x000a4cac
0x000a4be4 nop
0x000a4be8 sll v1,v0,0x03
0x000a4bec sub v1,v1,v0
0x000a4bf0 addu a2,r0,r0
0x000a4bf4 addiu a3,r0,0x0001
0x000a4bf8 beq r0,r0,0x000a4c98
0x000a4bfc sll t0,v1,0x02
0x000a4c00 lui a1,0x8012
0x000a4c04 addiu a1,a1,0x25bc
0x000a4c08 addu a0,a1,t0
0x000a4c0c addu v1,a2,a0
0x000a4c10 lb v1,0x0000(v1)
0x000a4c14 nop
0x000a4c18 slt asmTemp,t2,v1
0x000a4c1c beq asmTemp,r0,0x000a4c48
0x000a4c20 nop
0x000a4c24 sll v1,v0,0x03
0x000a4c28 sub v0,v1,v0
0x000a4c2c sll v0,v0,0x02
0x000a4c30 addu v0,a1,v0
0x000a4c34 addu v0,a2,v0
0x000a4c38 lb v0,0x0000(v0)
0x000a4c3c lui asmTemp,0x8014
0x000a4c40 beq r0,r0,0x000a4cc0
0x000a4c44 sh v0,-0x7b66(asmTemp)
0x000a4c48 addu v1,a3,a0
0x000a4c4c lb v1,0x0000(v1)
0x000a4c50 addiu asmTemp,r0,0xffff
0x000a4c54 beq v1,asmTemp,0x000a4c68
0x000a4c58 nop
0x000a4c5c addiu asmTemp,r0,0x0007
0x000a4c60 bne a2,asmTemp,0x000a4c90
0x000a4c64 nop
0x000a4c68 sll v1,v0,0x03
0x000a4c6c sub v0,v1,v0
0x000a4c70 sll v1,v0,0x02
0x000a4c74 lui v0,0x8012
0x000a4c78 addiu v0,v0,0x25bc
0x000a4c7c addu v0,v0,v1
0x000a4c80 lb v0,0x0000(v0)
0x000a4c84 lui asmTemp,0x8014
0x000a4c88 beq r0,r0,0x000a4cc0
0x000a4c8c sh v0,-0x7b66(asmTemp)
0x000a4c90 addi a2,a2,0x0001
0x000a4c94 addi a3,a3,0x0001
0x000a4c98 slti asmTemp,a2,0x0008
0x000a4c9c bne asmTemp,r0,0x000a4c00
0x000a4ca0 nop
0x000a4ca4 beq r0,r0,0x000a4cc0
0x000a4ca8 nop
0x000a4cac addi v1,v1,0x0001
0x000a4cb0 addi a0,a0,0x0001
0x000a4cb4 slti asmTemp,v1,0x0008
0x000a4cb8 bne asmTemp,r0,0x000a4b20
0x000a4cbc nop
0x000a4cc0 lui asmTemp,0x8014
0x000a4cc4 lh v1,-0x6c70(gp)
0x000a4cc8 lh v0,-0x7b66(asmTemp)
0x000a4ccc addu a0,v1,r0
0x000a4cd0 slt asmTemp,v0,v1
0x000a4cd4 bne asmTemp,r0,0x000a4d20
0x000a4cd8 addu a1,v0,r0
0x000a4cdc sub v1,a1,a0
0x000a4ce0 sll v0,v1,0x04
0x000a4ce4 sub v0,v0,v1
0x000a4ce8 sll v0,v0,0x02
0x000a4cec lui asmTemp,0x8014
0x000a4cf0 sh v0,-0x7b62(asmTemp)
0x000a4cf4 lh v0,-0x6c6e(gp)
0x000a4cf8 nop
0x000a4cfc beq v0,r0,0x000a4d98
0x000a4d00 addu v1,v0,r0
0x000a4d04 lui asmTemp,0x8014
0x000a4d08 lh v0,-0x7b62(asmTemp)
0x000a4d0c nop
0x000a4d10 sub v0,v0,v1
0x000a4d14 lui asmTemp,0x8014
0x000a4d18 beq r0,r0,0x000a4d98
0x000a4d1c sh v0,-0x7b62(asmTemp)
0x000a4d20 addiu v0,r0,0x0018
0x000a4d24 sub v1,v0,a0
0x000a4d28 sll v0,v1,0x04
0x000a4d2c sub v0,v0,v1
0x000a4d30 sll v0,v0,0x02
0x000a4d34 lui asmTemp,0x8014
0x000a4d38 sh v0,-0x7b62(asmTemp)
0x000a4d3c lui asmTemp,0x8014
0x000a4d40 lh v1,-0x7b66(asmTemp)
0x000a4d44 nop
0x000a4d48 sll v0,v1,0x04
0x000a4d4c sub v0,v0,v1
0x000a4d50 sll v1,v0,0x02
0x000a4d54 lui asmTemp,0x8014
0x000a4d58 lh v0,-0x7b62(asmTemp)
0x000a4d5c sll v1,v1,0x10
0x000a4d60 sra v1,v1,0x10
0x000a4d64 add v0,v0,v1
0x000a4d68 lui asmTemp,0x8014
0x000a4d6c sh v0,-0x7b62(asmTemp)
0x000a4d70 lh v0,-0x6c6e(gp)
0x000a4d74 nop
0x000a4d78 beq v0,r0,0x000a4d98
0x000a4d7c addu v1,v0,r0
0x000a4d80 lui asmTemp,0x8014
0x000a4d84 lh v0,-0x7b62(asmTemp)
0x000a4d88 nop
0x000a4d8c sub v0,v0,v1
0x000a4d90 lui asmTemp,0x8014
0x000a4d94 sh v0,-0x7b62(asmTemp)
0x000a4d98 jr ra
0x000a4d9c nop