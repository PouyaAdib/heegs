_Module = require '../core/_Module'

module.exports = class Euler extends _Module

	update: (dt, particle) ->

		p = particle.position.v
		v = particle.velocity.v
		f = particle.force.v
		m = particle.mass

		aX = f[0] / m
		aY = f[1] / m

		x = .5 * aX * Math.pow(dt, 2) + v[0] * dt + p[0]
		y = .5 * aY * Math.pow(dt, 2) + v[1] * dt + p[1]

		vx = aX * dt + v[0]
		vy = aY * dt + v[1]

		particle.position.set x, y
		particle.velocity.set vx, vy

		return