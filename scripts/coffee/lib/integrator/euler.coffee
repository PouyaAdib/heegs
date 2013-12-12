_Module = require '../core/_Module'

module.exports = class Euler extends _Module

	update: (dt, particle) ->

		p = particle.position.get()
		v = particle.velocity.get()
		f = particle.force.get()
		m = particle.getMass()
		a = {x: f.x / m , y: f.y / m}

		x = .5 * a.x * Math.pow(dt, 2) + v.x * dt + p.x
		y = .5 * a.y * Math.pow(dt, 2) + v.y * dt + p.y

		vx = a.x * dt + v.x
		vy = a.y * dt + v.y

		particle.position.set x, y
		particle.velocity.set vx, vy
