void entityLookAtTile(playerPtr, tileX, tileY) {
  posArray = int[3]

  posArray[0] = (tileX - 50) * 100 + 50
  posArray[1] = 0
  posArray[2] = (tileY + 50) * 100 - 50
  
  entityLookAtLocation(playerPtr, posArray)
}

0x000e6078 addi v1,a1,-0x0032
0x000e607c addiu sp,sp,0xffd8
0x000e6080 sll v0,v1,0x02
0x000e6084 add v1,v0,v1
0x000e6088 sll v0,v1,0x02
0x000e608c add v0,v1,v0
0x000e6090 sll v0,v0,0x02
0x000e6094 addi v0,v0,0x0032
0x000e6098 sw v0,0x0018(sp)
0x000e609c addiu v0,r0,0x0032
0x000e60a0 sub v1,v0,a2
0x000e60a4 sll v0,v1,0x02
0x000e60a8 add v1,v0,v1
0x000e60ac sll v0,v1,0x02
0x000e60b0 add v0,v1,v0
0x000e60b4 sll v0,v0,0x02
0x000e60b8 sw r0,0x001c(sp)
0x000e60bc addi v0,v0,-0x0032
0x000e60c0 sw ra,0x0010(sp)
0x000e60c4 sw v0,0x0020(sp)
0x000e60c8 jal 0x000d459c
0x000e60cc addiu a1,sp,0x0018
0x000e60d0 lw ra,0x0010(sp)
0x000e60d4 nop
0x000e60d8 jr ra
0x000e60dc addiu sp,sp,0x0028