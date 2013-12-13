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

	appear: ->
		d = document.createElement 'div'
		c = document.createElement 'div'
		r = @radius
		l = @x - r
		t = @y - r
		c.style.width = '5px'
		c.style.height = '5px'
		c.style.borderRadius = '50%'
		c.style.background = 'black'
		c.style.left = @x - 5 + 'px'
		c.style.top = @y - 5 + 'px'
		c.style.position = 'absolute'
		d.style.width = 2 * r + 'px'
		d.style.height = 2 * r + 'px'
		d.style.left = l + 'px'
		d.style.top = t + 'px'
		d.style.borderRadius = '50%'
		d.style.background = 'trasnparent'
		d.style.border = '1px solid black'
		d.style.position = 'absolute'
		b = document.body
		b.appendChild d
		b.appendChild c

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

	update: (dt, particle) ->

		p = particle.position.v

		dx = @x - p[0]; dy = @y - p[1]
		dx2 = Math.pow(dx, 2)
		dy2 = Math.pow(dy, 2)

		d = dx2 + dy2

		if 0 < d <= @radiusSQ

			sx = MT.sign dx; sy = MT.sign dy
			theta = MT.lineSlope @x, @y, p[0], p[1]

			magnitude = @G * @mass / d

			fx = sx * Math.abs(Math.cos(theta)) * magnitude
			fy = sy * Math.abs(Math.sin(theta)) * magnitude

			particle.force.add fx, fy

		return