config = {
  map: {
    sizes: [
      { name: "Giga",   size: 50 },
      { name: "Medium", size: 25  },
      { name: "Small",  size: 10  }
    ],
    size:     { name: "Small", size: 10 },
    path:     "maps",
    fileType: ".hexmap"
  },
  folders: [
    "maps/default",
    "saves"
  ],
  hex: {
    size: 25
  }
};

module.exports = config