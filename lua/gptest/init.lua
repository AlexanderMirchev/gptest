local generate_tests = require('gptest.generate_tests')

-- local isPromptOpen = false
local config = {}

local gptest = {}

gptest.setup = function(userConfig)
  if type(userConfig.api_key) ~= 'string' then
    error("You must provide an api key")
  end

  config = userConfig
end

-- local function open_prompt_with_selected()
--   local selectedText = require('gptest.select').get_selected_text()
--   require('gptest.window').open_text_in_window(selectedText)
--   -- isPromptOpen = true
-- end

local function close_prompt_and_append()
  local text = require('gptest.window').get_text_from_window_and_close()
  require('gptest.select').append_text_to_buffer(text, 0)
  -- isPromptOpen = false
end

local function test()
  -- print(isPromptOpen)
  -- if isPromptOpen then
  -- close_prompt_and_append()
  -- else
  -- open_prompt_with_selected()
  -- end
  generate_tests.generate_tests_for_highlighted_code(config.api_key)
end

gptest.test = test
return gptest
