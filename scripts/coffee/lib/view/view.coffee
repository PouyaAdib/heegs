Element = require './Element'

module.exports = class View

	constructor: ->

		@elements = []

	newElement: (obj, x, y) ->

		@elements.push el = new Element obj, x, y

		return el

	update: (positions) ->

		for element, i in @elements

			element.update positions[i]