/**
 * Causes to wait for vsync for a given amount of frames.
 * If the input parameter is negative the current frame count is returned.
 * If the input parameter is 1 the number of horizontal blanks by the current frame is returned.
 * If the input parameter is 0 the function waits until the frame is over.
 * For any other input the function wait for that number of frames.
 *
 * E.g. vsync(3) at frame 100 waits until frame 103
 */
int vsync(frameCount) {
  counterModePtr = load(0x115A44) // counter mode ptr
  counterValuePtr = load(0x115A48) // counter value
  
  // counter instability workaround http://problemkaputt.de/psx-spx.htm#timers
  do {
    counterValue = load(counterValuePtr)
    testCounterValue = load(counterValuePtr)
  } while(testCounterValue != counterValue)
  
  lastHBlankCount = load(0x115A58)
  hblankSinceLastSync = (counterValue - lastHBlankCount) & 0xFFFF
  
  if(frameCount < 0)
    return load(0x116B30) // frame counter
  
  if(frameCount == 1)
    return hblankSinceLastSync
  
  timeout = frameCount > 0 ? frameCount - 1 : 0
  waitTargetFrame = load(0x115A4C) + timeout
    
  vsyncWait(waitTargetFrame, timeout)
  vsyncWait(load(0x116B30) + 1, 1)
  
  counterMode = load(counterModePtr)
  
  // wait for something, no fucking clue
  if(counterMode & 0x00400000 != 0 && counterMode ^ load(counterModePtr) >= 0)
    while((counterMode ^ load(counterModePtr)) & 0x80000000 == 0);
  
  newFrameCount = load(0x116B30)
  store(0x115A4C, newFrameCount)
  
  // counter instability workaround http://problemkaputt.de/psx-spx.htm#timers
  do {
    counterValue = load(counterValuePtr)
    store(0x115A58, counterValue)
    testCounterValue = load(0x115A58)
    counterValue = load(counterValuePtr)
  } while(testCounterValue != counterValue)
  
  return hblankSinceLastSync
}

0x00091ca8 lui v0,0x8011
0x00091cac lw v0,0x5a44(v0)
0x00091cb0 lui a1,0x8011
0x00091cb4 lw a1,0x5a48(a1)
0x00091cb8 addiu sp,sp,0xffd8
0x00091cbc sw ra,0x0020(sp)
0x00091cc0 sw s1,0x001c(sp)
0x00091cc4 sw s0,0x0018(sp)
0x00091cc8 lw s0,0x0000(v0)
0x00091ccc lw v0,0x0000(a1)
0x00091cd0 nop
0x00091cd4 sw v0,0x0010(sp)
0x00091cd8 lw v1,0x0010(sp)
0x00091cdc lw v0,0x0000(a1)
0x00091ce0 nop
0x00091ce4 bne v1,v0,0x00091ccc
0x00091ce8 nop
0x00091cec lw v0,0x0010(sp)
0x00091cf0 lui v1,0x8011
0x00091cf4 lw v1,0x5a58(v1)
0x00091cf8 nop
0x00091cfc subu v0,v0,v1
0x00091d00 bgez a0,0x00091d18
0x00091d04 andi s1,v0,0xffff
0x00091d08 lui v0,0x8011
0x00091d0c lw v0,0x6b30(v0)
0x00091d10 j 0x00091e0c
0x00091d14 nop
0x00091d18 addiu v0,r0,0x0001
0x00091d1c beq a0,v0,0x00091e08
0x00091d20 nop
0x00091d24 blez a0,0x00091d44
0x00091d28 nop
0x00091d2c lui v0,0x8011
0x00091d30 lw v0,0x5a4c(v0)
0x00091d34 nop
0x00091d38 addiu v0,v0,0xffff
0x00091d3c j 0x00091d4c
0x00091d40 addu v0,v0,a0
0x00091d44 lui v0,0x8011
0x00091d48 lw v0,0x5a4c(v0)
0x00091d4c blez a0,0x00091d58
0x00091d50 addu a1,r0,r0
0x00091d54 addiu a1,a0,0xffff
0x00091d58 jal 0x00091c10
0x00091d5c addu a0,v0,r0
0x00091d60 lui v0,0x8011
0x00091d64 lw v0,0x5a44(v0)
0x00091d68 nop
0x00091d6c lw s0,0x0000(v0)
0x00091d70 lui a0,0x8011
0x00091d74 lw a0,0x6b30(a0)
0x00091d78 addiu a1,r0,0x0001
0x00091d7c jal 0x00091c10
0x00091d80 addiu a0,a0,0x0001
0x00091d84 lui v0,0x0040
0x00091d88 and v0,s0,v0
0x00091d8c beq v0,r0,0x00091dcc
0x00091d90 nop
0x00091d94 lui v1,0x8011
0x00091d98 lw v1,0x5a44(v1)
0x00091d9c nop
0x00091da0 lw v0,0x0000(v1)
0x00091da4 nop
0x00091da8 xor v0,s0,v0
0x00091dac bltz v0,0x00091dcc
0x00091db0 lui a0,0x8000
0x00091db4 lw v0,0x0000(v1)
0x00091db8 nop
0x00091dbc xor v0,s0,v0
0x00091dc0 and v0,v0,a0
0x00091dc4 beq v0,r0,0x00091db4
0x00091dc8 nop
0x00091dcc lui v0,0x8011
0x00091dd0 lw v0,0x6b30(v0)
0x00091dd4 lui a0,0x8011
0x00091dd8 lw a0,0x5a48(a0)
0x00091ddc lui asmTemp,0x8011
0x00091de0 sw v0,0x5a4c(asmTemp)
0x00091de4 lw v0,0x0000(a0)
0x00091de8 lui asmTemp,0x8011
0x00091dec sw v0,0x5a58(asmTemp)
0x00091df0 lui v1,0x8011
0x00091df4 lw v1,0x5a58(v1)
0x00091df8 lw v0,0x0000(a0)
0x00091dfc nop
0x00091e00 bne v1,v0,0x00091de4
0x00091e04 nop
0x00091e08 addu v0,s1,r0
0x00091e0c lw ra,0x0020(sp)
0x00091e10 lw s1,0x001c(sp)
0x00091e14 lw s0,0x0018(sp)
0x00091e18 jr ra
0x00091e1c addiu sp,sp,0x0028