module.exports = MathTools =

	sign: (x) ->

		`x > 0.0 ? 1 : -1`


	lineSlope: (x0, y0, x1, y1) ->

		dy = y1 - y0
		dx = x1 - x0

		Math.atan dy / dx