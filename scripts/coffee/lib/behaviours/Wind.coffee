_Module = require '../core/_Module'
MT = require '../tools/MathTools'

module.exports = class Wind extends _Module

	@c = 0.00001
	@pattern = [

			[.4, .1, .4, .5, .3, .7, 1, .2, .3, .4],
			[.4, .1, .4, .5, .3, .7, 1, .2, .3, .4],
			[.4, .1, .4, .5, .3, .7, 1, .2, .3, .4],
			[.4, .1, .4, .5, .3, .7, 1, .2, .3, .4],
			[.4, .1, .4, .5, .3, .7, 1, .2, .3, .4],
			[.4, .1, .4, .5, .3, .7, 1, .2, .3, .4],
			[.4, .1, .4, .5, .3, .7, 1, .2, .3, .4],
			[.4, .1, .4, .5, .3, .7, 1, .2, .3, .4],
			[.4, .1, .4, .5, .3, .7, 1, .2, .3, .4],
			[.4, .1, .4, .5, .3, .7, 1, .2, .3, .4],

		]

		@width = 400
		@height = 800

		@xl = @pattern[0].length - 1
		@yl = @pattern.length - 1

		@xf = @width / @xl
		@yf = @height / @yl

		@x = 0
		@y = 0

		@speed = 1

	constructor: () ->

		@_setDefaultValues()

	_setDefaultValues: ->

		@c = Wind.c

		@pattern = Wind.pattern

		@xf = Wind.xf
		@yf = Wind.yf

		@x = Wind.x
		@y = Wind.y

		@width = Wind.width
		@height = Wind.height

		@xend = @x + Wind.width
		@yend = @y + Wind.height

	setIntensity: (n) ->

		@c = n * Wind.c

	setPos: (@x, @y) ->

		@xend = @x + @width
		@yend = @y + @height

	setSize: (@width, @height) ->

		@xend = @x + @width
		@yend = @y + @height

		@xf = @width / Wind.xl
		@yf = @height / Wind.yl

	update: (dt, x, y, z, vx, vy, vz, data, offset) ->

		if @x < x < @xend and @y < y < @yend

			fx = @pattern[Math.floor(Math.abs(y - @y) / @yf)][Math.floor(Math.abs(x - @x) / @xf)] * @c

			data[offset] = fx
