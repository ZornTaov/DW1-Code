void checkGPUTimeout() { // check GPU timeout
  frameCount = vsync(-1)
  targetFrame = load(0x116C3C)
  
  if(targetFrame < frameCount) {
    a0 = load(0x116C40)
    store(0x116C40, a0 + 1)
    
    if(0xF0000 >= a0)
      return 0
  }
  
  gpuStatusPtr = load(0x116C10) // 0x1F801814, GPU Status Register
  gpuStatus = load(gpuStatusPtr)
  
  dmaBaseAdrPtr = load(0x116C14) // 0x1F8010A0, DMA2 channel 2 GPU, DMA base address
  dmaBaseAdr = load(dmaBaseAdrPtr)
  
  queValue = load(0x116CD4) - load(0x116CD8)
  
  dmaChanControlPtr = load(0x116C1C) // 0x1F8010A8, DMA 2 channel 2 GPU, DMA Channel Control
  dmaChanControl = load(dmaChanControlPtr)
  
  printf(0x113F48, queValue & 0x3F, gpuStatus, dmaChanControl, dmaBaseAdr) // "GPU timeout:que=%d,stat=%08x,chcr=%08x,madr=%08x,"
  oldIRQMask = setIRQMask(0)
  
  store(0x116C38, oldIRQMask)
  
  store(0x116CD8, 0)
  store(0x116CD4, load(0x116CD8)) // set to 0 as well?
  
  store(dmaChanControlPtr, 0x0401) // DMA Control, read Linked List from Main RAM
  
  dmaControlRegPtr = load(0x116C2C) // 0x1F8010F0, DMA Control Register
  store(dmaControlRegPtr, load(dmaControlRegPtr) | 0x0800) // set GPU Master Enable
  
  gp1DisplayControlPtr = load(0x116C10)
  store(gp1DisplayControlPtr, 0x02000000) // ack GPU IRQ
  store(gp1DisplayControlPtr, 0x01000000) // reset GPU command buffer
  
  setIRQMask(load(0x116C38))
  
  return -1
}

0x000942fc addiu sp,sp,0xffe0
0x00094300 sw ra,0x0018(sp)
0x00094304 jal 0x00091ca8
0x00094308 addiu a0,r0,0xffff
0x0009430c lui v1,0x8011
0x00094310 lw v1,0x6c3c(v1)
0x00094314 nop
0x00094318 slt v1,v1,v0
0x0009431c bne v1,r0,0x00094350
0x00094320 nop
0x00094324 lui v1,0x8011
0x00094328 addiu v1,v1,0x6c40
0x0009432c lw v0,0x0000(v1)
0x00094330 nop
0x00094334 addu a0,v0,r0
0x00094338 addiu v0,v0,0x0001
0x0009433c sw v0,0x0000(v1)
0x00094340 lui v0,0x000f
0x00094344 slt v0,v0,a0
0x00094348 beq v0,r0,0x0009442c
0x0009434c nop
0x00094350 lui a2,0x8011
0x00094354 lw a2,0x6c10(a2)
0x00094358 lui a0,0x8011
0x0009435c addiu a0,a0,0x3f48
0x00094360 lw v0,0x0000(a2)
0x00094364 lui a1,0x8011
0x00094368 lw a1,0x6cd4(a1)
0x0009436c lui v0,0x8011
0x00094370 lw v0,0x6c14(v0)
0x00094374 lui v1,0x8011
0x00094378 lw v1,0x6cd8(v1)
0x0009437c lw v0,0x0000(v0)
0x00094380 subu a1,a1,v1
0x00094384 sw v0,0x0010(sp)
0x00094388 lui v0,0x8011
0x0009438c lw v0,0x6c1c(v0)
0x00094390 lw a2,0x0000(a2)
0x00094394 lw a3,0x0000(v0)
0x00094398 jal 0x0009128c
0x0009439c andi a1,a1,0x003f
0x000943a0 jal 0x00092450
0x000943a4 addu a0,r0,r0
0x000943a8 lui asmTemp,0x8011
0x000943ac sw r0,0x6cd8(asmTemp)
0x000943b0 lui v1,0x8011
0x000943b4 lw v1,0x6cd8(v1)
0x000943b8 lui asmTemp,0x8011
0x000943bc sw v0,0x6c38(asmTemp)
0x000943c0 lui asmTemp,0x8011
0x000943c4 sw v1,0x6cd4(asmTemp)
0x000943c8 lui v1,0x8011
0x000943cc lw v1,0x6c1c(v1)
0x000943d0 addiu v0,r0,0x0401
0x000943d4 sw v0,0x0000(v1)
0x000943d8 lui v1,0x8011
0x000943dc lw v1,0x6c2c(v1)
0x000943e0 nop
0x000943e4 lw v0,0x0000(v1)
0x000943e8 nop
0x000943ec ori v0,v0,0x0800
0x000943f0 sw v0,0x0000(v1)
0x000943f4 lui v1,0x8011
0x000943f8 lw v1,0x6c10(v1)
0x000943fc lui v0,0x0200
0x00094400 sw v0,0x0000(v1)
0x00094404 lui v1,0x8011
0x00094408 lw v1,0x6c10(v1)
0x0009440c lui v0,0x0100
0x00094410 sw v0,0x0000(v1)
0x00094414 lui a0,0x8011
0x00094418 lw a0,0x6c38(a0)
0x0009441c jal 0x00092450
0x00094420 nop
0x00094424 j 0x00094430
0x00094428 addiu v0,r0,0xffff
0x0009442c addu v0,r0,r0
0x00094430 lw ra,0x0018(sp)
0x00094434 addiu sp,sp,0x0020
0x00094438 jr ra
0x0009443c nop