// still ugly and dirty...
void doSlotsRigging(reelNr, dataOffset) {
  canDoSlots = load(dataOffset + 0x22) // canDoSlots
  
  reel1 = load(dataOffset + 0x0B) // first reel symbol
  reel2 = load(dataOffset + 0x0C) // second reel symbol
  
  if(canDoSlots == 2) {
    
    if((reelNr == 2 && reel1 == 7 && reel2 == 7) || (reelNr == 1 && reel1 == 7) || reelNr == 0) {
      for(i = 1; i < 3; i++) {
        symbolOffset = (load(dataOffset + reelNr + 0x08) + 0x0D - i) % 0x0D
        
        if(load(0x8F1AC + reelNr * 13 + symbolOffset) == 7)
          break
      }
      
      if(i == 3) {
        store(dataOffset + reelNr + 0x0E, 0)
        store(dataOffset + reelNr + 0x0B, -1)
      }
      else {
        store(dataOffset + reelNr + 0x0E, i - 1)
        store(dataOffset + reelNr + 0x0B, 7)
      }
    }
    else
      store(reelNr + dataOffset + 0x0B, -reelNr - 1)
  }
  else if(canDoSlots == 1) {
    if(reelNr == 2 && reel1 != reel2)
      return
    
    if(reelNr == 0 || reelNr == 1 && reel1 == 7) {
      subOffset = load(reelNr * 2 + dataOffset + 0x12) == 0 ? 0 : 1
      symbolOffset = (load(reelNr + dataOffset + 0x08) + 0x0D - subOffset) % 0x0D
      
      symbolId = load(0x8F1AC + reelNr * 0x0D + symbolOffset)
      store(dataOffset + reelNr + 0x0B, symbolId)
    }
    else if(reelNr == 1 || reelNr == 2 && reel1 != 7) {
      for(i = 1; i < 3; i++) {
        symbolOffset = (load(reelNr + dataOffset + 0x08) + 0x0D - i) % 0x0D
        
        if(load(0x08F1AC + reelNr * 0x0D + symbolOffset) == reel1)
          break
      }
      
      if(i == 3 || i == 0) {
        store(reelNr + dataOffset + 0x0E, 0)
        store(reelNr + dataOffset + 0x0B, -2)
      }
      else {
        store(reelNr + dataOffset + 0x0E, i - 1)
        store(reelNr + dataOffset + 0x0B, reel1)
      }
    }
    else if(reelNr == 2) { // reel1 == 7 implied
      symbolOffset = (load(reelNr + dataOffset + 0x08) + 0x0C) % 0x0D
      symbolId = load(0x8F1AC + reelNr * 13 + symbolOffset)
      
      if(symbolId != 7)
        return
      
      overroll = 1 + rand() % 2 // effective code
      // this was probably supposed to be a 25% chance for the game not fucking you over
      
      store(reelNr + dataOffset + 0x0E, overroll)
    }
  }
  else if(canDoSlots == 0) {
    if(reelNr == 2 && reel1 != reel2)
      return
    
    if(reelNr == 0 || reelNr == 1) {
      symbolOffset = (load(reelNr + dataOffset + 0x08) + 0x0C) % 0x0D
      symbolId = load(0x8F1AC + reelNr * 0x0D + symbolOffset)
      
      store(dataOffset + reelNr + 0x0B, symbolId)
    }
    else if(reelNr == 2) {
      symbolOffset = (load(reelNr + dataOffset + 0x08) + 0x0C) % 0x0D
      symbolId = load(0x8F1AC + reelNr * 13 + symbolOffset)
      
      if(symbolId != reel2)
        return
      
      overroll = 1 + rand() % 2 // effective code
      // this was probably supposed to be a 25% chance for the game not fucking you over
        
      store(dataOffset + reelNr + 0x0E, overroll)
    }
  }
}

