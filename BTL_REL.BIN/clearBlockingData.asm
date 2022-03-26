void clearBlockingData(combatPtr) {
  for(i = 0; i < 150; i++) {
    blockingDataPtr = combatPtr + i
    
    if(load(blockingDataPtr + 0x3C) == -1)
      return
    
    store(blockingDataPtr + 0x3C, -1)
    store(blockingDataPtr + 0xD2, -1)
  }
}

0x0005b254 beq r0,r0,0x0005b284
0x0005b258 addu a2,r0,r0
0x0005b25c addu a1,a2,a0
0x0005b260 lb v0,0x003c(a1)
0x0005b264 addiu asmTemp,r0,0xffff
0x0005b268 beq v0,asmTemp,0x0005b290
0x0005b26c nop
0x0005b270 addiu v1,r0,0xffff
0x0005b274 addu v0,a1,r0
0x0005b278 sb v1,0x003c(v0)
0x0005b27c sb v1,0x00d2(a1)
0x0005b280 addi a2,a2,0x0001
0x0005b284 slti asmTemp,a2,0x0096
0x0005b288 bne asmTemp,r0,0x0005b25c
0x0005b28c nop
0x0005b290 jr ra
0x0005b294 nop