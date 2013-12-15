_Module = require '../core/_Module'
MT = require '../tools/MathTools'

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

		@radiusSQ = Math.pow(@radius, 2)

	update: (dt, data, offset) ->

		x = data[offset]
		y = data[offset + 1]

		dx = @x - x; dy = @y - y
		dx2 = Math.pow(dx, 2)
		dy2 = Math.pow(dy, 2)

		d = dx2 + dy2

		if 0 < d <= @radiusSQ

			sx = MT.sign dx; sy = MT.sign dy
			theta = MT.lineSlope @x, @y, x, y

			magnitude = @G * @mass / d

			fx = sx * Math.abs(Math.cos(theta)) * magnitude
			fy = sy * Math.abs(Math.sin(theta)) * magnitude

			data[offset + 6] += fx
			data[offset + 7] += fy

		return