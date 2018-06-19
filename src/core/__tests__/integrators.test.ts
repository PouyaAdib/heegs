import * as tape from 'tape'
import {euler} from '../integrators'

tape('euler', (t: tape.Test) => {
  const positionData = new Float32Array(2)
  const physicsData = new Float32Array([0, 0, 2, 3, 1])
  const dt = 16

  euler.update(dt, 0, 0, positionData, 0, physicsData, 0)
  euler.update(dt, positionData[0], positionData[1], positionData, 0, physicsData, 0)

  t.equal(positionData[0], 1024, 'calculates x correctly')
  t.equal(positionData[1], 1536, 'calculates y correctly')
  t.equal(physicsData[0], 64, 'calculates v_x correctly')
  t.equal(physicsData[1], 96, 'calculates v_y correctly')

  t.end()
})

