Vector = require '../tools/Vector'

module.exports = class Particle

	@mass = 1

	constructor: (x, y, vx0, vy0) ->

		@position = new Vector x, y
		@velocity = new Vector vx0, vy0
		@force = new Vector

		@setMass()

	setMass: (n = 1) ->

		@mass = n * Particle.mass

	getMass: ->

		return @mass