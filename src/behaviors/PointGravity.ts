import {IBehavior} from './types'

class PointGravity implements IBehavior {
  x: number
  y: number
  c: number

  static c = 0.0000001

  constructor() {
    this.x = 0
    this.y = 0
    this.c = PointGravity.c
  }

  setIntensity(n: number) {
    this.c = n * PointGravity.c
  }

  setCenter(x: number, y: number) {
    this.x = x
    this.y = y
  }

  update(_, x: number, y: number, data: Float32Array, offset: number) {
    const dx = this.x - x
    const dy = this.y - y
    const distanceFactor = (dx ** 2 + dy ** 2) ** 1.5

    const fx = this.c * dx / distanceFactor
    const fy = this.c * dy / distanceFactor

    data[offset + 2] += fx
    data[offset + 3] += fy
  }
}

export default PointGravity
