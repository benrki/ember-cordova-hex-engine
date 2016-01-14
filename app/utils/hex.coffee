hex =
  cubeToAxial: ({ x, y, z }) -> { q: x, r: z }
  axialToCube: ({ q, r })    -> { x: q, y: -q-r, z: r }

  neighbours: ({ x, y, z }) ->
    [
      { x: x + 1, y: y - 1, z: z     }
      { x: x + 1, y: y,     z: z - 1 }
      { x: x,     y: y - 1, z: z + 1 }
      { x: x,     y: y + 1, z: z - 1 }
      { x: x - 1, y: y + 1, z: z     }
      { x: x - 1, y: y,     z: z + 1 }
    ]

  distance: (a, b) ->
    d = 0
    for p of [ 'x', 'y', 'z' ]
      d += Math.abs(a[p] - b[p])
    d / 2

`export default hex`
