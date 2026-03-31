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

  {
    "https://github.com/Nsidorenco/tree-sitter-fsharp",
    branch = "develop",
    dependencies = {
      "https://github.com/nvim-treesitter/nvim-treesitter",
    },
    build = function()
      vim.fn.system({
        "npm",
        "install",
        "&&",
        "npm",
        "run",
        "build",
      })
    end,
    config = function()
      local parser_config = load("nvim-treesitter.parsers").get_parser_configs()
      parser_config.fsharp = {
        install_info = {
          url = vim.fn.stdpath("data") .. "/lazy/tree-sitter-fsharp",
          files = { "src/scanner.cc", "src/parser.c", },
        },
        filetype = "fsharp",
      }
      -- Needs to install tree-sitter binary
      -- Run `CC=clang++ nvim` and `:TSInstallForGrammar fsharp` to install
      -- No fsharp syntax bundled with neovim, no coloring at all
    end,
    lazy = true,
    enabled = false,
  },
}

return module
