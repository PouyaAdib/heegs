module.exports = class Particle

	constructor: (@param) ->

		@c = 5e-2

	setMass: (m) ->

		@param.m[0] = m

		@

	setFrictionCoeff: (c) ->

		@param.c[0] = c

		@

	moveTo: (x, y, z) ->

		@param.p[0] = x
		@param.p[1] = y
		@param.p[2] = z

		@

	setV0: (x, y, z) ->

		@param.v[0] = x * @c
		@param.v[1] = y * @c
		@param.v[2] = z * @c

		@