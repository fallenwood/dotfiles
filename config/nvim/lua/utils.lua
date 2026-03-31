local module = {}

module.merge = function(t1, t2)
  for _, v in ipairs(t2) do
    table.insert(t1, v)
  end

  return t1
end

module.mergearrays = function (arrays)
  local result = {}
  for _, array in ipairs(arrays) do
    for _, value in ipairs(array) do
      table.insert(result, value)
    end
  end

  return result
end

module.isEnabled = function(plugin)
  local enabled = plugin["enabled"]
  if enabled == nil then
    return true
  else
    return enabled
  end
end

return module
