_Module = require '../core/_Module'
MT = require '../tools/MathTools'

module.exports = class Source

	@x = 0
	@y = 0
	@c = .00000001

	constructor: ->

		@_setDefaultValues()

	_setDefaultValues: ->

		@x = Source.x
		@y = Source.y
		@c = Source.c

	setCenter: (@x, @y) ->

	setIntensity: (n) ->

		@c = n * Source.c

	update: (dt, particle) ->

		p = particle.position.v

		dx = @x - p[0]
		dy = @y - p[1]
		sx = MT.sign dx
		sy = MT.sign dy
		dx2 = Math.pow dx, 2
		dy2 = Math.pow dy, 2

		theta = MT.lineSlope @x, @y, p[0], p[1]

		d = dx2 + dy2

		magnitude = @c * d

		fx = - sx * Math.abs(Math.cos(theta)) * magnitude
		fy = - sy * Math.abs(Math.sin(theta)) * magnitude

		particle.force.add fx, fy