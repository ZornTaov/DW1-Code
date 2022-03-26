void loadImage(headerPtr, dataPtr) {
  printRectDebugInfo(0x113E94, headerPtr) // "LoadImage"
  
  somePtr = load(0x116BB4)
  gpuFunctionPtr = load(somePtr + 0x20) // 0x0009355C -> uploadTexture
  
  gpuLoadImage(gpuFunctionPtr, headerPtr, 8, dataPtr) // call load(somePtr + 0x08)
}

0x000948a8 addiu sp,sp,0xffe0
0x000948ac sw s0,0x0010(sp)
0x000948b0 addu s0,a0,r0
0x000948b4 sw s1,0x0014(sp)
0x000948b8 addu s1,a1,r0
0x000948bc lui a0,0x8011
0x000948c0 addiu a0,a0,0x3e94
0x000948c4 sw ra,0x0018(sp)
0x000948c8 jal 0x00092cbc
0x000948cc addu a1,s0,r0
0x000948d0 addu a1,s0,r0
0x000948d4 lui v0,0x8011
0x000948d8 lw v0,0x6bb4(v0)
0x000948dc addiu a2,r0,0x0008
0x000948e0 lw a0,0x0020(v0)
0x000948e4 lw v0,0x0008(v0)
0x000948e8 nop
0x000948ec jalr v0,ra
0x000948f0 addu a3,s1,r0
0x000948f4 lw ra,0x0018(sp)
0x000948f8 lw s1,0x0014(sp)
0x000948fc lw s0,0x0010(sp)
0x00094900 jr ra
0x00094904 addiu sp,sp,0x0020