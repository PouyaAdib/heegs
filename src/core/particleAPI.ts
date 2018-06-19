export type TParticleAPI = {
  setMass: (m: number) => void
  setPosition: (px: number, py: number) => void
  setVelocity: (vx: number, vy: number) => void
}

const particleAPI = (index: number, positionData: Float32Array, physicsData: Float32Array): TParticleAPI => {
  const setMass: TParticleAPI['setMass'] = (m) => {
    physicsData[index * 5 + 4] = m
  }

  const setPosition: TParticleAPI['setPosition'] = (px, py) => {
    positionData[index * 2] = px
    positionData[index * 2 + 1] = py
  }

  const setVelocity: TParticleAPI['setVelocity'] = (vx, vy) => {
    physicsData[index * 5] = vx
    physicsData[index * 5 + 1] = vy
  }

  return {
    setMass,
    setPosition,
    setVelocity,
  }
}

export default particleAPI