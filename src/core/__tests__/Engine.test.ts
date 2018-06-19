import * as tape from 'tape'
import Heegs from '../Engine'

class DummyBehavior {
  update(_, __, ___, data: Float32Array, offset: number) {
    data[offset + 2] += 2
    data[offset + 3] += 3
  }
}

tape('Engine', (t: tape.Test) => {
  const h = new Heegs(2)

  t.deepEqual(
    h.positionData,
    new Float32Array([0, 0, 0, 0]),
    'should initialize positionData correctly',
  )
  t.deepEqual(
    h.physicsData,
    new Float32Array([0, 0, 0, 0, 1, 0, 0, 0, 0, 1]),
    'should initialize physicsData correctly',
  )

  h.setParticlesParams((index, {setMass, setPosition, setVelocity}) => {
    setMass(index + 2)
    setPosition(index + 3, index + 4)
    setVelocity(index + 5, index + 6)
  })

  t.deepEqual(
    h.positionData,
    new Float32Array([3, 4, 4, 5]),
    'should set positionData correctly',
  )
  t.deepEqual(
    h.physicsData,
    new Float32Array([5, 6, 0, 0, 2, 6, 7, 0, 0, 3]),
    'should set physicsData correctly',
  )

  const d = h.addBehavior(DummyBehavior)
  // @ts-ignore
  t.equal(h.behaviors.length, 1, 'should add behavior correctly')

  h.removeBehavior(d)
  // @ts-ignore
  t.equal(h.behaviors.length, 0, 'should remove behavior correctly')

  const h2 = new Heegs(1)
  h2.addBehavior(DummyBehavior)
  h2.start(0)
  h2.update(16)
  h2.update(32)

  t.deepEqual(h2.positionData, [1024, 1536], 'should update positionData correctly')
  t.deepEqual(h2.physicsData, [64, 96, 0, 0, 1], 'should update physicsData correctly')

  t.end()
})
