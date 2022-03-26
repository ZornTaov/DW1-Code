int uploadTexture(headerPtr, dataStartPtr) {
  setGPUTimeout()
  
  xSize = load(headerPtr + 4)
  ySize = load(headerPtr + 6)
  
  fbWidth = load(0x116C58)
  fbHeight = load(0x116C5A)
  
  if(xSize >= 0)
    imageWidth = fbWidth < xSize ? fbWidth : xSize
  else
    imageWidth = 0
  
  if(ySize >= 0)
    imageHeight = fbHeight < ySize ? fbHeight : ySize
  else
    imageHeight = 0
  
  store(headerPtr + 4, imageWidth)
  store(headerPtr + 6, imageHeight)
  
  totalPx = imageWidth * imageHeight + 1
  numWords = totalPx / 2
  numBlocks = totalPx / 32
  nonDMAWords = numWords - (numBlocks * 16)
  
  if(numWords <= 0)
    return -1
  
  // IO Mappings
  gp0CmdPtr = load(0x116C0C) // 0x1F801810
  gp1CmdPtr = load(0x116C10) // 0x1F801814
  
  dmaBaseAdr = load(0x116C14) // 0x1F8010A0
  dmaBlockCtrl = load(0x116C18) // 0x1F8010A4
  dmaChanCtrl = load(0x116C1C) // 0x1F8010A8
  
  // load(gp1CmdPtr) -> read GPU status register
  while(load(gp1CmdPtr) & 0x04000000 == 0) // wait till CMD can be received
    if(checkGPUTimeout() != 0)
      return -1
  
  // GPU/DMA Commands
  store(gp1CmdPtr, 0x04000000) // DMA direction: off
  store(gp0CmdPtr, 0x01000000) // reset command buffer
  
  store(gp0CmdPtr, 0xA0000000) // command GP0(0x04): copy rectangle CPU to VRAM
  store(gp0CmdPtr, load(headerPtr)) // destination coords
  store(gp0CmdPtr, load(headerPtr + 4)) // dimensions (2-byte X, 2-byte Y)
  
  while(--nonDMAWords != -1) {
    store(gp0CmdPtr, load(dataStartPtr))
    dataStartPtr = dataStartPtr + 4
  }
  
  if(numBlocks == 0)
    return 0
  
  // setup DMA, transfer data?
  store(gp1CmdPtr, 0x04000002) // DMA direction: CPU to GPU
  store(dmaBaseAdr, dataStartPtr) // DMA start address
  store(dmaBlockCtrl, (numBlocks << 0x10) | 0x0010) // DMA blocksize 0x10, numBlocks is number of blocks
  store(dmaChanCtrl, 0x01000201) // DMA start, sync mode 1, from RAM
  
  return 0
}

