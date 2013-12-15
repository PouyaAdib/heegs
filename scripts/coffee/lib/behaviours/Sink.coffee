_Module = require '../core/_Module'
MT = require '../tools/MathTools'

module.exports = class Sink extends _Module

	@x = 0
	@y = 0
	@c = .00000001

	constructor: ->

		@_setDefaultValues()

	_setDefaultValues: ->

		@x = Sink.x
		@y = Sink.y
		@c = Sink.c

	setCenter: (@x, @y) ->

	setIntensity: (n) ->

		@c = n * Sink.c

	update: (dt, data, offset) ->

		x = data[offset]
		y = data[offset + 1]

		dx = @x - x
		dy = @y - y
		sx = MT.sign dx
		sy = MT.sign dy
		dx2 = Math.pow dx, 2
		dy2 = Math.pow dy, 2

		theta = MT.lineSlope @x, @y, x, y

		d = dx2 + dy2

		magnitude = @c * d

		fx = sx * Math.abs(Math.cos(theta)) * magnitude
		fy = sy * Math.abs(Math.sin(theta)) * magnitude

		data[offset + 6] += fx
		data[offset + 7] += fy