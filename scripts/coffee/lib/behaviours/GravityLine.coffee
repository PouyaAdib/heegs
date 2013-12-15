_Module = require '../core/_Module'
MT = require '../tools/MathTools'

module.exports = class GravityLine extends _Module

	@g = .000000001
	@x = 0
	@y = 0
	@rotation = 0
	@range = 100

	constructor: ->

		@_setDefaultValues()
		@_determineEquation()

	_setDefaultValues: ->

		@g = GravityLine.g
		@x = GravityLine.x
		@y = GravityLine.y
		@rotation = GravityLine.rotation
		@range = GravityLine.range
		@rangeSQ = Math.pow GravityLine.range, 2

	_determineEquation: ->

		@m = - Math.tan(@rotation * Math.PI / 180)
		b = @y - @m * @x
		@lc = b

		if b isnt 0

			@a = - @m / b
			@b = 1 / b
			@c = -1

		else

			@a = -@m
			@b = 1
			@c = 0

		@denominator = Math.pow(@a, 2) + Math.pow(@b, 2)

	setIntensity: (n) ->

		@g = n * GravityLine.g

	setCenter: (@x, @y) ->

		@_determineEquation()

	setRotation: (@rotation) ->

		@_determineEquation()

	setRange: (@range) ->

		@rangeSQ = Math.pow @range, 2

	update: (dt, particle) ->

		p = particle.position.get()

		d = Math.pow(@a * p[0] + @b * p[1] + @c, 2) / @denominator

		if d <= @rangeSQ

			magnitude = @g * (@rangeSQ - d)

			c = p[1] - @m * p[0]

			t = if c > @lc then 90 else -90
			s = if @rotation > 90 then -1 else 1

			theta = (t + @rotation) * Math.PI / 180

			fx = s * Math.cos(theta) * magnitude
			fy = - s * Math.sin(theta) * magnitude

			particle.force.add fx, fy

		return