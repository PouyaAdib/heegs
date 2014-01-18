module.exports = class Particle

	constructor: (@param) ->

	setMass: (m) ->

		@param.m[0] = m

		@

	moveTo: (x, y, z) ->

		@param.p[0] = x
		@param.p[1] = y
		@param.p[2] = z

		@

	setV0: (x, y, z) ->

		@param.v[0] = x
		@param.v[1] = y
		@param.v[2] = z

		@