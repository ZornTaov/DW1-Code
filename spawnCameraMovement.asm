int spawnCameraMovement(instanceId) { // actually speed?
  someValue = load(0x134DAC)
  
  if(someValue == -1) {
    store(0x134DAC, 0)
    setObject(0x0FB1, instanceId, 0xD80A0, 0)
  }
  else if(someValue == 1) {
    store(0x134DAC, -1)
    return 1
  }
  
  return 0
}

0x000d8860 lb v0,-0x6d80(gp)
0x000d8864 addiu sp,sp,0xffe8
0x000d8868 sw ra,0x0010(sp)
0x000d886c addu a1,a0,r0
0x000d8870 addiu asmTemp,r0,0xffff
0x000d8874 bne v0,asmTemp,0x000d889c
0x000d8878 addu v1,v0,r0
0x000d887c lui a2,0x800e
0x000d8880 sb r0,-0x6d80(gp)
0x000d8884 addiu a0,r0,0x0fb1
0x000d8888 addiu a2,a2,0x80a0
0x000d888c jal 0x000a2f64
0x000d8890 addu a3,r0,r0
0x000d8894 beq r0,r0,0x000d88bc
0x000d8898 addu v0,r0,r0
0x000d889c addiu asmTemp,r0,0x0001
0x000d88a0 bne v1,asmTemp,0x000d88b8
0x000d88a4 nop
0x000d88a8 addiu v0,r0,0xffff
0x000d88ac sb v0,-0x6d80(gp)
0x000d88b0 beq r0,r0,0x000d88bc
0x000d88b4 addiu v0,r0,0x0001
0x000d88b8 addu v0,r0,r0
0x000d88bc lw ra,0x0010(sp)
0x000d88c0 nop
0x000d88c4 jr ra
0x000d88c8 addiu sp,sp,0x0018