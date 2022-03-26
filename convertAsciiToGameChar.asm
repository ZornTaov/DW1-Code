int convertAsciiToGameChar(val) {
  specialCharOffset = 0
  
  if(val >= 0x20 && val < 0x30) // ' ', !, ", #, $, %, &, ', (, ), *, +, ',', -, ., /
    specialCharOffset = 1
  else if(val >= 0x3A && val < 0x41) // :, ;, <; =, >, ?
    specialCharOffset = 0x0B
  else if(val >= 0x5B && val < 0x61) // [, \, ], ^, _, `
    specialCharOffset = 0x25
  else if(val >= 0x7B && val < 0x7F) // {, |, }, ~
    specialCharOffset = 0x3F
  else if(val >= 0x30 && val < 0x3A) // numbers
    charType = 0
  else if(val >= 0x41 && val < 0x5B) // upper case letters
    charType = 1
  else if(val >= 0x61 && val < 0x7B) // lower case letters
    charType = 2
  else
    charType = 0
    
  if(specialCharOffset != 0) {
    charOffset = val - specialCharOffset - 0x1F
    return load(0x12F3A8 + charOffset * 4)
  }
  else {
    dwChar = load(0x12F39C + charType * 4)
    asciiChar = load(0x12F39E + charType * 4)
    return val + dwChar - asciiChar
  }
}

0x000f18c8 sltiu asmTemp,a0,0x0020
0x000f18cc bne asmTemp,r0,0x000f18e8
0x000f18d0 addu a1,r0,r0
0x000f18d4 sltiu asmTemp,a0,0x0030
0x000f18d8 beq asmTemp,r0,0x000f18e8
0x000f18dc nop
0x000f18e0 beq r0,r0,0x000f19b0
0x000f18e4 addiu a1,r0,0x0001
0x000f18e8 sltiu asmTemp,a0,0x0030
0x000f18ec bne asmTemp,r0,0x000f1908
0x000f18f0 nop
0x000f18f4 sltiu asmTemp,a0,0x003a
0x000f18f8 beq asmTemp,r0,0x000f1908
0x000f18fc nop
0x000f1900 beq r0,r0,0x000f19b0
0x000f1904 addu v0,r0,r0
0x000f1908 sltiu asmTemp,a0,0x003a
0x000f190c bne asmTemp,r0,0x000f1928
0x000f1910 nop
0x000f1914 sltiu asmTemp,a0,0x0041
0x000f1918 beq asmTemp,r0,0x000f1928
0x000f191c nop
0x000f1920 beq r0,r0,0x000f19b0
0x000f1924 addiu a1,r0,0x000b
0x000f1928 sltiu asmTemp,a0,0x0041
0x000f192c bne asmTemp,r0,0x000f1948
0x000f1930 nop
0x000f1934 sltiu asmTemp,a0,0x005b
0x000f1938 beq asmTemp,r0,0x000f1948
0x000f193c nop
0x000f1940 beq r0,r0,0x000f19b0
0x000f1944 addiu v0,r0,0x0001
0x000f1948 sltiu asmTemp,a0,0x005b
0x000f194c bne asmTemp,r0,0x000f1968
0x000f1950 nop
0x000f1954 sltiu asmTemp,a0,0x0061
0x000f1958 beq asmTemp,r0,0x000f1968
0x000f195c nop
0x000f1960 beq r0,r0,0x000f19b0
0x000f1964 addiu a1,r0,0x0025
0x000f1968 sltiu asmTemp,a0,0x0061
0x000f196c bne asmTemp,r0,0x000f1988
0x000f1970 nop
0x000f1974 sltiu asmTemp,a0,0x007b
0x000f1978 beq asmTemp,r0,0x000f1988
0x000f197c nop
0x000f1980 beq r0,r0,0x000f19b0
0x000f1984 addiu v0,r0,0x0002
0x000f1988 sltiu asmTemp,a0,0x007b
0x000f198c bne asmTemp,r0,0x000f19a8
0x000f1990 nop
0x000f1994 sltiu asmTemp,a0,0x007f
0x000f1998 beq asmTemp,r0,0x000f19a8
0x000f199c nop
0x000f19a0 beq r0,r0,0x000f19b0
0x000f19a4 addiu a1,r0,0x003f
0x000f19a8 beq r0,r0,0x000f1a18
0x000f19ac addu v0,r0,r0
0x000f19b0 beq a1,r0,0x000f19e0
0x000f19b4 nop
0x000f19b8 addi v1,a0,-0x0020
0x000f19bc addi v0,a1,-0x0001
0x000f19c0 sub v0,v1,v0
0x000f19c4 sll v1,v0,0x02
0x000f19c8 lui v0,0x8013
0x000f19cc addiu v0,v0,0xf3a8
0x000f19d0 addu v0,v0,v1
0x000f19d4 lhu v0,0x0000(v0)
0x000f19d8 beq r0,r0,0x000f1a18
0x000f19dc nop
0x000f19e0 sll a1,v0,0x02
0x000f19e4 lui v0,0x8013
0x000f19e8 addiu v0,v0,0xf39c
0x000f19ec addu v0,v0,a1
0x000f19f0 lhu v0,0x0000(v0)
0x000f19f4 nop
0x000f19f8 add v1,a0,v0
0x000f19fc lui v0,0x8013
0x000f1a00 addiu v0,v0,0xf39e
0x000f1a04 addu v0,v0,a1
0x000f1a08 lhu v0,0x0000(v0)
0x000f1a0c nop
0x000f1a10 sub v0,v1,v0
0x000f1a14 andi v0,v0,0xffff
0x000f1a18 jr ra
0x000f1a1c nop