_Module = require '../core/_Module'
{sign} = require '../tools/MathTools'

module.exports = class Sink extends _Module

	self = @

	@x = 0
	@y = 0
	@c = 1e-8

	constructor: ->

		@_setDefaultValues()

	_setDefaultValues: ->

		@props = new Float32Array [0, self.x, self.y]
		@c = self.c

	setCenter: (x, y) ->

		@props[1] = x
		@props[2] = y

	setIntensity: (n) ->

		@props[0] = n

	update: (dt, x, y, z, vx, vy, vz, data, offset) ->

		dx = @props[1] - x
		dy = @props[2] - y
		dx2 = dx * dx
		dy2 = dy * dy

		fx = @c * sign(dx) * @props[0] * (dx2 + dy2) / (Math.sqrt(1 + (dy / dx) * (dy / dx)))
		fy = @c * sign(dy) * @props[0] * (dx2 + dy2) / (Math.sqrt(1 + (dx / dy) * (dx / dy)))

		data[offset] += fx
		data[offset + 1] += fy