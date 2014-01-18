_Module = require '../core/_Module'
{sign} = require '../tools/MathTools'

module.exports = class GravityField extends _Module

	self = @

	@g = 1
	@x = 0
	@y = 0

	constructor: ->

		@_setDefaultValues()

	_setDefaultValues: ->

		@props = new Float32Array [self.g, self.x, self.y]

	setG: (n) ->

		@props[0] = n * self.g

	setCenter: (x, y) ->

		@props[1] = x
		@props[2] = y

	# setRadius: (radius) ->

	# 	@radiusSQ = @radius * @radius

	update: (dt, x, y, z, vx, vy, vz, data, offset) ->

		dx = @props[1] - x; dy = @props[2] - y
		dx2 = dx * dx
		dy2 = dy * dy

		d = dx2 + dy2

		# if 0 < d <= @radiusSQ

		fx = 1e-6 * sign(dx) * @props[0] / d / (Math.sqrt(1 + (dy / dx) * (dy / dx)))
		fy = 1e-6 * sign(dy) * @props[0] / d / (Math.sqrt(1 + (dx / dy) * (dx / dy)))

		data[offset] += fx
		data[offset + 1] += fy

		return