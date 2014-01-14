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

	requestTick: (t, hadChanged = false, changeFrom = false) ->

		last60 = t - 1000

		startTime = @_calculateStartTime t, changeFrom

		# console.log 'requested', t, @behaviours[0].props

		deltaT = t - startTime

		count = deltaT / @_msTimeStep

		count = if count % 1 > .5 then parseInt(count + 1) else parseInt(count)

		for i in [0...count]

			now = i * @_msTimeStep

			@_ticker.tick now + startTime

			@_updateParticles @_msTimeStep

			if last60 <= now < t

				index = @n * 3 * parseInt((now - t + 1000) * 0.06)

				@_setToLastSixtyCache index

			if now % 1000 < .1

				cacheTime = startTime + Math.round(i * @_msTimeStep)

				unless cacheTime <= @_lastValidCacheTime

					@_setToWholeCache cacheTime

		@_currentTime = t

		# console.log @_posData

		return

	_calculateStartTime: (t, changedFrom) ->

		unless changedFrom

			if @_currentTime - 1000 <= t < @_currentTime

				index = @n * 3 * Math.round((t - @_currentTime + 1000) * 0.06)

				@_readFromLastSixtyCache index

				return t

			else

				st = if t < @_lastValidCacheTime then parseInt(t / 1000) * 1000 else @_lastValidCacheTime

				@_readFromWholeCache st

				return st

		else

			if changedFrom > t then return @_calculateStartTime t, false

			if changedFrom < @_lastValidCacheTime then @_lastValidCacheTime = parseInt(changedFrom / 1000) * 1000

			if @_currentTime - 1000 <= changedFrom < @_currentTime

				index = @n * 3 * parseInt((changedFrom - @_currentTime + 1000) * 0.06)

				@_readFromLastSixtyCache index

				return t

			else

				@_readFromWholeCache @_lastValidCacheTime

				return @_lastValidCacheTime


	_readFromLastSixtyCache: (index) ->

		pos = @_lastSixtyFramesPosCache.subarray(index, index + @n * 3)
		@_posData.set(pos)
		vel = @_lastSixtyFramesVelCache.subarray(index, index + @n * 3)
		@_velData.set(vel)

	_setToLastSixtyCache: (index) ->

		pos = @_lastSixtyFramesPosCache.subarray(index, index + @n * 3)
		pos.set(@_posData)
		vel = @_lastSixtyFramesVelCache.subarray(index, index + @n * 3)
		vel.set(@_velData)

	_readFromWholeCache: (time) ->

		index = @n * 3 * parseInt(time / 1000)

		pos = @_wholePosCache.subarray(index, index + @n * 3)
		@_posData.set(pos)
		vel = @_wholeVelCache.subarray(index, index + @n * 3)
		@_velData.set(vel)

	_setToWholeCache: (time) ->

		@_lastValidCacheTime = time

		index = @n * 3 * parseInt(@_lastValidCacheTime / 1000)

		pos = @_wholePosCache.subarray(index, index + @n * 3)
		pos.set(@_posData)
		vel = @_wholeVelCache.subarray(index, index + @n * 3)
		vel.set(@_velData)

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

			@_physData[physOffset + 0] = 0
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
