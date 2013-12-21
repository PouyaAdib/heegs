_Module = require '../core/_Module'

module.exports = class HGravity extends _Module

	@g = .000001
	@y = 0
	@range = 100

	constructor: ->

		@_setDefaultValues()

	_setDefaultValues: ->

		@g = HGravity.g
		@y = HGravity.y
		@range = HGravity.range

	setIntensity: (n) ->

		@g = n * HGravity.g

	setY: (@y) ->

	setRange: (@range) ->

	update: (dt, x, y, data, offset) ->

		if 0 < Math.abs(@y - y) < @range

			f = (@y - y) * @g

			data[offset + 7] += f

