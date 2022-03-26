int getScript(scriptId) {
  if(scriptId == 0)
    return load(0x134FAC) // MapHead Script
  
  if(load(0x134FC2) == scriptId) // current map script is the requested one
    return load(0x134FB4) // current map script
  
  scriptHead = load(0x134FB0) // Global Script
  store(0x134FC2, scriptId)
  
  scriptStart = load(scriptHead + scriptId * 4)
  scriptTarget = load(0x134FB4)
  scriptSize = load(scriptHead + scriptId * 4 + 4) - scriptStart
  
  loadFileSection(0x130388, scriptTarget, scriptStart, scriptSize) // 0x130388 points to "\SCN\DG.SCN"
  
  return scriptTarget
}

0x00106218 addiu sp,sp,0xffe8
0x0010621c bne a0,r0,0x00106230
0x00106220 sw ra,0x0010(sp)
0x00106224 lw v0,-0x6b80(gp)
0x00106228 beq r0,r0,0x00106290
0x0010622c lw ra,0x0010(sp)
0x00106230 lhu v0,-0x6b6a(gp)
0x00106234 nop
0x00106238 bne v0,a0,0x0010624c
0x0010623c nop
0x00106240 lw v0,-0x6b78(gp)
0x00106244 beq r0,r0,0x00106290
0x00106248 lw ra,0x0010(sp)
0x0010624c lw v1,-0x6b7c(gp)
0x00106250 sll v0,a0,0x02
0x00106254 sh a0,-0x6b6a(gp)
0x00106258 addu v0,v1,v0
0x0010625c lw a2,0x0000(v0)
0x00106260 lw a1,-0x6b78(gp)
0x00106264 addi v0,a0,0x0001
0x00106268 sll v0,v0,0x02
0x0010626c addu v0,v1,v0
0x00106270 lw v0,0x0000(v0)
0x00106274 lui a0,0x8013
0x00106278 subu a3,v0,a2
0x0010627c jal 0x001026e8
0x00106280 addiu a0,a0,0x0388
0x00106284 lw v0,-0x6b78(gp)
0x00106288 nop
0x0010628c lw ra,0x0010(sp)
0x00106290 nop
0x00106294 jr ra
0x00106298 addiu sp,sp,0x0018