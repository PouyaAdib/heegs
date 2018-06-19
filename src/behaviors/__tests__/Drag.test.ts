import * as tape from 'tape'
import Heegs from '../../core/Engine'
import Drag from '../Drag'

tape('Drag with no random coeff', (t: tape.Test) => {
  const h = new Heegs(1)
  const d = h.addBehavior(Drag)
  d.setIntensity(1, 0)
  h.setParticlesParams((_, {setPosition, setVelocity}) => {
    setPosition(100, 50)
    setVelocity(10, 5)
  })
  h.start(0)
  h.update(16)

  t.deepEqual(h.positionData, new Float32Array([-1020, -510]))
  t.deepEqual(h.physicsData, new Float32Array([-150, -75, 0, 0, 1]))

  t.end()
})

tape('Drag with random coeff', (t: tape.Test) => {
  const h = new Heegs(1)
  const d = h.addBehavior(Drag)
  d.setIntensity(1, 1)
  h.setParticlesParams((_, {setPosition, setVelocity}) => {
    setPosition(100, 50)
    setVelocity(10, 5)
  })
  h.start(0)
  h.update(16)

  t.true(h.positionData[0] < -1020)
  t.true(h.positionData[1] < -510)
  t.true(h.physicsData[0] < -150)
  t.true(h.physicsData[1] < -75)

  t.end()
})
