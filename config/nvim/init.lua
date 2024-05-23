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

function setupTerminal()
  vim.keymap.set('n', '<leader>wh', '<C-\\><C-n><C-w>h')
  vim.keymap.set('n', '<leader>wl', '<C-\\><C-n><C-w>l')
  vim.keymap.set('n', '<leader>to', function()
    vim.cmd.vsplit()
    vim.cmd.terminal()
  end, nil)
  vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')
end


function setupLsp()
  local function quickfix()
    vim.lsp.buf.code_action({
      filter = function(a) return a.isPreferred end,
      apply = true,
    })
  end
  local opts = {
    noremap = true,
    slient = true,
  }

  vim.keymap.set('n', '<leader>qf', quickfix, {})
end

setVimOption(vim.opt)
setVimGlobal(vim.g)

setupTerminal()

load("plugins").startup(function()
  setupLsp()
  runCmd()
end)


