import particleAPI, {IParticleAPI} from './particleAPI'

class Engine {
  numberOfParticles: number
  uint8ViewOnPositionData: Uint8Array
  positionData: Float32Array
  physicsData: Float32Array

  constructor(numberOfParticles: number) {
    this.numberOfParticles = numberOfParticles

    this.initializeEngine()
  }

  private initializeEngine() {
    const positionBuffer = new ArrayBuffer(this.numberOfParticles * 2 * 4)
    const physicsBuffer = new ArrayBuffer(this.numberOfParticles * 5 * 4)

    this.uint8ViewOnPositionData = new Uint8Array(positionBuffer)
    this.positionData = new Float32Array(positionBuffer)
    this.physicsData = new Float32Array(physicsBuffer)

    // set mass of all particles to 1
    for (let i = 0; i < this.numberOfParticles; i++) {
      this.physicsData[i * 5] = 1
    }
  }

  setParticlesParams = (cb: (index: number, api: IParticleAPI) => void) => {
    for (let i = 0; i < this.numberOfParticles; i++) {
      const api = particleAPI(i, this.positionData, this.physicsData)
      cb(i, api)
    }
  }
}

export default Engine
