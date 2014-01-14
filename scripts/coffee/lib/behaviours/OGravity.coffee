#Not Optimized !

_Module = require '../core/_Module'

module.exports = class OGravity extends _Module

	@g = .00000001
	@x = 0
	@y = 0
	@rotation = 0
	@range = 100

	constructor: ->

		@_setDefaultValues()
		@_determineEquation()

	_setDefaultValues: ->

		@g = OGravity.g
		@x = OGravity.x
		@y = OGravity.y
		@rotation = OGravity.rotation
		@range = OGravity.range
		@rangeSQ = Math.pow OGravity.range, 2

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

		@g = n * OGravity.g

	setCenter: (@x, @y) ->

		@_determineEquation()

	setRotation: (@rotation) ->

		@_determineEquation()

	setRange: (@range) ->

		@rangeSQ = Math.pow @range, 2

	update: (dt, data, offset) ->

		x = data[offset]
		y = data[offset + 1]

		d = Math.pow(@a * x + @b * y + @c, 2) / @denominator

		if d <= @rangeSQ

			magnitude = @g * (@rangeSQ - d)

			c = y - @m * x

			t = if c > @lc then 90 else -90
			s = if @rotation > 90 then -1 else 1

			theta = (t + @rotation) * Math.PI / 180

			fx = s * Math.cos(theta) * magnitude
			fy = - s * Math.sin(theta) * magnitude

			data[offset] += fx
			data[offset + 1] += fy

		return