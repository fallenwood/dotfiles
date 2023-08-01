local load = require

local module = {}

local ensureLazy = function()
  local fn = vim.fn
  local lazypath = fn.stdpath("data").."/lazy/lazy.nvim"
  if fn.empty(fn.glob(lazypath)) > 0 then
    fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable", -- latest stable release
      lazypath,
    })
  end
  vim.opt.rtp:prepend(lazypath)

  return true
end

function module.startup(callback)
  local lazyBootstrap = ensureLazy()

  return load("lazy").setup({
    spec = {
      {
        "ms-jpq/coq_nvim",
        branch = "coq",
      },

      {
        "ms-jpq/coq.artifacts",
        branch = "artifacts"
      },

      {
        "neovim/nvim-lspconfig",
        dependencies = {{
          "ms-jpq/coq_nvim",
        }},
        config = function()
          local lsp = load("lspconfig")
          lsp.csharp_ls.setup(load("coq")().lsp_ensure_capabilities())
          lsp.rust_analyzer.setup(load("coq")().lsp_ensure_capabilities())
          lsp.lua_ls.setup(load("coq")().lsp_ensure_capabilities())
        end
      },

      {
        "nvim-treesitter/nvim-treesitter",
        build = function ()
          local ts_update = load("nvim-treesitter.install")
          .update({
            with_sync = true
          })
          ts_update()
        end,
        config = function ()
          load("nvim-treesitter.configs").setup({
            ensure_installed = { "c", "cpp", "lua", "rust", "c_sharp", },
            highlight = {
              enable = true,
              additional_vim_regex_highlighting = false,
              indent = { enable = true },
            },
          })
        end
      },

      {
        'shaunsingh/solarized.nvim',
        config = function ()
          vim.g.solarized_italic_comments = false
          vim.g.solarized_italic_keywords = false
          vim.g.solarized_italic_functions = false
          vim.g.solarized_italic_variables = false
          vim.g.solarized_contrast = true
          vim.g.solarized_borders = false
          vim.g.solarized_disable_background = false

          -- load("solarized").set()
        end,
      },

      {
        "nvim-telescope/telescope.nvim",
        dependencies = {{
          "nvim-lua/plenary.nvim",
        }},
        config = function ()
          local builtin = load('telescope.builtin')
          vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
          vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
          vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
          vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
        end
      },
    }})

  end


  return module
