void unsetTrigger(triggerId) {
  triggerAddress, triggerMask = getTriggerOffsets(triggerId)
  
  newTriggerValue = load(triggerAddress) & ~triggerMask
  store(triggerAddress, newTriggerValue)
}

0x001065fc addiu sp,sp,0xffe0
0x00106600 sw ra,0x0010(sp)
0x00106604 addiu a1,sp,0x0018
0x00106608 jal 0x00106ca8
0x0010660c addiu a2,sp,0x001f
0x00106610 lw a0,0x0018(sp)
0x00106614 lbu v0,0x001f(sp)
0x00106618 lbu v1,0x0000(a0)
0x0010661c nor v0,v0,r0
0x00106620 and v0,v1,v0
0x00106624 sb v0,0x0000(a0)
0x00106628 lw ra,0x0010(sp)
0x0010662c nop
0x00106630 jr ra
0x00106634 addiu sp,sp,0x0020