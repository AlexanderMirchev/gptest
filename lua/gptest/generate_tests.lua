local generate_tests = {}

local select = require("gptest.select")
local window = require("gptest.window")
local request = require("gptest.request")

local function generate_tests_for_highlighted_code(api_key)
  local text = select.get_selected_text()

  -- TODO use win and buf for closing the buffers
  local buf, win = window.open_window_with_buffer()

  -- TODO slows down everything else, shouldn't be blocking?
  local tests = request.generateTestsForCode(text, api_key)

  window.write_text_to_buf(tests, buf)
end

generate_tests.generate_tests_for_highlighted_code = generate_tests_for_highlighted_code
return generate_tests
