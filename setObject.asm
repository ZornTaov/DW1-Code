/**
 * Sets an object in the object table, handling what is getting rendered.
 *
 * 2 byte objectId
 * 2 byte instanceId
 * 4 byte unknown function pointer
 * 4 byte unknown function pointer
 *
 * returns 1 on success, 0 on failure
 */
int setObject(int objectId, int instanceId, int funcPtr1, int funcPtr2) {
  store(0x137A18, -1)
  
  i = 0
  
  while(load(0x137418 + i * 12) != -1)
    i++
    
  if(i == 0x80)
    return 0
      
  store(0x137418 + i * 12, objectId)
  store(0x13741A + i * 12, instanceId)
  store(0x13741C + i * 12, funcPtr1)
  store(0x137420 + i * 12, funcPtr2)
  
  return 1
}

0x000a2f64 addiu v0,r0,0xffff
0x000a2f68 lui asmTemp,0x8013
0x000a2f6c sh v0,0x7a18(asmTemp)
0x000a2f70 addu t0,r0,r0
0x000a2f74 addu t1,r0,r0
0x000a2f78 lui v1,0x8013
0x000a2f7c addiu v1,v1,0x7418
0x000a2f80 addu v0,v1,t1
0x000a2f84 lh v0,0x0000(v0)
0x000a2f88 addiu asmTemp,r0,0xffff
0x000a2f8c beq v0,asmTemp,0x000a2fa0
0x000a2f90 nop
0x000a2f94 addi t0,t0,0x0001
0x000a2f98 beq r0,r0,0x000a2f78
0x000a2f9c addi t1,t1,0x000c
0x000a2fa0 addiu asmTemp,r0,0x0080
0x000a2fa4 bne t0,asmTemp,0x000a2fb4
0x000a2fa8 nop
0x000a2fac beq r0,r0,0x000a3000
0x000a2fb0 addu v0,r0,r0
0x000a2fb4 sll v0,t0,0x01
0x000a2fb8 add v0,v0,t0
0x000a2fbc sll v0,v0,0x02
0x000a2fc0 addu t0,v0,r0
0x000a2fc4 addu v0,v1,v0
0x000a2fc8 sh a0,0x0000(v0)
0x000a2fcc lui v0,0x8013
0x000a2fd0 addiu v0,v0,0x741a
0x000a2fd4 addu v0,v0,t0
0x000a2fd8 sh a1,0x0000(v0)
0x000a2fdc lui v0,0x8013
0x000a2fe0 addiu v0,v0,0x741c
0x000a2fe4 addu v0,v0,t0
0x000a2fe8 sw a2,0x0000(v0)
0x000a2fec lui v0,0x8013
0x000a2ff0 addiu v0,v0,0x7420
0x000a2ff4 addu v0,v0,t0
0x000a2ff8 sw a3,0x0000(v0)
0x000a2ffc addiu v0,r0,0x0001
0x000a3000 jr ra
0x000a3004 nop