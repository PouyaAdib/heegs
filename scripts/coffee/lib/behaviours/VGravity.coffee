_Module = require '../core/_Module'

module.exports = class VGravity extends _Module

	self = @

	@g = .001
	@x = 0
	# @range = 100

	constructor: ->

		@_setDefaultValues()

	_setDefaultValues: ->

		# @g = self.g
		# @x = self.x
		# @range = self.range

		@props = new Float32Array [self.g, self.x]

	setIntensity: (n) ->

		@props[0] = n * self.g

	setX: (x) ->

		@props[1] = x

	update: (dt, x, y, z, vx, vy, vz, data, offset) ->

		f = (@props[1] - x) * @props[0]

		data[offset] += f


