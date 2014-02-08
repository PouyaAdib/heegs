_Module = require '../core/_Module'
MT = require '../tools/MathTools'

module.exports = class Drag extends _Module

	self = @

	@sb = 0.00001
	@db = 0.00001

	constructor: ->

		@_setDefaultValues()

	_setDefaultValues: ->

		@props = new Float32Array [self.sb, self.db]

	setIntensity: (n, m) ->

		@props[0] = n * self.sb
		@props[1] = m * self.db

	update: (dt, x, y, z, vx, vy, vz, data, offset) ->

		fx = - ( @props[0] + Math.random() * @props[1] ) * vx
		fy = - ( @props[0] + Math.random() * @props[1] ) * vy

		data[offset] += fx
		data[offset + 1] += fy