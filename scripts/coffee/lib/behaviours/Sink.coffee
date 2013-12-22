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

	update: (dt, x, y, data, offset) ->

		dx = @x - x
		dy = @y - y
		dx2 = dx * dx
		dy2 = dy * dy

		fx = sign(dx) * @c * (dx2 + dy2) / (Math.sqrt(1 + (dy / dx) * (dy / dx)))
		fy = sign(dy) * @c * (dx2 + dy2) / (Math.sqrt(1 + (dx / dy) * (dx / dy)))

		data[offset + 3] += fx
		data[offset + 4] += fy