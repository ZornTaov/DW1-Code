int waitForMoveObjectTo(id, otherId, duration, targetPosX, targetPosY) {
  if(load(0x13C038 + otherId * 4) == 0) {
    store(0x13CB38 + otherId, (targetPosX - load(0x14F342 + id * 34)) / duration)
    store(0x13CB44 + otherId, (targetPosY - load(0x14F344 + id * 34)) / duration)
    
    store(0x13C038 + otherId * 4, 1)
  }
  
  xVel = load(0x13CB38 + otherId)
  yVel = load(0x13CB44 + otherId)
  
  xPosPtr = 0x14F342 + id * 34
  yPosPtr = 0x14F344 + id * 34
  
  store(xPosPtr, load(xPosPtr) + xVel)
  store(yPosPtr, load(yPosPtr) + yVel)
  
  if(xVel > 0) {
    if(load(xPosPtr) >= targetPosX)
      store(xPosPtr, targetPosX)
  }
  else if(xVel < 0) {
    if(targetPosX >= load(xPosPtr))
      store(xPosPtr, targetPosX)
  }
  else
    store(xPosPtr, targetPosX)
  
  if(yVel > 0) {
    if(load(yPosPtr) >= targetPosY)
      store(yPosPtr, targetPosY)
  }
  else if(yVel < 0) {
    if(targetPosY >= load(yPosPtr))
      store(yPosPtr, targetPosY)
  }
  else
    store(yPosPtr, targetPosY)
  
  if(load(xPosPtr) != targetPosX || load(yPosPtr) != targetPosY)
    return 0
  
  store(0x13C038 + otherId * 4, 0)
  return 1
}

