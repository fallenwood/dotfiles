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

    -- use {
    --   "ms-jpq/coq.artifacts",
    --   branch = "artifacts"
    -- }

    local lspFts = vim.g.lspFts or {}

    use {
      "neovim/nvim-lspconfig",
      opt = true,
      ft = lspFts,
      requires = {{
        "ms-jpq/coq_nvim",
      }},
      config = function()
        local lsp = require("lspconfig")
        -- lsp.csharp_ls.setup(require("coq")().lsp_ensure_capabilities())
      end
    }

    if packerBootstrap then
      require("packer").sync()
    end

    (callback or {})()
  end)
end


return module
