_Module = require '../core/_Module'

module.exports = class Euler extends _Module

	update: (dt, x, y, physData, physOffset, posData, posOffset) ->

		m = physData[physOffset + 6]
		vx = physData[physOffset + 0]
		vy = physData[physOffset + 1]
		fx = physData[physOffset + 3]
		fy = physData[physOffset + 4]

		aX = fx / m
		aY = fy / m

		x = .5 * aX * Math.pow(dt, 2) + vx * dt + x
		y = .5 * aY * Math.pow(dt, 2) + vy * dt + y

		vx = aX * dt + vx
		vy = aY * dt + vy

		posData[posOffset] = x
		posData[posOffset + 1] = y
		physData[physOffset + 0] = vx
		physData[physOffset + 1] = vy

		return