local json = require("json")
local http = require("socket.http")
local url = require("socket.url")
local ltn12 = require("ltn12")

local key = "dd3adda0f99cbc8edf940468ad4b19e5b2d47788b1c22d18243ab9f93a139907"

local headers = {
  Authorization = 'Bearer ' .. key,
  ['content-Type'] = 'application/json'
}

local base_url = "http://192.168.1.107:5000"


local function fetch_text(url, op)
  local response_body = {}

  local request_op = {
    url = url,
    sink = ltn12.sink.table(response_body)
  }

  if op then
    for k, v in pairs(op) do
      if k ~= 'url' then
        request_op[k] = v
      end
    end
  end

  local source = request_op['source']
  if source then
    request_op['source'] = ltn12.source.string(source)
  end

  local _, code = http.request(request_op)

  -- 将response_body数组转换为字符串
  local response_str = table.concat(response_body)

  return code, response_str
end

local translator = {}

---@param env Env
function translator.init(env)
  env.memory = Memory(env.engine, env.engine.schema)
  env.notifier = env.engine.context.commit_notifier:connect(function(ctx)
    local commit = ctx.commit_history:back()
    if commit then
      fetch_text(base_url .. "/commit", {
        headers = headers,
        method = "POST",
        source = json.encode({
          text = commit.text,
          update = true,
          new = true
        })
      })
    end
  end)
end

function translator.fini(env)
  env.notifier:disconnect()
  env.memory:disconnect()
  env.memory = nil
  collectgarbage()
end

---@param input string
---@param seg Segment
---@param env Env
function translator.func(input, seg, env)
  local ctx = env.engine.context
  local preedit = ctx:get_preedit().text
  if preedit ~= '' then
    local had_select_text = string.sub(preedit, 0, string.len(preedit) - (seg._end - seg.start))
    if had_select_text ~= '' then
      fetch_text(base_url .. "/commit", {
        headers = headers,
        method = "POST",
        source = json.encode({
          text = had_select_text,
          update = true,
          new = false
        })
      })
    end
  end

  local qp = input
  local code, reply = fetch_text(base_url .. "/candidates", {
    headers = headers,
    method = "POST",
    source = json.encode({
      keys = qp
    })
  })
  local _, j = pcall(json.decode, reply)
  if code == 200 and _ then
    for i, v in ipairs(j.candidates) do
      local word = string.gsub(v['word'], "'", " ")
      local c = Candidate("normal", seg.start, seg.start + v['consumedkeys'], word, "")
      c.quality = 2
      c.preedit = v["preedit"]
      yield(c)
    end
  end
end

return { translator = translator }
