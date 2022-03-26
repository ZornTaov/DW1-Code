int waitForMoveCameraToEntity(scriptId, instanceId) {
  storeEntityLocation(scriptId, 0x150C7C)
  return spawnCameraMovement(instanceId)
}

0x000d88fc addu t0,a1,r0
0x000d8900 addiu sp,sp,0xffe8
0x000d8904 lui a1,0x8015
0x000d8908 sw ra,0x0010(sp)
0x000d890c jal 0x000d8780
0x000d8910 addiu a1,a1,0x0c7c
0x000d8914 jal 0x000d8860
0x000d8918 addu a0,t0,r0
0x000d891c lw ra,0x0010(sp)
0x000d8920 nop
0x000d8924 jr ra
0x000d8928 addiu sp,sp,0x0018