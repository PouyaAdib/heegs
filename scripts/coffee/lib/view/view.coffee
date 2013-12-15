Element = require './Element'

module.exports = class View

	constructor: ->

		@elements = []

	newElement: (obj, position) ->

		@elements.push el = new Element obj, position

		return el

	update: ->

		for element in @elements

			do element.update

		return