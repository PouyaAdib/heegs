import particleAPI, {TParticleAPI} from './particleAPI'
import {TBehavior} from '../behaviors/types'
import {euler} from './integrators'

class Engine {
  positionData: Float32Array
  physicsData: Float32Array
  private numberOfParticles: number
  private behaviors: TBehavior[]
  private time: number

  constructor(numberOfParticles: number) {
    this.numberOfParticles = numberOfParticles
    this.behaviors = []

    this.initializeEngine()
  }

  private initializeEngine() {
    // positionBuffer holds [position_x, position_y] for all particles
    const positionBuffer = new ArrayBuffer(this.numberOfParticles * 2 * 4)
    // physicsBuffer holds [mass, velocity_x, velocity_y, force_x, force_y] for all particles
    const physicsBuffer = new ArrayBuffer(this.numberOfParticles * 5 * 4)

    // this.uint8ViewOnPositionData = new Uint8Array(positionBuffer)
    this.positionData = new Float32Array(positionBuffer)
    this.physicsData = new Float32Array(physicsBuffer)

    // set mass of all particles to 1
    for (let i = 0; i < this.numberOfParticles; i++) {
      this.physicsData[i * 5 + 4] = 1
    }
  }

  setParticlesParams(cb: (index: number, api: TParticleAPI) => void) {
    for (let i = 0; i < this.numberOfParticles; i++) {
      cb(i, particleAPI(i, this.positionData, this.physicsData))
    }
  }

  start(time: number) {
    this.time = time
  }

  update(time: number) {
    const dt = time - this.time
    this.time = time

    this.updateParticles(dt)
  }

  private updateParticles(dt: number) {
    for(let i = 0; i < this.numberOfParticles; i++) {
      const positionOffset = i * 2
      const physicsOffset = i * 5

      const x = this.positionData[positionOffset]
      const y = this.positionData[positionOffset + 1]

      this.behaviors.forEach((behavior) => {
        behavior.update(dt, x, y, this.physicsData, physicsOffset)
      })

      euler.update(dt, x, y, this.positionData, positionOffset, this.physicsData, physicsOffset)

      this.physicsData[physicsOffset + 2] = 0
      this.physicsData[physicsOffset + 3] = 0
    }
  }

  addBehavior(behavior: any) {
    const behaviorInstance = new behavior
    this.behaviors = this.behaviors.concat(behaviorInstance)
    return behaviorInstance
  }

  removeBehavior(behavior: any) {
    const index = this.behaviors.findIndex((b) => b === behavior)
    this.behaviors = this.behaviors.slice(0, index).concat(this.behaviors.slice(index + 1))
  }
}

export default Engine
