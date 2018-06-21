Heegs
=====

A simple 2D physics engine written in typescript, optimized for creating webgl particle effects. [Demo](https://pouyaadib.github.io/heegs/)

## Installation

Install with NPM:

```
$ npm install heegs
```

or use the standalone UMD build

```
$ <script src="https://unpkg.com/heegs@1.0.1"></script>
```

## Usage

When you include `Heegs` in your project it outputs an `Engine` and a bunch of behaviors.


`Engine` is the core part of `Heegs`. It creates and glues everything together.
Create a new `Heegs` instance by instantiating `Engine` class and provide it with the number of particles present in the simulation. In order to do the calculations use `start` and `update` methods on the instance of `Engine` and provide them with the current time. The method `start` should be called once, when you want to begin the simulation, and the method `update` should be called in every frame.


Behaviors are classes that modify the forces present in the simulation. You can add/remove them using `addBehavior` and `removeBehavior` methods on the `Engine`'s instance. If the behavior you're looking for is not provided with `Heegs` you can easily create your own. A class can be used as a behavior if it has an `update` method. A simple example is as follows:

```js
class DummyBehavior {
  update: (dt: number, x: number, y: number, data: Float32Array, offset: number) => void {
    /**
     * dt is the time difference between the current frame and the last one
     * x is the x-axis position of the particle
     * y is the y-axis position of the particle
     * data contains information about the velocity, force and mass of all the particles
     * offset gives the first index inside the data array where current particle's information is stored
     */

    // You can access particle's params as follows:
      const v_x  = data[offset]
      const v_y  = data[offset + 1]
      const mass = data[offset + 4]

    // Calculate the forces that should be acting on the particle in result of existence of DummyBehavior
      const f_x = Math.random() * v_x * mass
      const f_y = Math.random() * v_y * mass

    // [Required]
    // In order for the DummyBehavior's forces to be effective on the particle you should add the calculated values to the current forces acting on it
      data[offset + 2] += f_x
      data[offset + 3] += f_y
  }
}

```

## Code Example
```js
import {Engine, Sink, Drag} from 'heegs'

// Create a new instance
const numberOfParticles = 10
const h = new Engine(numberOfParticles)

/**
 * [Optional]
 * Set particles initial mass, position and velocity
 * default values are:
 * mass = 1
 * position = [0, 0]
 * velocity = [0, 0]
 */
h.setParticlesParams((index, {setMass, setPosition, setVelocity}) => {
  const mass = 1 + index
  const x = Math.random()
  const y = Math.random()
  const v_x = Math.random()
  const v_y = Math.random()
  setMass(mass)
  setPosition(x, y)
  setVelocity(v_x, v_y)
})

// Add a new behavior to the engine
const s = h.addBehavior(Sink)
// Customize behavior's parameters
s.setIntensity(10)
s.setCenter(1, 1)

// Behaviors can be added/removed while engine is running
setTimeout(() => {
  h.removeBehavior(s)

  const d = h.addBehavior(Drag)
  const fixedCoeff = 1
  const randomCoeff = 1
  d.setIntensity(fixedCoeff, randomCoeff)
}, 2000)

// Start calculation
h.start(performance.now())
play()

function play() {
  // Update particles
  h.update(performance.now())

  // position of particles is accessible via h.positionData
  // h.positionData is a Float32Array
  // so we can put it in a webGL buffer directly
  webGL.replacePositionBuffer(h.positionData)

  requestAnimationFrame(play)
}
```