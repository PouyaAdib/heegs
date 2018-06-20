const vertexShaderSource = `#version 300 es
in vec4 a_position;
out vec4 v_color;
void main() {
  gl_Position = a_position;
  gl_PointSize = 15.0;
  v_color = gl_Position;
}
`

const fragmentShaderSource = `#version 300 es
precision highp float;

in vec4 v_color;
out vec4 outColor;

const vec4 begin = vec4(0.1, 0.75, 1.0, 1.0);
const vec4 end = vec4(1.0, 1.0, 1.0, 1.0);

vec4 interpolate4f(vec4 a,vec4 b, float p) {
  return a + (b - a) * p;
}

void main(void) {

  vec2 pc = (gl_PointCoord - 0.5) * 2.0;

  float dist = (1.0 - sqrt(pc.x * pc.x + pc.y * pc.y));
  vec4 color = interpolate4f(begin, v_color * 0.5 + 0.5, dist);

  outColor = vec4(dist, dist, dist, dist) * color;

}`

function createShader(gl, type, source) {
  const shader = gl.createShader(type)
  gl.shaderSource(shader, source)
  gl.compileShader(shader)
  if (gl.getShaderParameter(shader, gl.COMPILE_STATUS)) {
    return shader
  }

  gl.deleteShader(shader)
}

function createProgram(gl, vertexShader, fragmentShader) {
  const program = gl.createProgram()
  gl.attachShader(program, vertexShader)
  gl.attachShader(program, fragmentShader)
  gl.linkProgram(program)
  if (gl.getProgramParameter(program, gl.LINK_STATUS)) {
    return program
  }

  gl.deleteProgram(program)
}

let gl
let program
let positionBuffer
function main(pos) {
  const canvas = document.getElementById('canvas')
  gl = canvas.getContext('webgl2', {antialias: false, alpha: false, permultipliedAlpha: false})
  if (!gl) {
    return
  }

  const vertexShader = createShader(gl, gl.VERTEX_SHADER, vertexShaderSource)
  const fragmentShader = createShader(gl, gl.FRAGMENT_SHADER, fragmentShaderSource)

  program = createProgram(gl, vertexShader, fragmentShader)

  const positionAttributeLocation = gl.getAttribLocation(program, 'a_position')

  positionBuffer = gl.createBuffer()
  gl.bindBuffer(gl.ARRAY_BUFFER, positionBuffer)
  gl.bufferData(gl.ARRAY_BUFFER, pos, gl.STATIC_DRAW)

  const vao = gl.createVertexArray()
  gl.bindVertexArray(vao)
  gl.enableVertexAttribArray(positionAttributeLocation)

  const size = 2
  const type = gl.FLOAT
  const normalize = false
  const stride = 0
  const offset = 0
  gl.vertexAttribPointer(positionAttributeLocation, size, type, normalize, stride, offset)

  gl.canvas.width = window.innerWidth
  gl.canvas.height = window.innerHeight

  gl.viewport(0, 0, gl.canvas.width, gl.canvas.height)

  gl.useProgram(program)

  gl.bindVertexArray(vao)

  gl.enable(gl.BLEND);
  gl.blendFunc(gl.SRC_ALPHA, gl.ONE);

  draw()
}

function draw() {
  gl.clearColor(0, 0, 0, 1)
  gl.clear(gl.COLOR_BUFFER_BIT)
  const primitiveType = gl.POINTS
  const count = n
  const offsetP = 0
  gl.drawArrays(primitiveType, offsetP, count)
}

function replacePositions(newPositions) {
  gl.bindBuffer(gl.ARRAY_BUFFER, positionBuffer)
  gl.bufferData(gl.ARRAY_BUFFER, newPositions, gl.STATIC_DRAW)
  draw()
}
