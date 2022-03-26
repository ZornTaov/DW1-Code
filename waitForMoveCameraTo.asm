int waitForMoveCameraTo(posX, posZ, instanceId) { // actually speed?
  store(0x150C7C, posX)
  store(0x150C80, load(load(0x155770) + 0x7C)
  store(0x150C84, posZ)
  
  return spawnCameraMovement(instanceId)
}

0x000d88cc lui asmTemp,0x8015
0x000d88d0 sw a0,0x0c7c(asmTemp)
0x000d88d4 lui asmTemp,0x8015
0x000d88d8 lw v0,0x5770(asmTemp)
0x000d88dc nop
0x000d88e0 lw v0,0x007c(v0)
0x000d88e4 lui asmTemp,0x8015
0x000d88e8 sw v0,0x0c80(asmTemp)
0x000d88ec lui asmTemp,0x8015
0x000d88f0 sw a1,0x0c84(asmTemp)
0x000d88f4 j 0x000d8860
0x000d88f8 addu a0,a2,r0