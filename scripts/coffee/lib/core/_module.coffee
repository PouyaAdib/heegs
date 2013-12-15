module.exports = class _Module

	constrcutor: (@parent) ->

		@_setDefaultValues()

	update: (dt, data, offset) ->

	_remove: ->

		@parent.remove @