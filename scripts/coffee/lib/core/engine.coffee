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

		@view.newElement obj, p.position

		return

	_update: (t) =>

		dt = @_ticktack t

		@_updateParticles dt

		do @view.update

		return

	_updateParticles: (dt) ->

		for particle in @particles

			for behaviour in @behaviours.get()

				behaviour.update dt, particle

			@integrator.update dt, particle

			particle.force.set 0, 0

		return

	_start: ->

		@time = 0

		@_ticker @_update

		return

	_ticktack: (t) ->

		dt = t - @time
		@time = t

		return dt
