Particle = require '../particles/Particle'
Euler = require '../integrator/Euler'
Esterakt = require 'esterakt'

module.exports = class Engine

	constructor: (n = 50000, fps = 60, length = 10) ->

		@n = parseInt n
		@_fps = parseInt fps
		@_length = length * 60

		@_msTimeStep = 1000 / @_fps

		@behaviours = []
		@particles = []

		@_lastSixtyFramesPosCache = new Float32Array(@n * 3 * 60)
		@_lastSixtyFramesVelCache = new Float32Array(@n * 3 * 60)
		@_wholePosCache = new Float32Array(@n * @_length * 3)
		@_wholeVelCache = new Float32Array(@n * @_length * 3)
		@_lastValidCacheTime = 0

		@_currentTime = 0

		@integrator = new Euler

		@_ticker = null

		do @_prepareParticles

		@

	setTicker: (@_ticker) ->

	_prepareParticles: ->

		@_struct = new Esterakt

		@_struct.getContainer('pos').float 'p', 3

		@_struct.getContainer('vel').float 'v', 3

		phys = @_struct.getContainer('phys')

		phys.float 'f', 3

		phys.float 'm', 1, [1]

		@_params = @_struct.makeParamHolders {}, @n

		@_physData = new Float32Array @_params.__buffers.phys
		@_velData = new Float32Array @_params.__buffers.vel
		@_posData = new Float32Array @_params.__buffers.pos

		@uint8ViewOnPos = @_params.__uint8Views.pos
		@uint8ViewOnVel = @_params.__uint8Views.vel

		for param in @_params

			@particles.push p = new Particle param

		@

	getParticles: () ->

		@particles

	getParticle: (i) ->

		@particles[i]

	initConditionsDone: ->

		fr = 0
		to = @n * 3

		@_wholePosCache.subarray(fr, to).set @_posData
		@_wholeVelCache.subarray(fr, to).set @_velData

	requestTick: (t, hadChange, changeFrom) ->

		t -= t%@_msTimeStep

		last60 = t - 1000

		startTime = @_updateCacheAndReturnStartTime t, hadChange, changeFrom

		deltaT = t - startTime

		count = deltaT / @_msTimeStep

		count = if count % 1 > .5 then parseInt(count + 1) else parseInt(count)

		for i in [0...count]

			now = startTime + i * @_msTimeStep

			@_ticker.tick now

			@_updateParticles @_msTimeStep

			if last60 <= now < t

				fr = @n * 3 * Math.round((now - last60) * 0.059)
				to = fr + @n * 3

				@_lastSixtyFramesPosCache.subarray(fr, to).set @_posData
				@_lastSixtyFramesVelCache.subarray(fr, to).set @_velData

			if now % 1000 < .1

				cacheTime = now - now%1000

				unless cacheTime <= @_lastValidCacheTime

					@_lastValidCacheTime = cacheTime

					fr = @n * 3 * parseInt(@_lastValidCacheTime / 1000)
					to = fr + @n * 3

					@_wholePosCache.subarray(fr, to).set @_posData
					@_wholeVelCache.subarray(fr, to).set @_velData

		@_currentTime = t

		return

	_updateCacheAndReturnStartTime: (t, hadChange, changeFrom) ->

		t1 = t

		if hadChange

			if changeFrom < @_lastValidCacheTime then @_lastValidCacheTime = parseInt(changeFrom / 1000) * 1000

			if changeFrom > t then return @_updateCacheAndReturnStartTime t, false, null

			t1 = changeFrom

		if @_currentTime - 1000 <= t1 < @_currentTime

			fr = @n * 3 * Math.round((t1 - @_currentTime + 1000) * 0.059)
			to = fr + @n * 3

			@_posData.set @_lastSixtyFramesPosCache.subarray(fr, to)
			@_velData.set @_lastSixtyFramesVelCache.subarray(fr, to)

			st = t1

		else

			st = if t < @_lastValidCacheTime then parseInt(t / 1000) * 1000 else @_lastValidCacheTime

			fr = @n * 3 * parseInt(st / 1000)
			to = fr + @n * 3

			@_posData.set @_wholePosCache.subarray(fr, to)
			@_velData.set @_wholeVelCache.subarray(fr, to)

		@_lastValidCacheTime = parseInt(st / 1000) * 1000

		return st

	_updateParticles: (dt) ->

		for i in [0...@n]

			offset = (i * 3) | 0
			physOffset = (i * 4)|0

			x = @_posData[offset]
			y = @_posData[offset + 1]
			z = @_posData[offset + 2]

			vx = @_velData[offset]
			vy = @_velData[offset + 1]
			vz = @_velData[offset + 2]

			for b in @behaviours

				b.update dt, x, y, z, vx, vy, vz, @_physData, physOffset

			@integrator.update dt, x, y, z, vx, vy, vz, @_physData, physOffset, @_posData, @_velData, offset

			@_physData[physOffset] = 0
			@_physData[physOffset + 1] = 0
			@_physData[physOffset + 2] = 0

		return

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
