local load = require("load")

local module ={
  {
    "https://github.com/rebelot/kanagawa.nvim",
    config = function()
      local kanagawa = load("kanagawa")
      kanagawa.load("wave")
      vim.o.background = "dark"
    end,
    lazy = false,
  },
}

return module
