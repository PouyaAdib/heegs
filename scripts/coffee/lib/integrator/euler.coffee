_Module = require '../core/_Module'

module.exports = class Euler extends _Module

	update: (dt, x, y, data, offset) ->

		m = data[offset + 9]
		vx = data[offset + 3]
		vy = data[offset + 4]
		fx = data[offset + 6]
		fy = data[offset + 7]

		aX = fx / m
		aY = fy / m

		x = .5 * aX * Math.pow(dt, 2) + vx * dt + x
		y = .5 * aY * Math.pow(dt, 2) + vy * dt + y

		vx = aX * dt + vx
		vy = aY * dt + vy

		data[offset] = x
		data[offset + 1] = y
		data[offset + 3] = vx
		data[offset + 4] = vy

		return