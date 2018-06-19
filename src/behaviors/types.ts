import Drag from './Drag'

export type TBehavior = Drag

export interface IBehavior {
  update: (dt: number, x: number, y: number, data: Float32Array, offset: number) => void
}
