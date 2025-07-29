local modules = {}

local load = function(key)
  local m = modules[key]
  if m then
    return m
  else
    m = require(key)
    modules[key] = m
    return m
  end
end

return load
