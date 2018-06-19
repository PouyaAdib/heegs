import {IBehavior} from './types'

class Drag implements IBehavior {
  fixedCoeff: number
  randomCoeff: number

  constructor() {
    this.fixedCoeff = 0.000001
    this.randomCoeff = 0.000001
  }

  setIntensity(fixedCoeff: number, randomCoeff: number) {
    this.fixedCoeff = fixedCoeff
    this.randomCoeff = randomCoeff
  }

  update(_, __, ___, data: Float32Array, offset: number) {
    const vx = data[offset]
    const vy = data[offset + 1]

    const fx = -(this.fixedCoeff + Math.random() * this.randomCoeff) * vx
    const fy = -(this.fixedCoeff + Math.random() * this.randomCoeff) * vy

    data[offset + 2] += fx
    data[offset + 3] += fy
  }
}

export default Drag
