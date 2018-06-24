import {IBehavior} from './types'

class VerticalGravity implements IBehavior {
  x: number
  c: number

  static c = 0.0000001

  constructor() {
    this.x = 0
    this.c = VerticalGravity.c
  }

  setIntensity(n: number) {
    this.c = n * VerticalGravity.c
  }

  setX(x: number) {
    this.x = x
  }

  update(_: number, x: number, __: number, data: Float32Array, offset: number) {
    data[offset + 2] += (this.x - x) * this.c
  }
}

export default VerticalGravity
