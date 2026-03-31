local load = require("load")
local enable_vimpack = load("pack").enable_vimpack

local build_treesitter = ":TSUpdate"
if enable_vimpack then
  build_treesitter = nil
end

local module = {
  {
    "https://github.com/nvim-treesitter/nvim-treesitter",
    build = build_treesitter,
    config = function()
      local ts = load("nvim-treesitter")
      local langauges = {
        -- "c",
        -- "cpp",
        -- "c_sharp",
        "elixir",
        "lua",
        -- "rust",
        -- "python",
        -- "zig",
      }
      ts.install(langauges)

      vim.api.nvim_create_autocmd('FileType', {
        pattern = langauges,
        callback = function() vim.treesitter.start() end,
      })
    end,
    lazy = false,
    enabled = true,
  },
}

return module
