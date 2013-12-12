Foxie = require 'foxie'

module.exports = class Element

	constructor: (@parent, x, y) ->

		@radius = 10

		el = @_create()
		@_setStyles(el)
		@_move x, y

	_create: ->

		el = document.createElement 'div'

		@parent.appendChild el

		@foxie = new Foxie el

		return el

	_setStyles: (el) ->

		r = Math.floor(Math.random() * 255)
		g = Math.floor(Math.random() * 255)
		b = Math.floor(Math.random() * 255)

		@foxie
		.css('width', 2 * @radius + 'px')
		.css('height', 2 * @radius + 'px')
		.css('border-radius', '50%')
		.css('background', "rgb(#{r}, #{g}, #{b})")
		.css('position', 'absolute')
		.moveZTo(1)

	_move: (x, y) ->

		@foxie
		.noTrans()
		.moveXTo(x - @radius)
		.moveYTo(y - @radius)

	update: (pos) ->

		@_move pos.x, pos.y

