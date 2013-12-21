Particle = require '../particles/Particle'
Euler = require '../integrator/Euler'
Esterakt = require 'esterakt'

module.exports = class Engine

	constructor: (n, @_ticker) ->

		@n = parseInt n
		@particles = []
		@behaviours = []

		@integrator = new Euler

		do @_prepareParticles

		do @_start

	_updateViewForOffset: ->

	setViewUpdater: (fn) ->

		@_updateViewForOffset = fn

		@

	_prepareParticles: ->

		@_struct = new Esterakt

		@_struct.float 'p', 3

		@_struct.float 'v', 3

		@_struct.float 'f', 3

		@_struct.float 'm', 1, [1]

		@_params = @_struct.makeParamHolders {}, @n

		@_data = new Float32Array @_params.buffer

		for param in @_params

			@particles.push p = new Particle param

		@

	getParticles: () ->

		return @particles

	getParticle: (i) ->

		return @particles[i]

	_update: (t) =>

		dt = @_ticktack t

		@_updateParticles dt

		return

	_updateParticles: (dt) ->

		for i in [0...@n]

			offset = (i * 10)|0

			for b in @behaviours

				b.update dt, @_data, offset

			@integrator.update dt, @_data, offset

			@_data[offset + 6] = 0
			@_data[offset + 7] = 0
			@_data[offset + 8] = 0

			@_updateViewForOffset @_data, offset, i

		return

	_start: ->

		@time = 0

		@_ticker @_update

		return

	_ticktack: (t) ->

		dt = t - @time
		@time = t

		return dt

	addBehaviour: (behaviour) ->

		b = new behaviour @

		@behaviours.push b

		return b

	removeBehaviour: (behaviour) ->

		newBehaviours = []

		for b in @behaviours

			if b isnt behaviour then newBehaviours.push b

		@behaviours = newBehaviours
