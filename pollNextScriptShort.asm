int pollNextScriptShort() {
  scriptPtr = load(0x134FDC)
  
  value = load(scriptPtr)
  store(0x134FDC, scriptPtr + 2)
  
  return value
}


0x00106a30 lw v0,-0x6b50(gp)
0x00106a34 nop
0x00106a38 lh v0,0x0000(v0)
0x00106a3c nop
0x00106a40 sh v0,0x0000(a0)
0x00106a44 lw v0,-0x6b50(gp)
0x00106a48 nop
0x00106a4c addi v0,v0,0x0002
0x00106a50 jr ra
0x00106a54 sw v0,-0x6b50(gp)