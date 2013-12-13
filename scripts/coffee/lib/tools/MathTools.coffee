module.exports = MathTools =

	sign: (x) ->

		if x is 0 then return 0

		Math.abs(x) / x

	lineSlope: (x0, y0, x1, y1) ->

		dy = y1 - y0
		dx = x1 - x0

		Math.atan dy / dx