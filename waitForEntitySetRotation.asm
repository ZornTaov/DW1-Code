int waitForEntitySetRotation(scriptId, rotation) {
  entityPtr = loadEntityDataFromScriptId(scriptId)
  locationPtr = load(entityPtr + 0x04)
  store(locationPtr + 0x72, rotation)
  return 1
}

0x000ac550 addiu sp,sp,0xffe8
0x000ac554 sw ra,0x0014(sp)
0x000ac558 sw s0,0x0010(sp)
0x000ac55c sw a0,0x0018(sp)
0x000ac560 addu s0,a1,r0
0x000ac564 jal 0x000ac2f8
0x000ac568 addiu a0,sp,0x0018
0x000ac56c lw v0,0x0004(v0)
0x000ac570 nop
0x000ac574 sh s0,0x0072(v0)
0x000ac578 lw ra,0x0014(sp)
0x000ac57c lw s0,0x0010(sp)
0x000ac580 addiu v0,r0,0x0001
0x000ac584 jr ra
0x000ac588 addiu sp,sp,0x0018