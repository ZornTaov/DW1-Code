boolean isTriggerSet(int triggerId) {

  // stack + 0x18 and stack + 0x1F
  triggerAddress, triggerFlag = getTriggerOffsets(triggerId)
  
  return (load(triggerAddress) & triggerFlag) > 0
}

0x0010643c addiu sp,sp,0xffe0
0x00106440 sw ra,0x0010(sp)
0x00106444 addiu a1,sp,0x0018
0x00106448 jal 0x00106ca8
0x0010644c addiu a2,sp,0x001f
0x00106450 lw v0,0x0018(sp)
0x00106454 lw ra,0x0010(sp)
0x00106458 lbu v1,0x0000(v0)
0x0010645c lbu v0,0x001f(sp)
0x00106460 nop
0x00106464 and v0,v1,v0
0x00106468 sltu v0,r0,v0
0x0010646c jr ra
0x00106470 addiu sp,sp,0x0020