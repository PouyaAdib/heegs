export const euler = {
  update(
    dt: number,
    x: number,
    y: number,
    positionData: Float32Array,
    positionOffset: number,
    physicsData: Float32Array,
    physicsOffset: number,
  ) {
    let v_x = physicsData[physicsOffset]
    let v_y = physicsData[physicsOffset + 1]
    const f_x = physicsData[physicsOffset + 2]
    const f_y = physicsData[physicsOffset + 3]
    const m = physicsData[physicsOffset + 4]

    const a_x = f_x / m
    const a_y = f_y / m

    const dt2 = dt * dt
    x = 0.5 * a_x * dt2 + v_x * dt + x
    y = 0.5 * a_y * dt2 + v_y * dt + y
    v_x = a_x * dt + v_x
    v_y = a_y * dt + v_y

    positionData[positionOffset] = x
    positionData[positionOffset + 1] = y
    physicsData[physicsOffset] = v_x
    physicsData[physicsOffset + 1] = v_y
  },
}
