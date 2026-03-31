local load = require("load")

local utils = load("utils")

local enable_vimpack = load("pack").enable_vimpack

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
function setupVimpack(plugins)
  -- Stage 1: Add the enabled plugins
  for _, plugin in ipairs(plugins) do
    local dependencies = plugin["dependencies"] or {}
    local version = plugin["branch"]
      local enabled = utils.isEnabled(plugin)

    if enabled then
      for _, dependency in ipairs(dependencies) do
        vim.pack.add({
          {
            src = dependency,
            version = version,
          }
        })
      end

      vim.pack.add({
        {
          src = plugin[1],
        }
      })
    end
  end

  -- Stage 2: Build the plugins
  for _, plugin in ipairs(plugins) do
    local enabled = utils.isEnabled(plugin)
    if enabled then
      local build = plugin["build"]
      if build ~= nil then
        if type(build) == "function" then
          build()
        elseif type(build) == "string" then
          if build:sub(1, 1) == ":" then
            build = build:sub(2)
          end

          vim.cmd(build)
        end
      end
    end
  end

  -- Stage 3: Configure the plugins
  for _, plugin in ipairs(plugins) do
    local enabled = utils.isEnabled(plugin)
    if enabled then
      local config = plugin["config"]
      if config ~= nil then
        config()
      end
    end
  end
end

function setupLazy(plugins)
  load("lazy").setup({
    spec = plugins,
  }, {
    performance = {
      reset_packpath = false,
      rtp = {
        reset = false,
      },
    },
  })
end

function module.startup(callback)
  local plugins = utils.mergearrays({
    load("plugins.decorators"),
    load("plugins.nvim-cmp"),
    -- load("plugins.nvim-dap"),
    load("plugins.nvim-treesitter"),
    load("plugins.nvim-rooter"),
    load("plugins.themes"),
  })

  if enable_vimpack then
    setupVimpack(plugins)
  else
    local _ = ensureLazy()
    setupLazy(plugins)
  end

  callback()
end

return module
