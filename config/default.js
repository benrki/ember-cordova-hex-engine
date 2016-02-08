config = {
  map: {
    sizes: [
      { name: "Giga",   size: 50  },
      { name: "Medium", size: 25  },
      { name: "Small",  size: 10  }
    ],
    size:     { name: "Small", size: 10 },
    path:     "maps",
    fileType: ".hexmap",
    resources: {
      max: 6
    }
  },
  folders: [
    "maps/default",
    "saves"
  ],
  hex: {
    size: 25
  },
  players: [
    { color: "red", isPlayer: true, order: 0 },
    { color: "green", order: 1 },
    { color: "blue", order: 2  }
  ]
};

module.exports = config
