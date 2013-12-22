_Module = require '../core/_Module'
MT = require '../tools/MathTools'

module.exports = class Drag extends _Module

	@sb = 0.000001
	@db = 0.000001

	constructor: ->

		@_setDefaultValues()

	_setDefaultValues: ->

		@sb = Drag.sb
		@db = Drag.db

	setIntensity: (n, m) ->

		@sb = n * Drag.sb
		@db = m * Drag.db

	update: (dt, x, y, data, offset) ->

		vx = data[offset + 0]
		vy = data[offset + 1]

		fx = - ( @sb + Math.random() * @db ) * vx
		fy = - ( @sb + Math.random() * @db ) * vy

		data[offset + 3] += fx
		data[offset + 4] += fy