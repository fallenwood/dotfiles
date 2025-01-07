local load = require

local module = {

  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      local builtin = load("telescope.builtin")
      vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
      vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
    end
  },

  {
    "nvim-lualine/lualine.nvim",
    config = function()
      local lualine = load("lualine");
      lualine.setup();
    end,
    enabled = true,
  },

  {
    "romgrk/barbar.nvim",
    dependencies = {
      -- "lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
      -- "nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
    },
    init = function() vim.g.barbar_auto_setup = false end,
    opts = {
      animation = false,
      icons = {
        filetype = {
          enabled = false,
        },
      },
    },
  },
}

return module
