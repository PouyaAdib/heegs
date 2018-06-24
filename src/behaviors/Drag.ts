import {IBehavior} from './types'

class Drag implements IBehavior {
  fixedCoeff: number
  randomCoeff: number

  static fc = 0.000001
  static rc = 0.0001

  constructor() {
    this.fixedCoeff = Drag.fc
    this.randomCoeff = Drag.rc
  }

  setIntensity(fixedCoeff: number, randomCoeff: number) {
    this.fixedCoeff = Drag.fc * fixedCoeff
    this.randomCoeff = Drag.rc * randomCoeff
  }

  update(_: number, __: number, ___: number, data: Float32Array, offset: number) {
    const vx = data[offset]
    const vy = data[offset + 1]

    const fx = -(this.fixedCoeff + Math.random() * this.randomCoeff) * vx
    const fy = -(this.fixedCoeff + Math.random() * this.randomCoeff) * vy

    data[offset + 2] += fx
    data[offset + 3] += fy
  }
}

export default Drag
