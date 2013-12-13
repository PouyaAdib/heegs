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

	update: (dt, particle) ->

		v = particle.velocity.v

		fx = - @b * v[0] + Math.random() / 1000000
		fy = - @b * v[1] + Math.random() / 1000000

		particle.force.add fx, fy