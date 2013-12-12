Element = require './Element'

module.exports = class View

	constructor: (@parent) ->

		@elements = []

	newElement: (x, y) ->

		el = new Element @parent, x, y

		@elements.push el

		return el

	update: (positions) ->

		for element, i in @elements

			element.update positions[i]