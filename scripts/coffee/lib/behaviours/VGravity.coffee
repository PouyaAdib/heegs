_Module = require '../core/_Module'

module.exports = class VGravity extends _Module

	self = @

	@c = 1e-6
	@x = 0

	constructor: ->

		@_setDefaultValues()

	_setDefaultValues: ->

		@props = new Float32Array [1, self.x]
		@c = self.c

	setIntensity: (n) ->

		@props[0] = n

	setX: (x) ->

		@props[1] = x

	update: (dt, x, y, z, vx, vy, vz, data, offset) ->

		f = @c * (@props[1] - x) * @props[0]

		data[offset] += f


