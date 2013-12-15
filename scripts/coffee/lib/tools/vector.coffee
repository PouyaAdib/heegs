module.exports = class Vector

	constructor: (x = 0, y = 0) ->

		@v = new Float32Array 2

		@set x, y

	set: (x, y) ->

		@v[0] = x
		@v[1] = y

		return

	add: (x, y) ->

		@v[0] += x
		@v[1] += y

		return

	get: ->

		return @v