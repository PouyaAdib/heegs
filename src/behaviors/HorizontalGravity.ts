import {IBehavior} from './types'

class HorizontalGravity implements IBehavior {
  y: number
  c: number

  static c = 0.0000001

  constructor() {
    this.y = 0
    this.c = HorizontalGravity.c
  }

  setIntensity(n: number) {
    this.c = n * HorizontalGravity.c
  }

  setY(y: number) {
    this.y = y
  }

  update(_, __, y: number, data: Float32Array, offset: number) {
    data[offset + 3] += (this.y - y) * this.c
  }
}

export default HorizontalGravity
