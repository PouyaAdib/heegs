import Drag from './Drag'
import Sink from './Sink'
import HorizontalForce from './HorizontalForce'
import PointGravity from './PointGravity'
import VerticalForce from './VerticalForce'

export type TBehavior = Drag | Sink | HorizontalForce | PointGravity | VerticalForce


export interface IBehavior {
  update: (dt: number, x: number, y: number, data: Float32Array, offset: number) => void
}
