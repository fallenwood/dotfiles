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
  local _ = ensureLazy()

  local plugins = utils.mergearrays({
    load("plugins.decorators"),
    load("plugins.nvim-cmp"),
    load("plugins.nvim-dap"),
    load("plugins.nvim-treesitter"),
    load("plugins.themes"),
    load("plugins.nvim-rooter"),
  })

  load("lazy").setup({
    spec = plugins,
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
