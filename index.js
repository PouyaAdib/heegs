const n = 30000;
const h = new Heegs.Engine(n);

h.setParticlesParams((i, { setMass, setPosition }) => {
  setMass(Math.random() * 1 + 1);
  let x, y;
  do {
    x = Math.random() * 2 - 1;
    y = (2 * i) / n - 1;
  } while (isInsideHeegs(x, y));
  setPosition(x, y);
});

main(h.positionData);

function start() {
  const s5 = h.addBehavior(Heegs.Sink);
  s5.setIntensity(3);
  s5.setCenter(0, -1);

  setTimeout(() => {
    const s = h.addBehavior(Heegs.Sink);
    s.setIntensity(5);
    s.setCenter(0, 1);
  }, 11000);

  setTimeout(() => {
    const s2 = h.addBehavior(Heegs.Sink);
    s2.setIntensity(8);
    s2.setCenter(1, 0);

    const s3 = h.addBehavior(Heegs.Sink);
    s3.setIntensity(8);
    s3.setCenter(-1, 0);
  }, 19000);

  setTimeout(() => {
    const d = h.addBehavior(Heegs.Drag);
    d.setIntensity(0.000007, 0.0007);
  }, 25000);

  setTimeout(() => {
    const sn = h.addBehavior(Heegs.Sink);
    sn.setIntensity(-120);
  }, 38000);

  h.start(performance.now());
  update();
}

function update() {
  h.update(performance.now());
  replacePositions(h.positionData);
  requestAnimationFrame(update);
}

function getHeegsGeometry() {
  return [
    // H
    [-0.725, -0.645, -0.5, 0.5],
    [-0.645, -0.555, -0.1, 0.1],
    [-0.555, -0.475, -0.5, 0.5],
    // E
    [-0.425, -0.345, -0.5, 0.5],
    [-0.345, -0.175, 0.3, 0.5],
    [-0.345, -0.175, -0.1, 0.1],
    [-0.345, -0.175, -0.5, -0.3],
    // E
    [-0.125, -0.045, -0.5, 0.5],
    [-0.045, 0.125, 0.3, 0.5],
    [-0.045, 0.125, -0.1, 0.1],
    [-0.045, 0.125, -0.5, -0.3],
    // G
    [0.175, 0.255, -0.5, 0.5],
    [0.225, 0.425, 0.3, 0.5],
    [0.225, 0.425, -0.5, -0.3],
    [0.345, 0.425, -0.3, 0.1],
    [0.3, 0.345, -0.1, 0.1],
    // S
    [0.475, 0.725, 0.3, 0.5],
    [0.475, 0.555, -0.1, 0.3],
    [0.555, 0.725, -0.1, 0.1],
    [0.645, 0.725, -0.3, -0.1],
    [0.475, 0.725, -0.5, -0.3]
  ];
}

function isInsideHeegs(x, y) {
  let isInside = false;
  getHeegsGeometry().forEach(square => {
    if (x > square[0] && x < square[1] && y > square[2] && y < square[3]) {
      isInside = true;
      return;
    }
  });
  return isInside;
}
