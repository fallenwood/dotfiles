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
        }},
        config = function()
          local cmp = require("cmp")
          vim.opt.completeopt = { "menu", "menuone", "noselect", }
          cmp.setup({
            sources = cmp.config.sources({
              { name = "buffer", },
              { name = "async_path", },
            }),
            mapping = cmp.mapping.preset.insert({
              ['<C-e>'] = cmp.mapping.abort(),
              ['<CR>'] = cmp.mapping.confirm({ select = true }),
            }),
            window = {
              completion = cmp.config.window.bordered(),
              documentation = cmp.config.window.bordered(),
            },
            event = "InsertEnter",
          })
        end
      }
    }
  })

  callback()
end

return module
