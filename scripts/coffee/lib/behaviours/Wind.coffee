# _Module = require '../core/_Module'
# MT = require '../tools/MathTools'
# Engine = require '../core/Engine'

# module.exports = class Wind extends _Module

# 	@c = 0.0001
# 	@pattern = [

# 			[.4, .1, .4, .5, .3, .7, 1, .2, .3, .4],
# 			[.4, .1, .4, .5, .3, .7, 1, .2, .3, .4],
# 			[.4, .1, .4, .5, .3, .7, 1, .2, .3, .4],
# 			[.4, .1, .4, .5, .3, .7, 1, .2, .3, .4],
# 			[.4, .1, .4, .5, .3, .7, 1, .2, .3, .4],
# 			[.4, .1, .4, .5, .3, .7, 1, .2, .3, .4],
# 			[.4, .1, .4, .5, .3, .7, 1, .2, .3, .4],
# 			[.4, .1, .4, .5, .3, .7, 1, .2, .3, .4],
# 			[.4, .1, .4, .5, .3, .7, 1, .2, .3, .4],
# 			[.4, .1, .4, .5, .3, .7, 1, .2, .3, .4],

# 		]

# 		@width = 400
# 		@height = 800

# 		@xf = @width / (@pattern[0].length - 1)
# 		@yf = @height / (@pattern.length - 1)

# 		@x = 0
# 		@y = 0

# 		@duration = 10000
# 		@speed = 1

# 	constructor: (@parent) ->

# 		@_setDefaultValues()

# 		@appear()

# 		@_blow()

# 	_setDefaultValues: ->

# 		@c = Wind.c

# 		@pattern = Wind.pattern

# 		@width = Wind.width
# 		@height = Wind.height

# 		@xf = Wind.xf
# 		@yf = Wind.yf

# 		@x = Wind.x
# 		@y = Wind.y

# 		@duration = Wind.duration
# 		@speed = Wind.speed

# 		@step = Math.floor(@duration / 16) + 1

# 	setIntensity: (n) ->

# 		@c = n * Wind.c

# 	setDuration: (@duration) ->

# 	setSpeed: (n) ->

# 		@speed = n * Wind.speed

# 	update: (dt, particle) ->

# 		p = particle.position.get()

# 		if @x < p.x < @x + @width and @y < p.y < @y + @height

# 			mx = Math.floor(p.x / @xf)
# 			my = Math.floor(p.y / @yf)

# 			fx = @pattern[my][mx] * @c

# 			particle.force.add fx, 0

# 	_blow: () =>

# 		for i in [0..@step]

# 			do (i) =>

# 				setTimeout =>

# 					@x = i * 1600 / @step
# 					@move(@x)

# 				, 16 * i

# 	_remove: () ->

# 		@parent.remove @

# 	appear: () ->

# 		@d = document.createElement 'div'
# 		document.body.appendChild @d

# 		@d.style.width = @width + 'px'
# 		@d.style.height = @height + 'px'
# 		@d.style.background = 'black'
# 		@d.style.opacity = .2
# 		@d.style.position = 'absolute'

# 	move: (x) ->

# 		@d.style.webkitTransform = "translateX(#{x}px)"

