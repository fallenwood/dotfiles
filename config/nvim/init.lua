local load = require

function setVimOption(o)
  o.autoread = true
  o.number = true
  o.completeopt = {"menu"}
  o.encoding = "utf-8"
  o.cursorline = true
  o.hidden = true
  -- o.expandtab =  true
  o.list = true
  o.ignorecase = true
  o.relativenumber = true
  o.scrolloff = 4
  o.wrap = false
  o.termguicolors = true
  o.shiftround = true
  o.shiftwidth = 2
  o.sidescrolloff = 8
  o.smartcase = true
  o.smartindent = true
  o.splitbelow = true
  o.splitright = true
end

function setVimGlobal(g)
  -- g.mapleader = "<space>"
  g.mapleader = " "
end

function runTreeSitterFold()
  vim.api.nvim_create_autocmd({'BufEnter','BufAdd','BufNew','BufNewFile','BufWinEnter'}, {
  group = vim.api.nvim_create_augroup('TS_FOLD_WORKAROUND', {}),
  callback = function()
    vim.opt.foldmethod     = 'expr'
    vim.opt.foldexpr       = 'nvim_treesitter#foldexpr()'
  end
  })
end

function runCmd(cmd)
end

function loadPlugins()
  return load("plugins")
end

function setupLsp()
end

setVimOption(vim.opt)
setVimGlobal(vim.g)

load("plugins").startup(function()
  setupLsp()
  runCmd()
end)


