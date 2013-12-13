module.exports = class Element

	constructor: (@obj, @position) ->

		do @update

	update: ->

		@obj
		.moveXTo(@position.v[0])
		.moveYTo(@position.v[1])

		return