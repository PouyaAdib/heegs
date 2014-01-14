_Module = require '../core/_Module'

module.exports = class Euler extends _Module

	update: (dt, x, y, z, vx, vy, vz, physData, physOffset, posData, velData, offset) ->

		m = physData[physOffset + 6]
		fx = physData[physOffset + 3]
		fy = physData[physOffset + 4]

		aX = fx / m
		aY = fy / m

		x = .5 * aX * Math.pow(dt, 2) + vx * dt + x
		y = .5 * aY * Math.pow(dt, 2) + vy * dt + y

		vx = aX * dt + vx
		vy = aY * dt + vy

		posData[offset] = x
		posData[offset + 1] = y
		velData[offset + 0] = vx
		velData[offset + 1] = vy

		return