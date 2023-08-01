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
      disable = false
    }

    use {
     "ms-jpq/coq.artifacts",
     branch = "artifacts"
    }

    use {
      "neovim/nvim-lspconfig",
      requires = {{
        "ms-jpq/coq_nvim",
      }},
      config = function()
        local lsp = require("lspconfig")
        lsp.csharp_ls.setup(require("coq")().lsp_ensure_capabilities())
        lsp.rust_analyzer.setup(require("coq")().lsp_ensure_capabilities())
        lsp.lua_ls.setup(require("coq")().lsp_ensure_capabilities())
      end
    }

    use {
      "nvim-treesitter/nvim-treesitter",
      run = function ()
        local ts_update = require("nvim-treesitter.install")
          .update({
            with_sync = true
          })
        ts_update()
      end,
      config = function ()
        require("nvim-treesitter.configs").setup({
          ensure_installed = { "c", "cpp", "lua", "rust", "c_sharp", },
          highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
            indent = { enable = true },
          },
        })
      end
    }

    use {
      'shaunsingh/solarized.nvim',
      config = function ()
        vim.g.solarized_italic_comments = false
        vim.g.solarized_italic_keywords = false
        vim.g.solarized_italic_functions = false
        vim.g.solarized_italic_variables = false
        vim.g.solarized_contrast = true
        vim.g.solarized_borders = false
        vim.g.solarized_disable_background = false

        -- require("solarized").set()
      end,
    }

    if packerBootstrap then
      require("packer").sync()
    end

    (callback or {})()
  end)
end


return module