0x0008e824 addiu sp,sp,0xffe0
0x0008e828 sw ra,0x0018(sp)
0x0008e82c sw s1,0x0014(sp)
0x0008e830 sw s0,0x0010(sp)
0x0008e834 addiu asmTemp,r0,0x0002
0x0008e838 beq a0,asmTemp,0x0008eb24
0x0008e83c addu s0,a1,r0
0x0008e840 addiu asmTemp,r0,0x0001
0x0008e844 beq a0,asmTemp,0x0008e9d8
0x0008e848 nop
0x0008e84c bne a0,r0,0x0008ed50
0x0008e850 nop
0x0008e854 lb v0,0x0022(s0)
0x0008e858 addiu asmTemp,r0,0x0002
0x0008e85c beq v0,asmTemp,0x0008e930
0x0008e860 nop
0x0008e864 addiu asmTemp,r0,0x0001
0x0008e868 beq v0,asmTemp,0x0008e8c0
0x0008e86c nop
0x0008e870 bne v0,r0,0x0008ed50
0x0008e874 nop
0x0008e878 addu a2,a0,s0
0x0008e87c lb v0,0x0008(a2)
0x0008e880 nop
0x0008e884 addi v1,v0,0x000c
0x0008e888 addiu v0,r0,0x000d
0x0008e88c div v1,v0
0x0008e890 sll v0,a0,0x01
0x0008e894 add v0,v0,a0
0x0008e898 sll v0,v0,0x02
0x0008e89c add v1,v0,a0
0x0008e8a0 lui v0,0x8009
0x0008e8a4 addiu v0,v0,0xf1ac
0x0008e8a8 mfhi a1
0x0008e8ac addu v0,v0,v1
0x0008e8b0 addu v0,a1,v0
0x0008e8b4 lb v0,0x0000(v0)
0x0008e8b8 beq r0,r0,0x0008ed50
0x0008e8bc sb v0,0x000b(a2)
0x0008e8c0 sll v0,a0,0x01
0x0008e8c4 addu v0,v0,s0
0x0008e8c8 lh v0,0x0012(v0)
0x0008e8cc nop
0x0008e8d0 bne v0,r0,0x0008e8e0
0x0008e8d4 addu a2,a0,r0
0x0008e8d8 beq r0,r0,0x0008e8e4
0x0008e8dc addu v0,r0,r0
0x0008e8e0 addiu v0,r0,0x0001
0x0008e8e4 addu a1,a2,s0
0x0008e8e8 lb v1,0x0008(a1)
0x0008e8ec nop
0x0008e8f0 addi v1,v1,0x000d
0x0008e8f4 sub v1,v1,v0
0x0008e8f8 addiu v0,r0,0x000d
0x0008e8fc div v1,v0
0x0008e900 sll v0,a2,0x01
0x0008e904 add v0,v0,a2
0x0008e908 sll v0,v0,0x02
0x0008e90c add v1,v0,a2
0x0008e910 lui v0,0x8009
0x0008e914 addiu v0,v0,0xf1ac
0x0008e918 mfhi a0
0x0008e91c addu v0,v0,v1
0x0008e920 addu v0,a0,v0
0x0008e924 lb v0,0x0000(v0)
0x0008e928 beq r0,r0,0x0008ed50
0x0008e92c sb v0,0x000b(a1)
0x0008e930 sll v1,a0,0x01
0x0008e934 add v1,v1,a0
0x0008e938 sll v1,v1,0x02
0x0008e93c addiu v0,r0,0x0001
0x0008e940 addu a1,a0,r0
0x0008e944 addu a3,a0,r0
0x0008e948 beq r0,r0,0x0008e994
0x0008e94c add a2,v1,a0
0x0008e950 addu v1,a1,s0
0x0008e954 lb v1,0x0008(v1)
0x0008e958 addiu asmTemp,r0,0x0007
0x0008e95c addi v1,v1,0x000d
0x0008e960 sub a0,v1,v0
0x0008e964 addiu v1,r0,0x000d
0x0008e968 div a0,v1
0x0008e96c lui v1,0x8009
0x0008e970 addiu v1,v1,0xf1ac
0x0008e974 mfhi a0
0x0008e978 addu v1,v1,a2
0x0008e97c addu v1,a0,v1
0x0008e980 lb v1,0x0000(v1)
0x0008e984 nop
0x0008e988 beq v1,asmTemp,0x0008e9a0
0x0008e98c nop
0x0008e990 addi v0,v0,0x0001
0x0008e994 slti asmTemp,v0,0x0003
0x0008e998 bne asmTemp,r0,0x0008e950
0x0008e99c nop
0x0008e9a0 addiu asmTemp,r0,0x0003
0x0008e9a4 bne v0,asmTemp,0x0008e9c0
0x0008e9a8 nop
0x0008e9ac addu v1,a3,s0
0x0008e9b0 sb r0,0x000e(v1)
0x0008e9b4 addiu v0,r0,0xffff
0x0008e9b8 beq r0,r0,0x0008ed50
0x0008e9bc sb v0,0x000b(v1)
0x0008e9c0 addi v0,v0,-0x0001
0x0008e9c4 addu v1,a3,s0
0x0008e9c8 sb v0,0x000e(v1)
0x0008e9cc addiu v0,r0,0x0007
0x0008e9d0 beq r0,r0,0x0008ed50
0x0008e9d4 sb v0,0x000b(v1)
0x0008e9d8 lb v0,0x0022(s0)
0x0008e9dc addiu asmTemp,r0,0x0002
0x0008e9e0 beq v0,asmTemp,0x0008eb04
0x0008e9e4 nop
0x0008e9e8 addiu asmTemp,r0,0x0001
0x0008e9ec beq v0,asmTemp,0x0008ea44
0x0008e9f0 nop
0x0008e9f4 bne v0,r0,0x0008ed50
0x0008e9f8 nop
0x0008e9fc addu a2,a0,s0
0x0008ea00 lb v0,0x0008(a2)
0x0008ea04 nop
0x0008ea08 addi v1,v0,0x000c
0x0008ea0c addiu v0,r0,0x000d
0x0008ea10 div v1,v0
0x0008ea14 sll v0,a0,0x01
0x0008ea18 add v0,v0,a0
0x0008ea1c sll v0,v0,0x02
0x0008ea20 add v1,v0,a0
0x0008ea24 lui v0,0x8009
0x0008ea28 addiu v0,v0,0xf1ac
0x0008ea2c mfhi a1
0x0008ea30 addu v0,v0,v1
0x0008ea34 addu v0,a1,v0
0x0008ea38 lb v0,0x0000(v0)
0x0008ea3c beq r0,r0,0x0008ed50
0x0008ea40 sb v0,0x000b(a2)
0x0008ea44 lb v0,0x000b(s0)
0x0008ea48 addiu asmTemp,r0,0x0007
0x0008ea4c beq v0,asmTemp,0x0008e8c0
0x0008ea50 addu v1,v0,r0
0x0008ea54 sll a1,a0,0x01
0x0008ea58 add a1,a1,a0
0x0008ea5c sll a1,a1,0x02
0x0008ea60 addiu v0,r0,0x0001
0x0008ea64 addu a2,a0,r0
0x0008ea68 addu t0,a0,r0
0x0008ea6c beq r0,r0,0x0008eab8
0x0008ea70 add a3,a1,a0
0x0008ea74 addu a0,a2,s0
0x0008ea78 lb a0,0x0008(a0)
0x0008ea7c nop
0x0008ea80 addi a0,a0,0x000d
0x0008ea84 sub a1,a0,v0
0x0008ea88 addiu a0,r0,0x000d
0x0008ea8c div a1,a0
0x0008ea90 lui a0,0x8009
0x0008ea94 addiu a0,a0,0xf1ac
0x0008ea98 mfhi a1
0x0008ea9c addu a0,a0,a3
0x0008eaa0 addu a0,a1,a0
0x0008eaa4 lb a0,0x0000(a0)
0x0008eaa8 nop
0x0008eaac beq v1,a0,0x0008eac4
0x0008eab0 nop
0x0008eab4 addi v0,v0,0x0001
0x0008eab8 slti asmTemp,v0,0x0003
0x0008eabc bne asmTemp,r0,0x0008ea74
0x0008eac0 nop
0x0008eac4 addiu asmTemp,r0,0x0003
0x0008eac8 beq v0,asmTemp,0x0008ead8
0x0008eacc nop
0x0008ead0 bne v0,r0,0x0008eaec
0x0008ead4 nop
0x0008ead8 addu v1,t0,s0
0x0008eadc sb r0,0x000e(v1)
0x0008eae0 addiu v0,r0,0xfffe
0x0008eae4 beq r0,r0,0x0008ed50
0x0008eae8 sb v0,0x000b(v1)
0x0008eaec addi v0,v0,-0x0001
0x0008eaf0 addu v1,t0,s0
0x0008eaf4 sb v0,0x000e(v1)
0x0008eaf8 lb v0,0x000b(s0)
0x0008eafc beq r0,r0,0x0008ed50
0x0008eb00 sb v0,0x000b(v1)
0x0008eb04 lb v0,0x000b(s0)
0x0008eb08 addiu asmTemp,r0,0x0007
0x0008eb0c beq v0,asmTemp,0x0008e930
0x0008eb10 nop
0x0008eb14 addiu v1,r0,0xfffe
0x0008eb18 addu v0,a0,s0
0x0008eb1c beq r0,r0,0x0008ed50
0x0008eb20 sb v1,0x000b(v0)
0x0008eb24 lb v0,0x0022(s0)
0x0008eb28 addiu asmTemp,r0,0x0002
0x0008eb2c beq v0,asmTemp,0x0008ed24
0x0008eb30 nop
0x0008eb34 addiu asmTemp,r0,0x0001
0x0008eb38 beq v0,asmTemp,0x0008ebd8
0x0008eb3c nop
0x0008eb40 bne v0,r0,0x0008ed50
0x0008eb44 nop
0x0008eb48 lb v1,0x000b(s0)
0x0008eb4c lb v0,0x000c(s0)
0x0008eb50 nop
0x0008eb54 bne v1,v0,0x0008ed50
0x0008eb58 addu a1,v1,r0
0x0008eb5c addu s1,a0,r0
0x0008eb60 addu v0,s1,s0
0x0008eb64 lb v0,0x0008(v0)
0x0008eb68 nop
0x0008eb6c addi v1,v0,0x000c
0x0008eb70 addiu v0,r0,0x000d
0x0008eb74 div v1,v0
0x0008eb78 sll v0,s1,0x01
0x0008eb7c add v0,v0,s1
0x0008eb80 sll v0,v0,0x02
0x0008eb84 add v1,v0,s1
0x0008eb88 lui v0,0x8009
0x0008eb8c addiu v0,v0,0xf1ac
0x0008eb90 mfhi a0
0x0008eb94 addu v0,v0,v1
0x0008eb98 addu v0,a0,v0
0x0008eb9c lb v0,0x0000(v0)
0x0008eba0 nop
0x0008eba4 bne a1,v0,0x0008ed50
0x0008eba8 nop
0x0008ebac jal 0x0009127c
0x0008ebb0 nop
0x0008ebb4 bgez v0,0x0008ebc8
0x0008ebb8 andi v1,v0,0x0001
0x0008ebbc beq v1,r0,0x0008ebc8
0x0008ebc0 nop
0x0008ebc4 addiu v1,v1,0xfffe
0x0008ebc8 addi v1,v1,0x0001
0x0008ebcc addu v0,s1,s0
0x0008ebd0 beq r0,r0,0x0008ed50
0x0008ebd4 sb v1,0x000e(v0)
0x0008ebd8 lb a1,0x000b(s0)
0x0008ebdc lb v0,0x000c(s0)
0x0008ebe0 nop
0x0008ebe4 bne a1,v0,0x0008ed50
0x0008ebe8 addu v1,a1,r0
0x0008ebec addiu asmTemp,r0,0x0007
0x0008ebf0 beq v1,asmTemp,0x0008eca8
0x0008ebf4 nop
0x0008ebf8 sll a1,a0,0x01
0x0008ebfc add a1,a1,a0
0x0008ec00 sll a1,a1,0x02
0x0008ec04 addiu v0,r0,0x0001
0x0008ec08 addu a2,a0,r0
0x0008ec0c addu t0,a0,r0
0x0008ec10 beq r0,r0,0x0008ec5c
0x0008ec14 add a3,a1,a0
0x0008ec18 addu a0,a2,s0
0x0008ec1c lb a0,0x0008(a0)
0x0008ec20 nop
0x0008ec24 addi a0,a0,0x000d
0x0008ec28 sub a1,a0,v0
0x0008ec2c addiu a0,r0,0x000d
0x0008ec30 div a1,a0
0x0008ec34 lui a0,0x8009
0x0008ec38 addiu a0,a0,0xf1ac
0x0008ec3c mfhi a1
0x0008ec40 addu a0,a0,a3
0x0008ec44 addu a0,a1,a0
0x0008ec48 lb a0,0x0000(a0)
0x0008ec4c nop
0x0008ec50 beq v1,a0,0x0008ec68
0x0008ec54 nop
0x0008ec58 addi v0,v0,0x0001
0x0008ec5c slti asmTemp,v0,0x0003
0x0008ec60 bne asmTemp,r0,0x0008ec18
0x0008ec64 nop
0x0008ec68 addiu asmTemp,r0,0x0003
0x0008ec6c beq v0,asmTemp,0x0008ec7c
0x0008ec70 nop
0x0008ec74 bne v0,r0,0x0008ec90
0x0008ec78 nop
0x0008ec7c addu v1,t0,s0
0x0008ec80 sb r0,0x000e(v1)
0x0008ec84 addiu v0,r0,0xfffe
0x0008ec88 beq r0,r0,0x0008ed50
0x0008ec8c sb v0,0x000b(v1)
0x0008ec90 addi v0,v0,-0x0001
0x0008ec94 addu v1,t0,s0
0x0008ec98 sb v0,0x000e(v1)
0x0008ec9c lb v0,0x000b(s0)
0x0008eca0 beq r0,r0,0x0008ed50
0x0008eca4 sb v0,0x000b(v1)
0x0008eca8 addu s1,a0,r0
0x0008ecac addu v0,s1,s0
0x0008ecb0 lb v0,0x0008(v0)
0x0008ecb4 addiu asmTemp,r0,0x0007
0x0008ecb8 addi v1,v0,0x000c
0x0008ecbc addiu v0,r0,0x000d
0x0008ecc0 div v1,v0
0x0008ecc4 sll v0,s1,0x01
0x0008ecc8 add v0,v0,s1
0x0008eccc sll v0,v0,0x02
0x0008ecd0 add v1,v0,s1
0x0008ecd4 lui v0,0x8009
0x0008ecd8 addiu v0,v0,0xf1ac
0x0008ecdc mfhi a0
0x0008ece0 addu v0,v0,v1
0x0008ece4 addu v0,a0,v0
0x0008ece8 lb v0,0x0000(v0)
0x0008ecec nop
0x0008ecf0 bne v0,asmTemp,0x0008ed50
0x0008ecf4 nop
0x0008ecf8 jal 0x0009127c
0x0008ecfc nop
0x0008ed00 bgez v0,0x0008ed14
0x0008ed04 andi v1,v0,0x0001
0x0008ed08 beq v1,r0,0x0008ed14
0x0008ed0c nop
0x0008ed10 addiu v1,v1,0xfffe
0x0008ed14 addi v1,v1,0x0001
0x0008ed18 addu v0,s1,s0
0x0008ed1c beq r0,r0,0x0008ed50
0x0008ed20 sb v1,0x000e(v0)
0x0008ed24 lb v0,0x000b(s0)
0x0008ed28 addiu asmTemp,r0,0x0007
0x0008ed2c bne v0,asmTemp,0x0008ed44
0x0008ed30 nop
0x0008ed34 lb v0,0x000c(s0)
0x0008ed38 addiu asmTemp,r0,0x0007
0x0008ed3c beq v0,asmTemp,0x0008e930
0x0008ed40 nop
0x0008ed44 addiu v1,r0,0xfffd
0x0008ed48 addu v0,a0,s0
0x0008ed4c sb v1,0x000b(v0)
0x0008ed50 lw ra,0x0018(sp)
0x0008ed54 lw s1,0x0014(sp)
0x0008ed58 lw s0,0x0010(sp)
0x0008ed5c jr ra
0x0008ed60 addiu sp,sp,0x0020