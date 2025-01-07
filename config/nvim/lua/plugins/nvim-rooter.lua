local load = require

local module = {
  {
    "notjedi/nvim-rooter.lua",
    config = function()
    local rooter = load("nvim-rooter")
      rooter.setup({
        rooter_patterns = { ".git" },
      })
    end,
  },
}

return module
