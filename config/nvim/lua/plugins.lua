local load = require

local module = {}

local ensureLazy = function()
  local fn = vim.fn
  local lazypath = fn.stdpath("data") .. "/lazy/lazy.nvim"
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

  load("lazy").setup({
    spec = {
      {
        "hrsh7th/nvim-cmp",
        dependencies = {{
          "hrsh7th/cmp-buffer",
          "FelipeLema/cmp-async-path",
          "hrsh7th/cmp-nvim-lsp",
          "neovim/nvim-lspconfig",
        }},
        config = function()
          local cmp = require("cmp")
          vim.opt.completeopt = { "menu", "menuone", "noselect", }
          cmp.setup({
            sources = cmp.config.sources({
              { name = "buffer", },
              { name = "async_path", },
              { name = "nvim_lsp", }
            }),
            mapping = cmp.mapping.preset.insert({
              ['<C-e>'] = cmp.mapping.abort(),
              ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
            }),
          })

          local lsp = load("lspconfig")
          lsp.csharp_ls.setup(require('cmp_nvim_lsp').default_capabilities())
          lsp.rust_analyzer.setup(require('cmp_nvim_lsp').default_capabilities())
          lsp.lua_ls.setup(require('cmp_nvim_lsp').default_capabilities())
          lsp.pyright.setup(require('cmp_nvim_lsp').default_capabilities())
        end
      },

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
            ensure_installed = { "c", "cpp", "lua", "rust", "c_sharp", "python" },
            highlight = {
              enable = true,
              additional_vim_regex_highlighting = false,
            },
            indent = { enable = true },
          })
        end
      },

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

          -- load("solarized").set()
        end,
      },

      {
        "nvim-telescope/telescope.nvim",
        dependencies = { {
          "nvim-lua/plenary.nvim",
        } },
        config = function()
          local builtin = load('telescope.builtin')
          vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
          vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
          vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
          vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
        end
      },
    }
  })

  callback()
end

return module
