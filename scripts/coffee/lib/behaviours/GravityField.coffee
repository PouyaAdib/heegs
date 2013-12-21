_Module = require '../core/_Module'
{sign} = require '../tools/MathTools'

module.exports = class GravityField extends _Module

	@mass = 1
	@x = 0
	@y = 0
	@radius = 1000
	@G = 10

	constructor: ->

		@_setDefaultValues()

	_setDefaultValues: ->

		@mass = GravityField.mass
		@x = GravityField.x
		@y = GravityField.y
		@radius = GravityField.radius
		@radiusSQ = Math.pow(GravityField.radius, 2)
		@G = GravityField.G

	setMass: (n) ->

		@mass = n * GravityField.mass

	setCenter: (@x, @y) ->

	setRadius: (@radius) ->

		@radiusSQ = @radius * @radius

	update: (dt, x, y, data, offset) ->

		dx = @x - x; dy = @y - y
		dx2 = dx * dx
		dy2 = dy * dy

		d = dx2 + dy2

		if 0 < d <= @radiusSQ

			fx = sign(dx) * @G * @mass / d / (Math.sqrt(1 + (dy / dx) * (dy / dx)))
			fy = sign(dy) * @G * @mass / d / (Math.sqrt(1 + (dx / dy) * (dx / dy)))

			data[offset + 6] += fx
			data[offset + 7] += fy

		return