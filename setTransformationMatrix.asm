void setTransformationMatrix(matrixPtr) {
  setGTERotationMatrix(matrixPtr)
  setGTETranslationVector(matrixPtr)
}

0x00097dd8 addiu sp,sp,0xffe8
0x00097ddc sw s0,0x0010(sp)
0x00097de0 sw ra,0x0014(sp)
0x00097de4 jal 0x0009b200
0x00097de8 addu s0,a0,r0
0x00097dec jal 0x0009b290
0x00097df0 addu a0,s0,r0
0x00097df4 lw ra,0x0014(sp)
0x00097df8 lw s0,0x0010(sp)
0x00097dfc jr ra
0x00097e00 addiu sp,sp,0x0018