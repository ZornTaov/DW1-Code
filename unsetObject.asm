/**
 * Unsets an object in the object table, handling what is getting rendered.
 *
 * 2 byte objectId
 * 2 byte instanceId
 * 4 byte unknown function pointer
 * 4 byte unknown function pointer
 *
 * returns 1 on success, 0 on failure
 */
int unsetObject(objectId, instanceId) {
  store(0x137A18, objectId)   // for loop end condition
  store(0x137A1A, instanceId) // for loop end condition
  
  i = 0
  
  // will always break at i = 0x80 or sooner
  while(true) {
    lObjectId = load(0x137418 + i * 0x0C)
    lInstanceId = load(0x13741A + i * 0x0C)
    
    if(objectId == lObjectId && instanceId == lInstanceId)
        break
    
    i++
  }
  
  if(i == 0x80)
    return 0
  
  store(0x137418 + i * 0x0C, -1)
  store(0x13741A + i * 0x0C, -1)
  store(0x13741C + i * 0x0C, 0)
  store(0x137420 + i * 0x0C, 0)
  
  return 1
}

0x000a3008 lui asmTemp,0x8013
0x000a300c sh a0,0x7a18(asmTemp)
0x000a3010 lui asmTemp,0x8013
0x000a3014 sh a1,0x7a1a(asmTemp)
0x000a3018 addu t0,r0,r0
0x000a301c addu v1,r0,r0
0x000a3020 lui a3,0x8013
0x000a3024 addiu a3,a3,0x7418
0x000a3028 addu v0,a3,v1
0x000a302c lh v0,0x0000(v0)
0x000a3030 nop
0x000a3034 bne a0,v0,0x000a3058
0x000a3038 nop
0x000a303c lui a2,0x8013
0x000a3040 addiu a2,a2,0x741a
0x000a3044 addu v0,a2,v1
0x000a3048 lh v0,0x0000(v0)
0x000a304c nop
0x000a3050 beq a1,v0,0x000a3064
0x000a3054 nop
0x000a3058 addi t0,t0,0x0001
0x000a305c beq r0,r0,0x000a3020
0x000a3060 addi v1,v1,0x000c
0x000a3064 addiu asmTemp,r0,0x0080
0x000a3068 bne t0,asmTemp,0x000a3078
0x000a306c nop
0x000a3070 beq r0,r0,0x000a30c0
0x000a3074 addu v0,r0,r0
0x000a3078 sll v0,t0,0x01
0x000a307c add v0,v0,t0
0x000a3080 sll v0,v0,0x02
0x000a3084 addu a0,v0,r0
0x000a3088 addiu v1,r0,0xffff
0x000a308c addu v0,a3,v0
0x000a3090 sh v1,0x0000(v0)
0x000a3094 addu v0,a2,a0
0x000a3098 sh v1,0x0000(v0)
0x000a309c lui v0,0x8013
0x000a30a0 addiu v0,v0,0x741c
0x000a30a4 addu v0,v0,a0
0x000a30a8 sw r0,0x0000(v0)
0x000a30ac lui v0,0x8013
0x000a30b0 addiu v0,v0,0x7420
0x000a30b4 addu v0,v0,a0
0x000a30b8 sw r0,0x0000(v0)
0x000a30bc addiu v0,r0,0x0001
0x000a30c0 jr ra
0x000a30c4 nop