0x0009355c addiu sp,sp,0xffd0
0x00093560 sw s1,0x0014(sp)
0x00093564 addu s1,a0,r0
0x00093568 sw s2,0x0018(sp)
0x0009356c addu s2,a1,r0
0x00093570 sw ra,0x0028(sp)
0x00093574 sw s5,0x0024(sp)
0x00093578 sw s4,0x0020(sp)
0x0009357c sw s3,0x001c(sp)
0x00093580 jal 0x000942c8
0x00093584 sw s0,0x0010(sp)
0x00093588 lh a1,0x0004(s1)
0x0009358c lhu v1,0x0004(s1)
0x00093590 bltz a1,0x000935c0
0x00093594 addu s5,r0,r0
0x00093598 addu a0,v1,r0
0x0009359c lui v0,0x8011
0x000935a0 lh v0,0x6c58(v0)
0x000935a4 lui v1,0x8011
0x000935a8 lhu v1,0x6c58(v1)
0x000935ac slt v0,v0,a1
0x000935b0 beq v0,r0,0x000935c4
0x000935b4 nop
0x000935b8 j 0x000935c4
0x000935bc addu a0,v1,r0
0x000935c0 addu a0,r0,r0
0x000935c4 lh a1,0x0006(s1)
0x000935c8 lhu v1,0x0006(s1)
0x000935cc bltz a1,0x000935fc
0x000935d0 sh a0,0x0004(s1)
0x000935d4 addu a0,v1,r0
0x000935d8 lui v0,0x8011
0x000935dc lh v0,0x6c5a(v0)
0x000935e0 lui v1,0x8011
0x000935e4 lhu v1,0x6c5a(v1)
0x000935e8 slt v0,v0,a1
0x000935ec beq v0,r0,0x00093604
0x000935f0 sll v0,a0,0x10
0x000935f4 j 0x00093600
0x000935f8 addu a0,v1,r0
0x000935fc addu a0,r0,r0
0x00093600 sll v0,a0,0x10
0x00093604 lh v1,0x0004(s1)
0x00093608 sra v0,v0,0x10
0x0009360c mult v1,v0
0x00093610 sh a0,0x0006(s1)
0x00093614 mflo a2
0x00093618 addiu v1,a2,0x0001
0x0009361c srl v0,v1,0x1f
0x00093620 addu v1,v1,v0
0x00093624 sra a0,v1,0x01
0x00093628 bgtz a0,0x00093638
0x0009362c sra s0,v1,0x05
0x00093630 j 0x00093774
0x00093634 addiu v0,r0,0xffff
0x00093638 addu v1,s0,r0
0x0009363c sll v0,v1,0x04
0x00093640 subu s0,a0,v0
0x00093644 lui v0,0x8011
0x00093648 lw v0,0x6c10(v0)
0x0009364c addu s4,v1,r0
0x00093650 lw v0,0x0000(v0)
0x00093654 lui v1,0x0400
0x00093658 and v0,v0,v1
0x0009365c bne v0,r0,0x00093698
0x00093660 lui a0,0xa000
0x00093664 lui s3,0x0400
0x00093668 jal 0x000942fc
0x0009366c nop
0x00093670 bne v0,r0,0x00093774
0x00093674 addiu v0,r0,0xffff
0x00093678 lui v0,0x8011
0x0009367c lw v0,0x6c10(v0)
0x00093680 nop
0x00093684 lw v0,0x0000(v0)
0x00093688 nop
0x0009368c and v0,v0,s3
0x00093690 beq v0,r0,0x00093668
0x00093694 lui a0,0xa000
0x00093698 lui v1,0x8011
0x0009369c lw v1,0x6c10(v1)
0x000936a0 lui v0,0x0400
0x000936a4 sw v0,0x0000(v1)
0x000936a8 lui v1,0x8011
0x000936ac lw v1,0x6c0c(v1)
0x000936b0 lui v0,0x0100
0x000936b4 sw v0,0x0000(v1)
0x000936b8 lui v0,0x8011
0x000936bc lw v0,0x6c0c(v0)
0x000936c0 beq s5,r0,0x000936cc
0x000936c4 nop
0x000936c8 lui a0,0xb000
0x000936cc sw a0,0x0000(v0)
0x000936d0 lui v1,0x8011
0x000936d4 lw v1,0x6c0c(v1)
0x000936d8 lw v0,0x0000(s1)
0x000936dc nop
0x000936e0 sw v0,0x0000(v1)
0x000936e4 lui v1,0x8011
0x000936e8 lw v1,0x6c0c(v1)
0x000936ec lw v0,0x0004(s1)
0x000936f0 addiu s0,s0,0xffff
0x000936f4 sw v0,0x0000(v1)
0x000936f8 addiu v0,r0,0xffff
0x000936fc beq s0,v0,0x00093724
0x00093700 nop
0x00093704 addiu a0,r0,0xffff
0x00093708 lw v1,0x0000(s2)
0x0009370c addiu s2,s2,0x0004
0x00093710 lui v0,0x8011
0x00093714 lw v0,0x6c0c(v0)
0x00093718 addiu s0,s0,0xffff
0x0009371c bne s0,a0,0x00093708
0x00093720 sw v1,0x0000(v0)
0x00093724 beq s4,r0,0x00093770
0x00093728 lui v1,0x0400
0x0009372c lui v0,0x8011
0x00093730 lw v0,0x6c10(v0)
0x00093734 ori v1,v1,0x0002
0x00093738 sw v1,0x0000(v0)
0x0009373c lui v0,0x8011
0x00093740 lw v0,0x6c14(v0)
0x00093744 lui a0,0x0100
0x00093748 sw s2,0x0000(v0)
0x0009374c sll v0,s4,0x10
0x00093750 lui v1,0x8011
0x00093754 lw v1,0x6c18(v1)
0x00093758 ori v0,v0,0x0010
0x0009375c sw v0,0x0000(v1)
0x00093760 lui v0,0x8011
0x00093764 lw v0,0x6c1c(v0)
0x00093768 ori a0,a0,0x0201
0x0009376c sw a0,0x0000(v0)
0x00093770 addu v0,r0,r0
0x00093774 lw ra,0x0028(sp)
0x00093778 lw s5,0x0024(sp)
0x0009377c lw s4,0x0020(sp)
0x00093780 lw s3,0x001c(sp)
0x00093784 lw s2,0x0018(sp)
0x00093788 lw s1,0x0014(sp)
0x0009378c lw s0,0x0010(sp)
0x00093790 jr ra
0x00093794 addiu sp,sp,0x0030