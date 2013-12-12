Vector = require '../tools/Vector'

module.exports = class Particle

	@mass = 1

	constructor: (x, y, vx0, vy0) ->

		@position = new Vector
		@velocity = new Vector
		@force = new Vector

		@setMass()
		@position.set x, y
		@velocity.set vx0, vy0

	setMass: (n = 1) ->

		@mass = n * Particle.mass

	getMass: ->

		return @mass
