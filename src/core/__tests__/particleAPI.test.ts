import * as tape from 'tape'
import particleAPI from '../particleApi'

tape('particleAPI', (t: tape.Test) => {
  const positionData = new Float32Array(4)
  const physicsData = new Float32Array(10)

  const apiForIndex0 = particleAPI(0, positionData, physicsData)
  const apiForIndex1 = particleAPI(1, positionData, physicsData)

  apiForIndex0.setMass(1)
  apiForIndex0.setPosition(2, 3)
  apiForIndex0.setVelocity(4, 5)
  apiForIndex1.setMass(6)
  apiForIndex1.setPosition(7, 8)
  apiForIndex1.setVelocity(9, 10)

  t.deepEqual(positionData, new Float32Array([2, 3, 7, 8]), 'saves position data at the right indices')
  t.deepEqual(physicsData, new Float32Array([4, 5, 0, 0, 1, 9, 10, 0, 0, 6]), 'saves physics data at the right indices')

  t.end()
})

