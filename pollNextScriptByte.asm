int pollNextScriptByte(ptr) {
  scriptPtr = load(0x134FDC)
  store(ptr, load(scriptPtr))
  store(0x134FDC, scriptPtr + 1)
}

0x00106598 lw v0,-0x6b50(gp)
0x0010659c nop
0x001065a0 lbu v0,0x0000(v0)
0x001065a4 nop
0x001065a8 sb v0,0x0000(a0)
0x001065ac lw v0,-0x6b50(gp)
0x001065b0 nop
0x001065b4 addiu v0,v0,0x0001
0x001065b8 jr ra
0x001065bc sw v0,-0x6b50(gp)