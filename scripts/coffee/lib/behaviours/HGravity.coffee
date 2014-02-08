_Module = require '../core/_Module'

module.exports = class HGravity extends _Module

	self = @

	@c = 1e-6
	@y = 0

	constructor: ->

		@_setDefaultValues()

	_setDefaultValues: ->

		@props = new Float32Array [0, self.y]
		@c = self.c

	setIntensity: (n) ->

		@props[0] = n

	setY: (y) ->

		@props[1] = y

	update: (dt, x, y, z, vx, vy, vz, data, offset) ->

		f = @c * (@props[1] - y) * @props[0]

		data[offset + 1] += f

