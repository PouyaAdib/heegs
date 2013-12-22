Particle = require '../particles/Particle'
Euler = require '../integrator/Euler'
Esterakt = require 'esterakt'

module.exports = class Engine

	constructor: (n) ->

		@n = parseInt n
		@particles = []
		@behaviours = []

		@integrator = new Euler

		do @_prepareParticles

		@

	_prepareParticles: ->

		@_struct = new Esterakt

		@_struct.getContainer('pos').float 'p', 3

		phys = @_struct.getContainer('phys')

		phys.float 'v', 3

		phys.float 'f', 3

		phys.float 'm', 1, [1]

		@_params = @_struct.makeParamHolders {}, @n

		@_physData = new Float32Array @_params.__buffers.phys
		@_posData = new Float32Array @_params.__buffers.pos

		@uint8ViewOnPos = @_params.__uint8Views.pos

		for param in @_params

			@particles.push p = new Particle param

		@

	getParticles: () ->

		@particles

	getParticle: (i) ->

		@particles[i]

	start: (t) ->

		@time = t

	update: (t) ->

		dt = @_ticktack t

		@_updateParticles dt

		return

	_updateParticles: (dt) ->

		for i in [0...@n]

			posOffset = (i * 3) | 0
			physOffset = (i * 7)|0

			x = @_posData[posOffset]
			y = @_posData[posOffset + 1]

			for b in @behaviours

				b.update dt, x, y, @_physData, physOffset

			@integrator.update dt, x, y, @_physData, physOffset, @_posData, posOffset

			@_physData[physOffset + 3] = 0
			@_physData[physOffset + 4] = 0
			@_physData[physOffset + 5] = 0

		return

	_ticktack: (t) ->

		dt = t - @time
		@time = t

		return dt

	addBehaviour: (behaviour) ->

		b = new behaviour

		@behaviours.push b

		return b

	removeBehaviour: (behaviour) ->

		newBehaviours = []

		for b in @behaviours

			if b isnt behaviour then newBehaviours.push b

		@behaviours = newBehaviours

		@
