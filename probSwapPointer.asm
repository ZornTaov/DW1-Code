probSwapPointer(ptr1, ptr2) {
  val1Pt1 = load(ptr2) & 0xFF000000
  val1Pt2 = load(ptr1) & 0x00FFFFFF
  
  val2Pt1 = ptr2       & 0x00FFFFFF
  val2Pt2 = load(ptr1) & 0xFF000000
  
  store(ptr2, val1Pt1 | val1Pt2)
  store(ptr1, val2Pt2 | val2Pt1)
}

0x00092ad4 lui a2,0x00ff
0x00092ad8 ori a2,a2,0xffff
0x00092adc lui a3,0xff00
0x00092ae0 lw v1,0x0000(a1)
0x00092ae4 lw v0,0x0000(a0)
0x00092ae8 and v1,v1,a3
0x00092aec and v0,v0,a2
0x00092af0 or v1,v1,v0
0x00092af4 sw v1,0x0000(a1)
0x00092af8 lw v0,0x0000(a0)
0x00092afc and a1,a1,a2
0x00092b00 and v0,v0,a3
0x00092b04 or v0,v0,a1
0x00092b08 jr ra
0x00092b0c sw v0,0x0000(a0)