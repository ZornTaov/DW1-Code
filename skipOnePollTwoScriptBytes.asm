int, int skipOnePollTwoScriptBytes() {
  store(0x134FDC, load(0x134FDC) + 1)
  val1 = pollNextScriptByte()
  val2 = pollNextScriptByte()
  
  return val1, val2
}

0x00106638 lw v0,-0x6b50(gp)
0x0010663c addiu sp,sp,0xffe8
0x00106640 addiu v0,v0,0x0001
0x00106644 sw ra,0x0010(sp)
0x00106648 sw v0,-0x6b50(gp)
0x0010664c jal 0x00106598
0x00106650 addu v1,a1,r0
0x00106654 jal 0x00106598
0x00106658 addu a0,v1,r0
0x0010665c lw ra,0x0010(sp)
0x00106660 nop
0x00106664 jr ra
0x00106668 addiu sp,sp,0x0018