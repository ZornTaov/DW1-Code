int setDMAIRQHandler(dmaIrqId, newHandler) {
  oldHandler = load(0x116B38 + dmaIrqId * 4)
  
  if(newHandler == oldHandler)
    return oldHandler
  
  dmaIRQregPtr = load(0x116B34) // DMA IRQ Register
  
  store(0x116B38 + dmaIrqId * 4, newHandler)
  dmaIRQreg = load(dmaIRQregPtr) & 0x00FFFFFF
  irqBitMask = 1 << (dmaIrqId + 0x10)
  
  if(newHandler != 0)
    newDmaIrqRegVal = dmaIRQreg | irqBitMask | 0x00800000 // DMA IRQ master enable and DMA<dmaIrqId> IRQ enable
  else
    newDmaIrqRegVal = dmaIRQreg & ~irqBitMask // unset DMA IRQ DMA<dmaIrqId>
  
  store(dmaIRQregPtr, newDmaIrqRegVal)
  return oldHandler
}

0x00092708 addu a2,a0,r0
0x0009270c lui v1,0x8011
0x00092710 addiu v1,v1,0x6b38
0x00092714 sll v0,a2,0x02
0x00092718 addu v1,v0,v1
0x0009271c lw a3,0x0000(v1)
0x00092720 addu a0,a1,r0
0x00092724 beq a0,a3,0x000927ac
0x00092728 addu v0,a3,r0
0x0009272c beq a0,r0,0x00092770
0x00092730 lui v0,0x00ff
0x00092734 lui a1,0x8011
0x00092738 lw a1,0x6b34(a1)
0x0009273c ori v0,v0,0xffff
0x00092740 sw a0,0x0000(v1)
0x00092744 lw a0,0x0000(a1)
0x00092748 addiu v1,a2,0x0010
0x0009274c and a0,a0,v0
0x00092750 addiu v0,r0,0x0001
0x00092754 sllv v0,v0,v1
0x00092758 lui v1,0x0080
0x0009275c or v0,v0,v1
0x00092760 or a0,a0,v0
0x00092764 sw a0,0x0000(a1)
0x00092768 j 0x000927ac
0x0009276c addu v0,a3,r0
0x00092770 lui a1,0x8011
0x00092774 lw a1,0x6b34(a1)
0x00092778 ori v0,v0,0xffff
0x0009277c sw r0,0x0000(v1)
0x00092780 lw v1,0x0000(a1)
0x00092784 addiu a0,a2,0x0010
0x00092788 and v1,v1,v0
0x0009278c lui v0,0x0080
0x00092790 or v1,v1,v0
0x00092794 addiu v0,r0,0x0001
0x00092798 sllv v0,v0,a0
0x0009279c nor v0,r0,v0
0x000927a0 and v1,v1,v0
0x000927a4 sw v1,0x0000(a1)
0x000927a8 addu v0,a3,r0
0x000927ac jr ra
0x000927b0 nop