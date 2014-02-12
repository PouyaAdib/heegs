module.exports = MathTools =

	sign: (x) ->

		`x > 0.0 ? 1 : -1`

	random: (seed) ->

		x = (seed << 13) ^ seed

		1 - ((x * (x * x * 15731 + 789221) + 1376312579) & 0x7fffffff ) / 1073741827
