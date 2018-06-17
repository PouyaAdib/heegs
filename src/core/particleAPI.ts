export interface IParticleAPI {
  setMass: (m: number) => void
  setPosition: (px: number, py: number) => void
  setVelocity: (vx: number, vy: number) => void
}

const particleAPI = (index: number, positionData: Float32Array, physicsData: Float32Array) => {
  const setMass: IParticleAPI['setMass'] = (m) => {
    physicsData[index * 5] = m
  }

  const setPosition: IParticleAPI['setPosition'] = (px, py) => {
    positionData[index * 2] = px
    positionData[index * 2 + 1] = py
  }

  const setVelocity: IParticleAPI['setVelocity'] = (vx: number, vy: number) => {
    physicsData[index * 5 + 1] = vx
    physicsData[index * 5 + 2] = vy
  }

  return {
    setMass,
    setPosition,
    setVelocity,
  }
}

export default particleAPI