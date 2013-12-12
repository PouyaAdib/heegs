View = require '../view/View'
BehavioursManager = require '../core/BehavioursManager'
Particle = require '../particles/Particle'
Euler = require '../integrator/Euler'

module.exports = class Engine

	constructor: (@_ticker) ->

		@particles = []

		@behaviours = new BehavioursManager
		@integrator = new Euler @particles
		@view = new View

		do @_start

	newParticle: (obj, x = 0, y = 0, vx0 = 0, vy0 = 0) ->

		p = new Particle x, y, vx0, vy0

		@particles.push p

		@view.newElement obj, x, y

		return

	_update: (t) =>

		dt = @_ticktack t

		pos = @_updateParticles dt

		@view.update pos

	_updateParticles: (dt) ->

		positions = []

		for particle in @particles

			for behaviour in @behaviours.get()

				behaviour.update dt, particle

			@integrator.update dt, particle

			positions.push particle.position.get()

			particle.force.set 0, 0

		return positions

	_start: ->

		@time = 0

		@_ticker @_update

		return

	_ticktack: (t) ->

		dt = t - @time
		@time = t

		return dt
