/**
 * Returns two values to an address each defined by input parameter a1 and a2, 
 * typically (stack + 0x18) and (stack + 0x1F).
 */
int, int getTriggerOffsets(int triggerId) {
  
  targetBit = triggerId & 7
  
  if(triggerId < 0 && targetBit != 0)
    targetBit -= 8
  
  targetBit &= 0xFF
  
  if(triggerId < 0)
    triggerId += 7
  
  targetByte = triggerId / 8
  
  triggerAddress = load(0x134FB8) + 0xF5 + targetByte // trigger byte
  triggerFlag = 1 << targetBit
  
  return triggerAddress, triggerFlag
}

0x00106ca8 addu a3,a0,r0
0x00106cac bgez a0,0x00106cc0
0x00106cb0 andi v0,a0,0x0007
0x00106cb4 beq v0,r0,0x00106cc0
0x00106cb8 nop
0x00106cbc addiu v0,v0,0xfff8
0x00106cc0 andi v1,v0,0x00ff
0x00106cc4 bgez a3,0x00106cd4
0x00106cc8 sra t9,a3,0x03
0x00106ccc addiu v0,a3,0x0007
0x00106cd0 sra t9,v0,0x03
0x00106cd4 lw v0,-0x6b74(gp)
0x00106cd8 nop
0x00106cdc addu v0,v0,t9
0x00106ce0 addiu v0,v0,0x00f5
0x00106ce4 sw v0,0x0000(a1)
0x00106ce8 addiu v0,r0,0x0001
0x00106cec beq r0,r0,0x00106d0c
0x00106cf0 sb v0,0x0000(a2)
0x00106cf4 lbu v0,0x0000(a2)
0x00106cf8 nop
0x00106cfc sll v0,v0,0x01
0x00106d00 sb v0,0x0000(a2)
0x00106d04 addiu v0,v1,0xffff
0x00106d08 andi v1,v0,0x00ff
0x00106d0c bne v1,r0,0x00106cf4
0x00106d10 nop
0x00106d14 jr ra
0x00106d18 nop