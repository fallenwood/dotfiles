local module = {}

module.merge = function(t1, t2)
  for k, v in pairs(t2) do
    t1[k] = v
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

return module
