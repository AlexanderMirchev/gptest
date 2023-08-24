local curl = require("plenary.curl")
local async = require("plenary.async")

local a = {}

local function getResponseFromGptApi(prompt, api_key)
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
  }

  local body = vim.json.encode(request_body)
  local headers = { ["Content-Type"] = "application/json", ["Authorization"] = "Bearer " .. api_key }

  local response_body = vim.json.decode(curl.post("https://api.openai.com/v1/chat/completions", {
    headers = headers,
    body = body,
    timeout = 30000,
  }).body)

  return response_body
end

a.generateTestsForCode = function(code, api_key, framework)
  local prompt = "I want you to write unit tests using "
    .. (framework or "default")
    .. " framework for my code ``"
    .. code
    .. "``. Please only include the code without explanations, along with the testing framework used comment."
  local response_body = getResponseFromGptApi(prompt, api_key)
  local tests = response_body.choices[1].message.content

  return tests
end

return a
