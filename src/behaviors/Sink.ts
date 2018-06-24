import {IBehavior} from './types'

class Sink implements IBehavior {
  x: number
  y: number
  c: number

  static c = 0.0000001

  constructor() {
    this.x = 0
    this.y = 0
    this.c = Sink.c
  }

  setIntensity(n: number) {
    this.c = n * Sink.c
  }

  setCenter(x: number, y: number) {
    this.x = x
    this.y = y
  }

  update(_: number, x: number, y: number, data: Float32Array, offset: number) {
    const dx = this.x - x
    const dy = this.y - y
    const distance = Math.sqrt(dx ** 2 + dy ** 2)

    const fx = this.c * dx * distance
    const fy = this.c * dy * distance

    data[offset + 2] += fx
    data[offset + 3] += fy
  }
}

export default Sink
