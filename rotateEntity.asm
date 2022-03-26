/**
 * Rotates an entity by a given rotation ptr to a certain target angle.
 * This function takes a angle difference in both directions and a step size as
 * parameters, to determine the direction it should rotate into.
 *
 * If the target angle is reached the function will return 1, otherwise 0.
 * Bug: If the rotational difference in both directions is the same, this
 *      function will never return 1 and softlock the game.
 */
int rotateEntity(rotationPtr, targetAngle, cClockwiseDiff, clockwiseDiff, rotationSpeed) {
  currentRotation = load(a0 + 0x02) // rotation
  
  if(currentRotation < targetAngle) {
    // Bug: No cClockwiseDiff == clockwiseDiff case
    if(cClockwiseDiff < clockwiseDiff) {
      newRotation = currentRotation - rotationSpeed
      store(rotationPtr + 0x02, newRotation)
      
      if(newRotation >= targetAngle - 0x1000)
        return 0
      
      store(rotationPtr + 0x02, targetAngle)
      return 1
    }
    else if(clockwiseDiff < cClockwiseDiff) {
      newRotation = currentRotation + rotationSpeed
      store(rotationPtr + 0x02, newRotation)
      
      if(targetAngle >= newRotation)
        return 0
      
      store(rotationPtr + 0x02, targetAngle)
      return 1
    }
  }
  else if(targetAngle < currentRotation) {
    // Bug: No cClockwiseDiff == clockwiseDiff case
    if(cClockwiseDiff < clockwiseDiff) {
      newRotation = currentRotation - rotationSpeed
      store(rotationPtr + 0x02, newRotation)
      
      if(newRotation >= targetAngle)
        return 0
      
      store(rotationPtr + 0x02, targetAngle)
      return 1
    }
    else if(clockwiseDiff < cClockwiseDiff) {
      newRotation = currentRotation + rotationSpeed
      store(rotationPtr + 0x02, newRotation)
      
      if(targetAngle + 0x1000 >= newRotation)
        return 0
      
      store(rotationPtr + 0x02, targetAngle)
      return 1
    }
  }
  else {
    store(rotationPtr + 0x02, targetAngle)
    return 1
  }
  
  return 0
}

0x000b6fb0 lh t0,0x0000(a2)
0x000b6fb4 lh v0,0x0000(a1)
0x000b6fb8 lh a2,0x0002(a0)
0x000b6fbc lh v1,0x0010(sp)
0x000b6fc0 addu a1,a2,r0
0x000b6fc4 lh a3,0x0000(a3)
0x000b6fc8 slt asmTemp,a1,v0
0x000b6fcc beq asmTemp,r0,0x000b703c
0x000b6fd0 addu t1,a1,r0
0x000b6fd4 slt asmTemp,t0,a3
0x000b6fd8 beq asmTemp,r0,0x000b7008
0x000b6fdc nop
0x000b6fe0 sub v1,a2,v1
0x000b6fe4 sh v1,0x0002(a0)
0x000b6fe8 lh v1,0x0002(a0)
0x000b6fec addi a1,v0,-0x1000
0x000b6ff0 slt asmTemp,v1,a1
0x000b6ff4 beq asmTemp,r0,0x000b70bc
0x000b6ff8 nop
0x000b6ffc sh v0,0x0002(a0)
0x000b7000 beq r0,r0,0x000b70c0
0x000b7004 addiu v0,r0,0x0001
0x000b7008 slt asmTemp,a3,t0
0x000b700c beq asmTemp,r0,0x000b70bc
0x000b7010 nop
0x000b7014 add v1,a2,v1
0x000b7018 sh v1,0x0002(a0)
0x000b701c lh v1,0x0002(a0)
0x000b7020 nop
0x000b7024 slt asmTemp,v0,v1
0x000b7028 beq asmTemp,r0,0x000b70bc
0x000b702c nop
0x000b7030 sh v0,0x0002(a0)
0x000b7034 beq r0,r0,0x000b70c0
0x000b7038 addiu v0,r0,0x0001
0x000b703c slt asmTemp,v0,t1
0x000b7040 beq asmTemp,r0,0x000b70b0
0x000b7044 nop
0x000b7048 slt asmTemp,t0,a3
0x000b704c beq asmTemp,r0,0x000b707c
0x000b7050 nop
0x000b7054 sub v1,a2,v1
0x000b7058 sh v1,0x0002(a0)
0x000b705c lh v1,0x0002(a0)
0x000b7060 nop
0x000b7064 slt asmTemp,v1,v0
0x000b7068 beq asmTemp,r0,0x000b70bc
0x000b706c nop
0x000b7070 sh v0,0x0002(a0)
0x000b7074 beq r0,r0,0x000b70c0
0x000b7078 addiu v0,r0,0x0001
0x000b707c slt asmTemp,a3,t0
0x000b7080 beq asmTemp,r0,0x000b70bc
0x000b7084 nop
0x000b7088 add v1,a2,v1
0x000b708c sh v1,0x0002(a0)
0x000b7090 lh v1,0x0002(a0)
0x000b7094 addi a1,v0,0x1000
0x000b7098 slt asmTemp,a1,v1
0x000b709c beq asmTemp,r0,0x000b70bc
0x000b70a0 nop
0x000b70a4 sh v0,0x0002(a0)
0x000b70a8 beq r0,r0,0x000b70c0
0x000b70ac addiu v0,r0,0x0001
0x000b70b0 sh v0,0x0002(a0)
0x000b70b4 beq r0,r0,0x000b70c0
0x000b70b8 addiu v0,r0,0x0001
0x000b70bc addu v0,r0,r0
0x000b70c0 jr ra
0x000b70c4 nop