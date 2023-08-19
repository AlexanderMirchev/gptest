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
    max_tokens = 250,
    n = 1,
  }

  local body = vim.json.encode(request_body)
  local headers = { ["Content-Type"] = "application/json", ["Authorization"] = "Bearer " .. api_key }

  local response_body = vim.json.decode(curl.post("https://api.openai.com/v1/chat/completions", {
    headers = headers,
    body = body,
  }).body)

  --TODO remove mock response
  --local jsonString = '{"id":"chatcmpl-7DwYs16LCxP2q5DIyimAZPRbI9HLb","object":"chat.completion","model":"gpt-3.5-turbo-0301","choices":[{"message":{"role":"assistant","content":"```\ndescribe(\'getIsSearchResultInstrumentViewOnly\', () => {\n  test(\'returns true for partial view only\', ()\n => {\n    const searchResultInstrument = {};\n    const isCfdInstrument = true;\n    const tradingType = \'buy\';\n    const dealer = \'dealer1\';\n\n    const result = getIsSearchResultInstrumentViewOnly(searchResultInstrument, isCfdInstrument, tradingType, dealer);\\n\n    expect(result).toBe(true);\n  });\n\n  test(\'returns false for full view\', () => {\n    const searchResultInstrument = {};\n    const isCfdInstrument = true;\n    const tradingType = \'buy\';\n    const dealer = \'dealer2\';\n\n    const result = getIsSearchResultInstrumentViewOnly(searchResultInstrument, isCfdInstrument, tradingType, dealer);\\n\n    expect(result).toBe(false);\n  });\n});\n```"},"finish_reason":"stop","index":0}],"created":1683557730,"usage":{"prompt_tokens":104,"completion_tokens":174,"total_tokens":278}}'
  --local response_body = vim.json.decode(jsonString)

  return response_body
end

a.generateTestsForCode = function(code, api_key)
  local prompt = "I want you to write unit tests for my code ``"
    .. code
    .. "``. Please only include the code without additional explainations"
  -- local response_body = getResponseFromGptApi(prompt, api_key)
  -- local tests = response_body.choices[1].message.content
  --
  -- return tests

  async.util.sleep(3000)

  return code
end

return a
