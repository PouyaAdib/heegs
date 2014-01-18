_Module = require '../core/_Module'

module.exports = class HGravity extends _Module

	self = @

	@g = .000001
	@y = 0
	# @range = 100

	constructor: ->

		@_setDefaultValues()

	_setDefaultValues: ->

		@props = new Float32Array [self.g, self.y]

	setIntensity: (n) ->

		@props[0] = n * self.g

	setY: (y) ->

		@props[1] = y

	# setRange: (@range) ->

	update: (dt, x, y, z, vx, vy, vz, data, offset) ->

		# if 0 < Math.abs(@y - y) < @range

		f = (@props[1] - y) * @props[0]

		data[offset + 1] += f

