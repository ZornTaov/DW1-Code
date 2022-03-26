isKeyDown(keyFlag) {
  if(load(0x135024) & keyFlag == 0)
    return 0
  
  store(0x135020, load(0x135020) & ~keyFlag)
  
  return 1
}

0x000fc054 lw v0,-0x6b08(gp)
0x000fc058 nop
0x000fc05c and v0,v0,a0
0x000fc060 bne v0,r0,0x000fc070
0x000fc064 nop
0x000fc068 beq r0,r0,0x000fc084
0x000fc06c addu v0,r0,r0
0x000fc070 lw v0,-0x6b0c(gp)
0x000fc074 nor v1,a0,r0
0x000fc078 and v0,v0,v1
0x000fc07c sw v0,-0x6b0c(gp)
0x000fc080 addiu v0,r0,0x0001
0x000fc084 jr ra
0x000fc088 nop