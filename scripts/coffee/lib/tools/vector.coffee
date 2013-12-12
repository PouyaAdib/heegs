module.exports = class Vector

	constructor: (x = 0, y = 0) ->

		@v = {x: x, y: y}

	set: (x, y) ->

		@v = {x: x, y: y}

	add: (x, y) ->

		@v = {x: @v.x + x, y: @v.y + y}

	get: ->

		return @v