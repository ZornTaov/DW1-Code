void setTrigger(triggerId) {
  triggerAddress, triggerMask = getTriggerOffsets(triggerId)
  
  newTriggerValue = load(triggerOffset) | triggerMask
  store(triggerOffset, newTriggerValue)
}

0x001065c0 addiu sp,sp,0xffe0
0x001065c4 sw ra,0x0010(sp)
0x001065c8 addiu a1,sp,0x0018
0x001065cc jal 0x00106ca8
0x001065d0 addiu a2,sp,0x001f
0x001065d4 lw a0,0x0018(sp)
0x001065d8 lbu v0,0x001f(sp)
0x001065dc lbu v1,0x0000(a0)
0x001065e0 nop
0x001065e4 or v0,v1,v0
0x001065e8 sb v0,0x0000(a0)
0x001065ec lw ra,0x0010(sp)
0x001065f0 nop
0x001065f4 jr ra
0x001065f8 addiu sp,sp,0x0020