local load = require

local module = {
  {
    "nvim-treesitter/nvim-treesitter",
    build = function()
      local ts_update = load("nvim-treesitter.install")
          .update({
            with_sync = true
          })
      ts_update()
    end,
    config = function()
      load("nvim-treesitter.configs").setup({
        -- ensure_installed = { "c", "cpp", "lua", "rust", "c_sharp", "python", "elixir" },
        -- ensure_installed = { "lua", "rust", "python", "elixir" },
        ensure_installed = { "elixir" },
        highlight = {
          enable = true,
          --[[
        -- provided by google gemi, but does not work at all
        -- it does not support function call instead of boolean, function is treated as true
        enable = function (ft)
          local lsp_client = vim.lsp.buf_get_clients(0) [1] -- Check if any LSP client is active on the current buffer
          enabled = not lsp_client or not lsp_client.resolved_capabilities.document_highlight
          vim.print("Enable TreeSiter?" .. tostring(enabled))
          return false
        end,
        --]]
          additional_vim_regex_highlighting = false,
        },
        indent = { enable = true },
      })
    end,
    lazy = false,
    enabled = true,
  },

  {
    "Nsidorenco/tree-sitter-fsharp",
    branch = "develop",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
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
