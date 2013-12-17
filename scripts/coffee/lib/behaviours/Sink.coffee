_Module = require '../core/_Module'
{sign} = require '../tools/MathTools'

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
		dx2 = dx * dx
		dy2 = dy * dy

		fx = sign(dx) * @c * (dx2 + dy2) / (Math.sqrt(1 + (dy / dx) * (dy / dx)))
		fy = dy * sign(dy) * fx / dx

		data[offset + 6] += fx
		data[offset + 7] += fy