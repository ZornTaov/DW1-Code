int initOrderingTable(val1, val2, otPtrPtr) {
  otCount = load(val3 + 0x00)

  store(val3 + 0x08, val1)
  store(val3 + 0x0C, val2)
  store(val3 + 0x10, load(val3 + 0x04) + (4 << otCount) - 4)
  
  return ClearOTagR(load(val3 + 0x04), 1 << otCount)
}

0x00098838 addiu r29,r29,0xffe8
0x0009883c andi r4,r4,0xffff
0x00098840 andi r5,r5,0xffff
0x00098844 sw r31,0x0010(r29)
0x00098848 sw r4,0x0008(r6)
0x0009884c lw r4,0x0000(r6)
0x00098850 lw r2,0x0004(r6)
0x00098854 addiu r3,r0,0x0004
0x00098858 sw r5,0x000c(r6)
0x0009885c lw r5,0x0000(r6)
0x00098860 sllv r3,r3,r4
0x00098864 addu r2,r2,r3
0x00098868 addiu r2,r2,0xfffc
0x0009886c sw r2,0x0010(r6)
0x00098870 addiu r2,r0,0x0001
0x00098874 lw r4,0x0004(r6)
0x00098878 jal 0x00094a20
0x0009887c sllv r5,r2,r5
0x00098880 lw r31,0x0010(r29)
0x00098884 addiu r29,r29,0x0018
0x00098888 jr r31
0x0009888c nop