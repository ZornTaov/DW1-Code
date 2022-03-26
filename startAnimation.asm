/**
 * Starts playing an animation with a given ID for the given entity. (probably)
 */
void startAnimation(int entityPtr, int animId) {
  animTablePtr = load(entityPtr + 0x08)
  animPtr = load(animTablePtr + animId * 4)
  
  if(animPtr == 0)
    return
  
  animHead = animTablePtr + animPtr
  digimonType = load(entityPtr)
  nodePtr = load(entityPtr + 0x04)
  nodeCount = load(0x12CEC8 + digimonType * 52) & 0xFF
  
  entityType = getEntityType(entityPtr)
  modelComponent = getDigimonModelComponent(digimonType, entityType)
  
  unknownValue1 = (load(modelComponent + 0x10) - 0x10) * 64
  unknownValue2 = load(modelComponent + 0x15) + 0x100
  frameCount = load(animHead)
  
  store(entityPtr + 0x1C, 1) // anim frame
  store(entityPtr + 0x1E, frameCount)
  store(entityPtr + 0x28, 1) // another anim frame
  store(entityPtr + 0x2A, unknownValue1)
  store(entityPtr + 0x2C, unknownValue2)
  store(entityPtr + 0x2E, animId)
  store(entityPtr + 0x2F, 0)
  store(entityPtr + 0x30, 1)
  
  momentumPtr = load(entityPtr + 0x0C)
  animInstrPtr = animHead + 2
    
  locX = load(nodePtr + 0x78) << 0x0F
  locY = load(nodePtr + 0x7C) << 0x0F
  locZ = load(nodePtr + 0x80) << 0x0F
  
  store(entityPtr + 0x10, locX)
  store(entityPtr + 0x14, locY)
  store(entityPtr + 0x18, locZ)
  
  setZero36Offset18(momentumPtr)
  setupModelMatrix(nodePtr)
  
  // initial positions for each node
  for(int i = 1; i < nodeCount; i++  nodePtr + 0x88) {
    localNodePtr = nodePtr + i * 0x88
    
    if(frameCount & 0x8000 == 0) {
      store(localNodePtr + 0x60, 0x1000)
      store(localNodePtr + 0x64, 0x1000)
      store(localNodePtr + 0x68, 0x1000)
    }
    else {
      store(localNodePtr + 0x60, load(animInstrPtr))
      animInstrPtr = animInstrPtr + 0x02
      store(localNodePtr + 0x64, load(animInstrPtr))
      animInstrPtr = animInstrPtr + 0x02
      store(localNodePtr + 0x68, load(animInstrPtr))
      animInstrPtr = animInstrPtr + 0x02
    }
    
    store(localNodePtr + 0x70, load(animInstrPtr))
    animInstrPtr = animInstrPtr + 0x02
    store(localNodePtr + 0x72, load(animInstrPtr))
    animInstrPtr = animInstrPtr + 0x02
    store(localNodePtr + 0x74, load(animInstrPtr))
    animInstrPtr = animInstrPtr + 0x02
    store(localNodePtr + 0x78, load(animInstrPtr))
    animInstrPtr = animInstrPtr + 0x02
    store(localNodePtr + 0x7C, load(animInstrPtr))
    animInstrPtr = animInstrPtr + 0x02
    store(localNodePtr + 0x80, load(animInstrPtr))
    animInstrPtr = animInstrPtr + 0x02
    
    setZero36Offset18(momentumPtr + 0x52 * i)
    setupModelMatrix(localNodePtr)
  }
  
  store(entitiyPtr + 0x20, animInstrPtr)
}