0x000b56f4 lui t2,0x8014
0x000b56f8 addu t0,a1,r0
0x000b56fc sll v1,a1,0x02
0x000b5700 addu a1,v1,r0
0x000b5704 addiu t2,t2,0xc038
0x000b5708 addu v1,t2,v1
0x000b570c lh v0,0x0010(sp)
0x000b5710 lw t1,0x0000(v1)
0x000b5714 nop
0x000b5718 bne t1,r0,0x000b5798
0x000b571c nop
0x000b5720 sll t1,a0,0x04
0x000b5724 add t1,t1,a0
0x000b5728 sll t2,t1,0x01
0x000b572c lui t1,0x8015
0x000b5730 addiu t1,t1,0xf342
0x000b5734 addu t1,t1,t2
0x000b5738 lh t1,0x0000(t1)
0x000b573c addu t3,t2,r0
0x000b5740 sub t1,a3,t1
0x000b5744 div t1,a2
0x000b5748 addu t2,a2,r0
0x000b574c lui a2,0x8014
0x000b5750 addiu a2,a2,0xcb38
0x000b5754 mflo t1
0x000b5758 addu a2,a2,t0
0x000b575c sb t1,0x0000(a2)
0x000b5760 lui a2,0x8015
0x000b5764 addiu a2,a2,0xf344
0x000b5768 addu a2,a2,t3
0x000b576c lh a2,0x0000(a2)
0x000b5770 nop
0x000b5774 sub a2,v0,a2
0x000b5778 div a2,t2
0x000b577c lui a2,0x8014
0x000b5780 addiu a2,a2,0xcb44
0x000b5784 mflo t1
0x000b5788 addu a2,a2,t0
0x000b578c sb t1,0x0000(a2)
0x000b5790 addiu a2,r0,0x0001
0x000b5794 sw a2,0x0000(v1)
0x000b5798 lui v1,0x8014
0x000b579c addiu v1,v1,0xcb38
0x000b57a0 addu v1,v1,t0
0x000b57a4 lb t3,0x0000(v1)
0x000b57a8 sll v1,a0,0x04
0x000b57ac add v1,v1,a0
0x000b57b0 sll v1,v1,0x01
0x000b57b4 lui a0,0x8015
0x000b57b8 addu a2,v1,r0
0x000b57bc addiu a0,a0,0xf342
0x000b57c0 addu v1,a0,v1
0x000b57c4 lh t2,0x0000(v1)
0x000b57c8 addu t1,t3,r0
0x000b57cc add t2,t2,t3
0x000b57d0 sh t2,0x0000(v1)
0x000b57d4 lui t2,0x8014
0x000b57d8 addiu t2,t2,0xcb44
0x000b57dc addu t0,t2,t0
0x000b57e0 lb t3,0x0000(t0)
0x000b57e4 lui t0,0x8015
0x000b57e8 addiu t0,t0,0xf344
0x000b57ec addu t2,t0,a2
0x000b57f0 lh t0,0x0000(t2)
0x000b57f4 addu t4,t3,r0
0x000b57f8 add t0,t0,t3
0x000b57fc blez t1,0x000b5824
0x000b5800 sh t0,0x0000(t2)
0x000b5804 addu t0,v1,r0
0x000b5808 lh t0,0x0000(t0)
0x000b580c nop
0x000b5810 slt asmTemp,t0,a3
0x000b5814 bne asmTemp,r0,0x000b5850
0x000b5818 nop
0x000b581c beq r0,r0,0x000b5850
0x000b5820 sh a3,0x0000(v1)
0x000b5824 bgez t1,0x000b584c
0x000b5828 nop
0x000b582c addu t0,v1,r0
0x000b5830 lh t0,0x0000(t0)
0x000b5834 nop
0x000b5838 slt asmTemp,a3,t0
0x000b583c bne asmTemp,r0,0x000b5850
0x000b5840 nop
0x000b5844 beq r0,r0,0x000b5850
0x000b5848 sh a3,0x0000(v1)
0x000b584c sh a3,0x0000(v1)
0x000b5850 blez t4,0x000b5880
0x000b5854 nop
0x000b5858 lui t0,0x8015
0x000b585c addiu t0,t0,0xf344
0x000b5860 addu a0,t0,a2
0x000b5864 lh v1,0x0000(a0)
0x000b5868 nop
0x000b586c slt asmTemp,v1,v0
0x000b5870 bne asmTemp,r0,0x000b58c0
0x000b5874 nop
0x000b5878 beq r0,r0,0x000b58c0
0x000b587c sh v0,0x0000(a0)
0x000b5880 bgez t4,0x000b58b0
0x000b5884 nop
0x000b5888 lui t0,0x8015
0x000b588c addiu t0,t0,0xf344
0x000b5890 addu a0,t0,a2
0x000b5894 lh v1,0x0000(a0)
0x000b5898 nop
0x000b589c slt asmTemp,v0,v1
0x000b58a0 bne asmTemp,r0,0x000b58c0
0x000b58a4 nop
0x000b58a8 beq r0,r0,0x000b58c0
0x000b58ac sh v0,0x0000(a0)
0x000b58b0 lui v1,0x8015
0x000b58b4 addiu v1,v1,0xf344
0x000b58b8 addu v1,v1,a2
0x000b58bc sh v0,0x0000(v1)
0x000b58c0 lui v1,0x8015
0x000b58c4 addiu v1,v1,0xf342
0x000b58c8 addu v1,v1,a2
0x000b58cc lh v1,0x0000(v1)
0x000b58d0 nop
0x000b58d4 bne v1,a3,0x000b5910
0x000b58d8 nop
0x000b58dc lui v1,0x8015
0x000b58e0 addiu v1,v1,0xf344
0x000b58e4 addu v1,v1,a2
0x000b58e8 lh v1,0x0000(v1)
0x000b58ec nop
0x000b58f0 bne v1,v0,0x000b5910
0x000b58f4 nop
0x000b58f8 lui v0,0x8014
0x000b58fc addiu v0,v0,0xc038
0x000b5900 addu v0,v0,a1
0x000b5904 sw r0,0x0000(v0)
0x000b5908 beq r0,r0,0x000b5914
0x000b590c addiu v0,r0,0x0001
0x000b5910 addu v0,r0,r0
0x000b5914 jr ra
0x000b5918 nop