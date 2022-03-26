int, int pollNextTwoScriptShorts() {
  val1 = pollNextScriptShort()
  val2 = pollNextScriptShort()
  
  return val1, val2
}

0x00106a58 addiu sp,sp,0xffe8
0x00106a5c sw ra,0x0010(sp)
0x00106a60 jal 0x00106a30
0x00106a64 addu v1,a1,r0
0x00106a68 jal 0x00106a30
0x00106a6c addu a0,v1,r0
0x00106a70 lw ra,0x0010(sp)
0x00106a74 nop
0x00106a78 jr ra
0x00106a7c addiu sp,sp,0x0018