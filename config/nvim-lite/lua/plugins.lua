local module = {}

local ensurePacker = function()
  local fn = vim.fn
  local installPath = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

  if fn.empty(fn.glob(installPath)) > 0 then
    fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', installPath})
    vim.cmd [[packadd packer.nvim]]
    return true
  end

  return false
end

function module.startup(callback)
  local packerBootstrap = ensurePacker()

  return require("packer").startup(function(use)
    use "wbthomason/packer.nvim"

    use {
      "ms-jpq/coq_nvim",
      branch = "coq",
      event = "InsertEnter",
      run = ":COQdeps",
      disable = false
    }

    if packerBootstrap then
      require("packer").sync()
    end

    (callback or {})()
  end)
end


return module
