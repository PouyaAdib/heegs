View = require '../view/View'
BehavioursManager = require '../core/BehavioursManager'
Particle = require '../particles/Particle'
Euler = require '../integrator/Euler'
Foxie = require 'foxie'

module.exports = class Engine

	constructor: (viewParent) ->

		Engine.parent = viewParent

		@particles = []

		@behaviours = new BehavioursManager
		@integrator = new Euler @particles
		@view = new View viewParent

		do @_start

	newParticle: (x = 0, y = 0, vx0 = 0, vy0 = 0) ->

		p = new Particle x, y, vx0, vy0

		@particles.push p

		el = @view.newElement x, y

		return p

	_update: (t) =>

		dt = @_ticktack t

		pos = @_updateParticles dt

		@view.update pos

		# @_returnPos @_updateParticles dt

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

		Foxie.timing.beforeEachFrame @_update

	_ticktack: (t) ->

		dt = t - @time
		@time = t

		return dt
