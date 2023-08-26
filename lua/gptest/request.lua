local Job = require("plenary.job")
local async = require("plenary.async")

local request = {}

local function getResponseFromGptApi(code, filetype, framework, api_key, on_received)
  local prompt = "I want you to write unit tests using "
    .. (framework or "default")
    .. " framework for my code ``"
    .. code
    .. "``. Please only include the tests without explanations and quotation marks, along with the testing framework used comment."

  local messages = {
    {
      role = "user",
      content = prompt,
    },
  }

  -- https://platform.openai.com/docs/guides/chat for more info
  local request_body = {
    model = "gpt-3.5-turbo",
    messages = messages,
    -- max_tokens = 250,
    n = 1,
    temperature = 0,
  }

  local body = vim.json.encode(request_body)

  local job = Job:new({
    command = "curl",
    args = {
      "-X",
      "POST",
      "--data",
      body,
      "--header",
      "Authorization: Bearer " .. api_key,
      "--header",
      "Content-Type: application/json",
      "https://api.openai.com/v1/chat/completions",
    },
    timeout = 15000,
    on_exit = function(res)
      local result = vim.json.decode(table.concat(res:result(), ""))
      on_received(filetype, result.choices[1].message.content)
    end,
  })
  job:start()
end

request.getResponseFromGptApi = getResponseFromGptApi

return request
