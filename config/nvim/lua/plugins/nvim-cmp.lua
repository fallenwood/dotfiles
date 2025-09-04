local load = require("load")

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
      local disable_treesitter = function(client)
        if client.server_capabilities.semanticTokensProvider then
          vim.treesitter.stop(bufnr)
        end
      end

      local on_attach = function(client, bufnr)
        disable_treesitter(client)
      end

      local setup = function(name, settings)
        local lsp = vim.lsp

        lsp.config(name, settings)
        lsp.enable(name)
      end

      local lsp = load("lspconfig")
      local cmp_nvim_lsp = load("cmp_nvim_lsp")
      local capabilities = cmp_nvim_lsp.default_capabilities()
      local ruff = false
      local omnisharp = true

      if vim.fn.executable("ccls") == 1 then
        setup("ccls", {
          on_attach = on_attach,
          capabilities = capabilities,
        })
      else
        setup("clangd", {
          on_attach = on_attach,
          capabilities = capabilities,
        })
      end

      setup("lexical", {
        cmd = { "/home/vbox/.local/bin/expert" },
        root_dir = function(fname)
          return lsp.util.root_pattern("mix.exs", ".git")(fname) or vim.loop.cwd()
        end,
        filetypes = { "elixir", "eelixir", "heex", "ex", "exs" },
        settings = {},
        capabilities = capabilities,
      })

      if omnisharp then
        setup("omnisharp", {
          on_attach = on_attach,
          capabilities = capabilities,
          cmd = {
            "OmniSharp",
            "-z",
            "--hostPID",
            tostring(vim.fn.getpid()),
            "DotNet:enablePackageRestore=false",
            "FormattingOptions:EnableEditorConfigSupport=true",
            "Sdk:IncludePrereleases=true",
            "--encoding",
            "utf-8",
            "--languageserver",
          },
          root_dir = function(fname)
            return lsp.util.root_pattern("*.csproj", "*.sln", "*.slnx", ".git")(fname) or vim.loop.cwd()
          end,
          filetypes = { "cs", "csx" },
        })
      else
        setup("csharp_ls", { capabilities = capabilities })
      end

      setup("rust_analyzer", {
        on_attach = on_attach,
        capabilities = capabilities,
      })
      setup("lua_ls", {
        on_attach = on_attach,
        capabilities = capabilities,
      })
      setup("biome", {
        on_attach = on_attach,
        capabilities = capabilities,
      })

      if ruff then
        setup("pyright", {
          on_attach = on_attach,
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
        setup("ruff", {
          capabilities = capabilities,
        })
      else
        setup("pyright", {
          capabilities = capabilities,
        })
      end
      -- .setup("gopls", {capabilities = capabilities })
      setup("serve_d", { capabilities = capabilities })
      setup("zls", { capabilities = capabilities })

      setup("ocamllsp", {
        -- cmd = {"/home/vbox/.opam/def/bin/ocamllsp"},
        cmd = { "opam", "exec", "--", "ocamllsp" },
        filetypes = { "ocaml", "ml", "mli" },
        capabilities = capabilities,
        on_attach = function(client, bufnr)
          --[[
          if client.supports_method("textDocument/formatting") then
            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format({ bufnr = bufnr })
              end,
            })
          end
          --]]
          on_attach(client, bufnr)
        end,
      })

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
