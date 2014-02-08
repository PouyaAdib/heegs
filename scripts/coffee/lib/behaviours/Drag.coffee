_Module = require '../core/_Module'
MT = require '../tools/MathTools'

module.exports = class Drag extends _Module

	self = @

	@c = 1e-4

	constructor: ->

		@_setDefaultValues()

	_setDefaultValues: ->

		@props = new Float32Array [1, 1]
		@c = self.c

	setIntensity: (n, m) ->

		@props[0] = n
		@props[1] = m

	update: (dt, x, y, z, vx, vy, vz, data, offset) ->

		fx = - @c * ( @props[0] + Math.random() * @props[1] ) * vx
		fy = - @c * ( @props[0] + Math.random() * @props[1] ) * vy

		data[offset] += fx
		data[offset + 1] += fy