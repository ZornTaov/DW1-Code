/**
 * Gets state of an SPU Voice.
 * -1 -> no voice found
 *  0 -> channel is inactive and has no ADSR volume
 *  1 -> channel is active and has ADSR volume
 *  2 -> channel is inactive and has ADSR volume
 *  3 -> channel is active and has no ADSR volume
 */
int getSPUVoiceState(voiceMask) {
  voiceId = -1
  
  for(i = 0; i < 24; i++) {
    if(voiceMask & (1 << i) != 0) {
      voiceId = i
      break
    }
  }
  
  if(voiceId == -1) // no voice selected
    return -1
    
  spuRegister = load(0x128080) + voiceId * 16 // SPU Voice (voiceId) Register
  adsrVolume = load(spuRegister + 0x0C) // Voice (voiceId) ADSR Current Volume
  isChannelActive = load(0x1280B0) & (1 << voiceId) // channel active?
  
  if(isChannelActive == 0) // channel is inactive
    return adsrVolume > 0 ? 2 : 0 // has ADSR volume
  
  if(adsrVolume != 0)
    return 1 // channel is active and has ADSR volume
    
  return 3 // channel is active and doesn't have ADSR volume
}

0x000c8da8 addiu a1,r0,0xffff
0x000c8dac addu v1,r0,r0
0x000c8db0 addiu a2,r0,0x0001
0x000c8db4 sllv v0,a2,v1
0x000c8db8 and v0,a0,v0
0x000c8dbc bne v0,r0,0x000c8de8
0x000c8dc0 nop
0x000c8dc4 addiu v1,v1,0x0001
0x000c8dc8 slti v0,v1,0x0018
0x000c8dcc bne v0,r0,0x000c8db8
0x000c8dd0 sllv v0,a2,v1
0x000c8dd4 addiu v0,r0,0xffff
0x000c8dd8 bne a1,v0,0x000c8df0
0x000c8ddc sll a0,a1,0x04
0x000c8de0 j 0x000c8e30
0x000c8de4 nop
0x000c8de8 j 0x000c8dd4
0x000c8dec addu a1,v1,r0
0x000c8df0 lui v0,0x8013
0x000c8df4 lw v0,-0x7f80(v0)
0x000c8df8 lui v1,0x8013
0x000c8dfc lw v1,-0x7f50(v1)
0x000c8e00 addu a0,a0,v0
0x000c8e04 addiu v0,r0,0x0001
0x000c8e08 sllv v0,v0,a1
0x000c8e0c and v1,v1,v0
0x000c8e10 lhu a0,0x000c(a0)
0x000c8e14 bne v1,r0,0x000c8e24
0x000c8e18 sltu v0,r0,a0
0x000c8e1c j 0x000c8e30
0x000c8e20 sll v0,v0,0x01
0x000c8e24 bne a0,r0,0x000c8e30
0x000c8e28 addiu v0,r0,0x0001
0x000c8e2c addiu v0,r0,0x0003
0x000c8e30 jr ra
0x000c8e34 nop