_Module = require '../core/_Module'
{sign} = require '../tools/MathTools'

module.exports = class Sink extends _Module

	self = @

	@x = 0
	@y = 0
	@c = .00000001

	constructor: ->

		@_setDefaultValues()

	_setDefaultValues: ->

		@props = new Float32Array [self.c, self.x, self.y]

	# setCenter: (@x, @y) ->

	# setIntensity: (n) ->

	# 	@c = n * Sink.c

	update: (dt, x, y, z, vx, vy, vz, data, offset) ->

		dx = @props[1] - x
		dy = @props[2] - y
		dx2 = dx * dx
		dy2 = dy * dy

		fx = 1e-6 * sign(dx) * @props[0] * (dx2 + dy2) / (Math.sqrt(1 + (dy / dx) * (dy / dx)))
		fy = 1e-6 * sign(dy) * @props[0] * (dx2 + dy2) / (Math.sqrt(1 + (dx / dy) * (dx / dy)))

		data[offset] += fx
		data[offset + 1] += fy