local load = require

local module = {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "FelipeLema/cmp-async-path",
      "hrsh7th/cmp-nvim-lsp",
      "neovim/nvim-lspconfig",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "onsails/lspkind.nvim",
    },
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
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping.confirm({ select = true }),
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
        formatting = {
          format = function(entry, vim_item)
            local cmp_format = load("lspkind").cmp_format({
              mode = "symbol_text",
              -- mode = "symbol",
              maxwidth = {
                menu = 50, -- leading text (labelDetails)
                abbr = 50, -- actual suggestion item
              },
              ellipsis_char = "...",
              show_labelDetails = false,
            })
            local kind = cmp_format(entry, vim_item)

            return kind
          end
        }
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      local lsp = load("lspconfig")
      local cmp_nvim_lsp = load("cmp_nvim_lsp")
      local capabilities = cmp_nvim_lsp.default_capabilities()
      local ruff = false
      local omnisharp = false
      lsp.clangd.setup({
        capabilities = capabilities,
      })

      if omnisharp then
        lsp.omnisharp.setup({
          capabilities = capabilities,
          cmd = { "OmniSharp" },
        })
      else
        lsp.csharp_ls.setup({ capabilities = capabilities })
      end

      lsp.rust_analyzer.setup({
        capabilities = capabilities,
      })
      lsp.lua_ls.setup({
        capabilities = capabilities,
      })

      if ruff then
        lsp.pyright.setup({
          capabilities = capabilities,
          settings = {
            pyright = {
              disableOrganizeImports = true,
            },
            python = {
              analysis = {
                ignore = { "*" },
              },
            },
          },
        })
        lsp.ruff.setup({
          capabilities = capabilities,
        })
      else
        lsp.pyright.setup({
          capabilities = capabilities,
        })
      end
      -- lsp.gopls.setup(capabilities)
      -- lsp.serve_d.setup(capabilities)
      lsp.zls.setup({capabilities = capabilities})

      vim.keymap.set("n", "<leader>ft", function()
        vim.lsp.buf.format { async = true }
      end, nil)

      vim.keymap.set("n", "<leader>h", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
      vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation, {})
    end,
    event = { "BufNewFile", "BufReadPre" },
  },
}

return module
