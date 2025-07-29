local load = require("load")

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
      local options = load("lualine.config").get_config()
      local empty = load("lualine.component"):extend()
      function empty:draw(default_highlight)
        self.status = ""
        self.applied_separator = ""
        self:apply_highlights(default_highlight)
        self:apply_section_separators()
        return self.status
      end

      local function add_spacer(section, side)
        local left = side == "left"
        local separator = left and { right = "" } or { left = "" }
        section[1] = { section[1], separator = separator }
        local spacer = { empty, separator = separator }
        table.insert(section, left and #section + 1 or 1, spacer)
        return section
      end

      options.sections["lualine_a"] = add_spacer(options.sections["lualine_a"], "left")
      options.sections["lualine_z"] = add_spacer(options.sections["lualine_z"], "right")
      options.options.section_separators = { left = "", right = "" }
      options.options.component_separators = { left = "╲", right = "╱" }
      options.theme = vim.g.colorscheme
      lualine.setup(options);
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