0x000c1a04 addiu sp,sp,0xffd0
0x000c1a08 sw ra,0x002c(sp)
0x000c1a0c sw s6,0x0028(sp)
0x000c1a10 sw s5,0x0024(sp)
0x000c1a14 sw s4,0x0020(sp)
0x000c1a18 sw s3,0x001c(sp)
0x000c1a1c sw s2,0x0018(sp)
0x000c1a20 sw s1,0x0014(sp)
0x000c1a24 addu s3,a1,r0
0x000c1a28 sw s0,0x0010(sp)
0x000c1a2c addu s2,a0,r0
0x000c1a30 lw v1,0x0008(s2)
0x000c1a34 sll v0,s3,0x02
0x000c1a38 addu v0,v1,v0
0x000c1a3c lw v0,0x0000(v0)
0x000c1a40 nop
0x000c1a44 beq v0,r0,0x000c1c3c
0x000c1a48 addu a1,v0,r0
0x000c1a4c addu s0,v1,a1
0x000c1a50 lw v1,0x0000(s2)
0x000c1a54 lw s1,0x0004(s2)
0x000c1a58 sll v0,v1,0x01
0x000c1a5c add v0,v0,v1
0x000c1a60 sll v0,v0,0x02
0x000c1a64 add v0,v0,v1
0x000c1a68 sll v1,v0,0x02
0x000c1a6c lui v0,0x8013
0x000c1a70 addiu v0,v0,0xcec8
0x000c1a74 addu v0,v0,v1
0x000c1a78 lw v0,0x0000(v0)
0x000c1a7c addiu s4,s2,0x000c
0x000c1a80 jal 0x000a2660
0x000c1a84 andi s5,v0,0x00ff
0x000c1a88 lw a0,0x0000(s2)
0x000c1a8c jal 0x000a254c
0x000c1a90 addu a1,v0,r0
0x000c1a94 lhu v1,0x0010(v0)
0x000c1a98 addiu s6,r0,0x0001
0x000c1a9c addi v1,v1,-0x0010
0x000c1aa0 sll v1,v1,0x06
0x000c1aa4 sh v1,0x001e(s4)
0x000c1aa8 lbu v0,0x0015(v0)
0x000c1aac addiu v1,s0,0x0002
0x000c1ab0 addi v0,v0,0x0100
0x000c1ab4 sh v0,0x0020(s4)
0x000c1ab8 sh s6,0x001c(s4)
0x000c1abc sb s3,0x0022(s4)
0x000c1ac0 addu v0,s6,r0
0x000c1ac4 sh v0,0x0010(s4)
0x000c1ac8 addu v0,s6,r0
0x000c1acc sb v0,0x0024(s4)
0x000c1ad0 sb r0,0x0023(s4)
0x000c1ad4 lh v0,0x0000(s0)
0x000c1ad8 lw s3,0x0000(s4)
0x000c1adc sh v0,0x0012(s4)
0x000c1ae0 lh v0,0x0012(s4)
0x000c1ae4 nop
0x000c1ae8 andi v0,v0,0x8000
0x000c1aec beq v0,r0,0x000c1afc
0x000c1af0 addu s0,v1,r0
0x000c1af4 beq r0,r0,0x000c1b04
0x000c1af8 lh v0,0x0012(s4)
0x000c1afc addu s6,r0,r0
0x000c1b00 lh v0,0x0012(s4)
0x000c1b04 addiu v1,s1,0x0078
0x000c1b08 andi v0,v0,0x7fff
0x000c1b0c sh v0,0x0012(s4)
0x000c1b10 lw v0,0x0000(v1)
0x000c1b14 nop
0x000c1b18 sll v0,v0,0x0f
0x000c1b1c sw v0,0x0004(s4)
0x000c1b20 lw v0,0x0004(v1)
0x000c1b24 nop
0x000c1b28 sll v0,v0,0x0f
0x000c1b2c sw v0,0x0008(s4)
0x000c1b30 lw v0,0x0008(v1)
0x000c1b34 nop
0x000c1b38 sll v0,v0,0x0f
0x000c1b3c sw v0,0x000c(s4)
0x000c1b40 jal 0x000c1798
0x000c1b44 addu a0,s3,r0
0x000c1b48 addiu s3,s3,0x0052
0x000c1b4c jal 0x000c19a4
0x000c1b50 addu a0,s1,r0
0x000c1b54 addiu s1,s1,0x0088
0x000c1b58 beq r0,r0,0x000c1c2c
0x000c1b5c addiu s2,r0,0x0001
0x000c1b60 bne s6,r0,0x000c1b80
0x000c1b64 nop
0x000c1b68 addiu v1,r0,0x1000
0x000c1b6c sw v1,0x0060(s1)
0x000c1b70 addu v0,v1,r0
0x000c1b74 sw v0,0x0064(s1)
0x000c1b78 beq r0,r0,0x000c1bb0
0x000c1b7c sw v1,0x0068(s1)
0x000c1b80 lh v0,0x0000(s0)
0x000c1b84 addiu v1,s0,0x0002
0x000c1b88 addu s0,v1,r0
0x000c1b8c sw v0,0x0060(s1)
0x000c1b90 lh v0,0x0000(s0)
0x000c1b94 addiu v1,s0,0x0002
0x000c1b98 addu s0,v1,r0
0x000c1b9c sw v0,0x0064(s1)
0x000c1ba0 lh v0,0x0000(s0)
0x000c1ba4 addiu v1,s0,0x0002
0x000c1ba8 addu s0,v1,r0
0x000c1bac sw v0,0x0068(s1)
0x000c1bb0 lh v0,0x0000(s0)
0x000c1bb4 addiu v1,s0,0x0002
0x000c1bb8 addu s0,v1,r0
0x000c1bbc sh v0,0x0070(s1)
0x000c1bc0 lh v0,0x0000(s0)
0x000c1bc4 addiu v1,s0,0x0002
0x000c1bc8 addu s0,v1,r0
0x000c1bcc sh v0,0x0072(s1)
0x000c1bd0 lh v0,0x0000(s0)
0x000c1bd4 addiu v1,s0,0x0002
0x000c1bd8 addu s0,v1,r0
0x000c1bdc sh v0,0x0074(s1)
0x000c1be0 lh v0,0x0000(s0)
0x000c1be4 addiu v1,s0,0x0002
0x000c1be8 addu s0,v1,r0
0x000c1bec sw v0,0x0078(s1)
0x000c1bf0 lh v0,0x0000(s0)
0x000c1bf4 addiu v1,s0,0x0002
0x000c1bf8 addu s0,v1,r0
0x000c1bfc sw v0,0x007c(s1)
0x000c1c00 lh v0,0x0000(s0)
0x000c1c04 addiu v1,s0,0x0002
0x000c1c08 addu s0,v1,r0
0x000c1c0c sw v0,0x0080(s1)
0x000c1c10 jal 0x000c1798
0x000c1c14 addu a0,s3,r0
0x000c1c18 jal 0x000c19a4
0x000c1c1c addu a0,s1,r0
0x000c1c20 addi s2,s2,0x0001
0x000c1c24 addiu s3,s3,0x0052
0x000c1c28 addiu s1,s1,0x0088
0x000c1c2c slt asmTemp,s2,s5
0x000c1c30 bne asmTemp,r0,0x000c1b60
0x000c1c34 nop
0x000c1c38 sw s0,0x0014(s4)
0x000c1c3c lw ra,0x002c(sp)
0x000c1c40 lw s6,0x0028(sp)
0x000c1c44 lw s5,0x0024(sp)
0x000c1c48 lw s4,0x0020(sp)
0x000c1c4c lw s3,0x001c(sp)
0x000c1c50 lw s2,0x0018(sp)
0x000c1c54 lw s1,0x0014(sp)
0x000c1c58 lw s0,0x0010(sp)
0x000c1c5c jr ra
0x000c1c60 addiu sp,sp,0x0030
