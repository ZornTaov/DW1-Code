int, int pollNextTwoScriptBytes() {
  val1 = pollNextScriptByte()
  val2 = pollNextScriptByte()
  
  return val1, val2
}

0x00106694 addiu sp,sp,0xffe8
0x00106698 sw ra,0x0010(sp)
0x0010669c jal 0x00106598
0x001066a0 addu v1,a1,r0
0x001066a4 jal 0x00106598
0x001066a8 addu a0,v1,r0
0x001066ac lw ra,0x0010(sp)
0x001066b0 nop
0x001066b4 jr ra
0x001066b8 addiu sp,sp,0x0018