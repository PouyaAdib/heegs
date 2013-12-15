_Module = require '../core/_Module'
MT = require '../tools/MathTools'

module.exports = class Drag extends _Module

	@b = 0.00001

	constructor: ->

		@_setDefaultValues()

	_setDefaultValues: ->

		@b = Drag.b

	setIntensity: (n) ->

		@b = n * Drag.b

	update: (dt, data, offset) ->

		vx = data[offset + 3]
		vy = data[offset + 4]

		fx = - @b * vx + Math.random() / 1000000
		fy = - @b * vy + Math.random() / 1000000

		data[offset + 6] += fx
		data[offset + 7] += fy