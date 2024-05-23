local load = require

local utils = load("utils")

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
          "L3MON4D3/LuaSnip",
          "saadparwaiz1/cmp_luasnip",
          "hrsh7th/cmp-nvim-lsp-signature-help",
        }},
        config = function()
          local cmp = load("cmp")
          vim.opt.completeopt = { "menu", "menuone", "noselect", }
          cmp.setup({
            sources = cmp.config.sources({
              { name = "nvim_lsp", },
              { name = "cmp-nvim-lsp-signature-help" },
              { name = "buffer", },
              { name = "async_path", },
            }),
            mapping = cmp.mapping.preset.insert({
              ['<C-e>'] = cmp.mapping.abort(),
              ['<CR>'] = cmp.mapping.confirm({ select = true }),
              ['<Tab>'] = cmp.mapping.confirm({ select = true }),
            }),
            window = {
              completion = cmp.config.window.bordered(),
              documentation = cmp.config.window.bordered(),
            },
            -- event = "InsertEnter",
            snippet = {
              expand = function(args)
                load("luasnip").lsp_expand(args.body)
              end,
            },
          })
        end,
      },

      {
        "neovim/nvim-lspconfig",
        config = function()
          local lsp = load("lspconfig")
          local cmp_nvim_lsp = load("cmp_nvim_lsp")
          local capabilities = cmp_nvim_lsp.default_capabilities()
          -- lsp.csharp_ls.setup(capabilities)
          lsp.clangd.setup(capabilities)
          lsp.omnisharp.setup(utils.merge(capabilities, {
            cmd = {"OmniSharp"},
          }))
          lsp.rust_analyzer.setup(capabilities)
          lsp.lua_ls.setup(capabilities)
          lsp.pyright.setup(capabilities)
          lsp.gopls.setup(capabilities)
          lsp.serve_d.setup(capabilities)

          vim.keymap.set('n', '<leader>ft', function()
            vim.lsp.buf.format { async = true }
          end, nil)

        end,
        event = { "BufNewFile", "BufReadPre" },
      },

      {
        "mfussenegger/nvim-dap",
        config = function()
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
        end,
        lazy = true,
        enabled = false,
      },

      {
        "Nsidorenco/tree-sitter-fsharp",
        branch = "develop",
        dependencies={{
          "nvim-treesitter/nvim-treesitter",
        }},
        build = function ()
          vim.fn.system({
            "npm",
            "install",
            "&&",
            "npm",
            "run",
            "build",
          })
        end,
        config = function ()
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
        lazy = false,
      },

      {
        "nvim-telescope/telescope.nvim",
        dependencies = {{
          "nvim-lua/plenary.nvim",
        }},
        config = function()
          local builtin = load('telescope.builtin')
          vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
          vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
          vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
          vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
        end
      },
    }
  },
  {
    performance = {
      reset_packpath = false,
      rtp = {
        reset = false,
      },
    },
  })

  callback()
end

return module
