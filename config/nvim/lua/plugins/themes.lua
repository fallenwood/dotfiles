local load = require("load")

local module ={
  {
    'shaunsingh/solarized.nvim',
    config = function()
      vim.g.solarized_italic_comments = false
      vim.g.solarized_italic_keywords = false
      vim.g.solarized_italic_functions = false
      vim.g.solarized_italic_variables = false
      vim.g.solarized_contrast = true
      vim.g.solarized_borders = false
      vim.g.solarized_disable_background = false

      vim.o.background = "dark"
      load("solarized").set()
    end,
    lazy = true,
  },

  {
    "loctvl842/monokai-pro.nvim",
    config = function()
      local monokai = load("monokai-pro")
      monokai.setup()

      vim.cmd([[colorscheme monokai-pro]])
    end,
    lazy = true,
  },

  {
    "ellisonleao/gruvbox.nvim",
    config = function()
      local gruvbox = load("gruvbox")
      gruvbox.setup({})
      vim.o.background = "dark"
      vim.cmd([[colorscheme gruvbox]])
    end,
    lazy = true,
  },

  {
    "rebelot/kanagawa.nvim",
    config = function()
      local kanagawa = load("kanagawa")
      kanagawa.load("wave")
    end,
    lazy = false,
  },
}

return module
