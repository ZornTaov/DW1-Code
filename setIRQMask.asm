/**
 * Sets the IRQ mask that enabled/disables IRQs and returns the old value.
 */
setIRQMask(newIRQMask) {
  IRQMaskPtr = load(0x116AEC) // 0x1F801074, interrupt mask register
  
  oldIRQMask = load(IRQMaskPtr)
  store(IRQMaskPtr, newIRQMask)
  
  return oldIRQMask
}

0x00092450 lui v1,0x8011
0x00092454 lw v1,0x6aec(v1)
0x00092458 nop
0x0009245c lhu v0,0x0000(v1)
0x00092460 jr ra
0x00092464 sh a0,0x0000(v1)