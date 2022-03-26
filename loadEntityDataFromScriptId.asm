/**
 * Returns the entityPtr to a given scriptIdPointer
 * and stores it's entityId in the given pointer.
 */
int loadEntityDataFromScriptId(scriptIdPtr) {
  scriptId = load(scriptIdPtr)
  
  if(scriptId == 0xFD) {
    store(scriptIdPtr, 0)
    entityPtr = load(0x12F344)
  }
  else if(scriptId == 0xFC) {
    store(scriptIdPtr, 1)
    entityPtr = load(0x12F348)
  }
  else {
    for(i = 0; i < 8; i++) {
      entityPtr = load(0x12F344 + (i + 2) * 4)
      lScriptId = load(0x15588D + i * 0x68)
      
      if(entityPtr != 0 && scriptId == lScriptId) {
        store(scriptIdPtr, i + 2)
        break
      }
    }
  }
  
  return entityPtr
}

0x000ac2f8 lbu v1,0x0000(a0)
0x000ac2fc addiu asmTemp,r0,0x00fd
0x000ac300 bne v1,asmTemp,0x000ac31c
0x000ac304 addu t1,v1,r0
0x000ac308 sb r0,0x0000(a0)
0x000ac30c lui asmTemp,0x8013
0x000ac310 lw v0,-0x0cbc(asmTemp)
0x000ac314 beq r0,r0,0x000ac3c0
0x000ac318 nop
0x000ac31c addiu asmTemp,r0,0x00fc
0x000ac320 bne t1,asmTemp,0x000ac340
0x000ac324 addu a2,r0,r0
0x000ac328 addiu v0,r0,0x0001
0x000ac32c sb v0,0x0000(a0)
0x000ac330 lui asmTemp,0x8013
0x000ac334 lw v0,-0x0cb8(asmTemp)
0x000ac338 beq r0,r0,0x000ac3c0
0x000ac33c nop
0x000ac340 addiu a3,r0,0x0002
0x000ac344 beq r0,r0,0x000ac3b4
0x000ac348 addu t0,r0,r0
0x000ac34c lui a1,0x8013
0x000ac350 sll v1,a3,0x02
0x000ac354 addiu a1,a1,0xf344
0x000ac358 addu v1,a1,v1
0x000ac35c lw v1,0x0000(v1)
0x000ac360 nop
0x000ac364 beq v1,r0,0x000ac3a8
0x000ac368 nop
0x000ac36c lui v1,0x8015
0x000ac370 addiu v1,v1,0x588d
0x000ac374 addu v1,v1,t0
0x000ac378 lbu v1,0x0000(v1)
0x000ac37c nop
0x000ac380 bne t1,v1,0x000ac3a8
0x000ac384 nop
0x000ac388 addi v0,a2,0x0002
0x000ac38c addu v1,v0,r0
0x000ac390 sb v0,0x0000(a0)
0x000ac394 sll v0,v1,0x02
0x000ac398 addu v0,a1,v0
0x000ac39c lw v0,0x0000(v0)
0x000ac3a0 beq r0,r0,0x000ac3c0
0x000ac3a4 nop
0x000ac3a8 addi a2,a2,0x0001
0x000ac3ac addi t0,t0,0x0068
0x000ac3b0 addi a3,a3,0x0001
0x000ac3b4 slti asmTemp,a2,0x0008
0x000ac3b8 bne asmTemp,r0,0x000ac34c
0x000ac3bc nop
0x000ac3c0 jr ra
0x000ac3c4 nop