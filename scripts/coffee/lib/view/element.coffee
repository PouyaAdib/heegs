module.exports = class Element

	constructor: (@obj, x, y) ->

		@_move x, y

	_move: (x, y) ->

		@obj
		.moveXTo(x)
		.moveYTo(y)

	update: (pos) ->

		@_move pos.x, pos.y

