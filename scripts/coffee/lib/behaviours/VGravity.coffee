_Module = require '../core/_Module'

module.exports = class HGravity extends _Module

	@g = .000001
	@x = 0
	@range = 100

	constructor: ->

		@_setDefaultValues()

	_setDefaultValues: ->

		@g = HGravity.g
		@x = HGravity.x
		@range = HGravity.range

	setIntensity: (n) ->

		@g = n * HGravity.g

	setX: (@x) ->

	setRange: (@range) ->

	update: (dt, x, y, data, offset) ->

		if 0 < Math.abs(@x - x) < @range

			f = (@x - x) * @g

			data[offset + 6] += f


