local generate_tests = {}

local select = require("gptest.select")
local window = require("gptest.window")
local request = require("gptest.request")
local async = require("plenary.async")

local function generate_tests_for_highlighted_code(api_key)
  async.run(function()
    local text = select.get_selected_text()
    local filetype = vim.bo.filetype

    local tests = request.generateTestsForCode(text, api_key)
    -- TODO use win and buf for closing the buffers
    local buf, win = window.open_window_with_buffer(filetype)

    window.write_text_to_buf(tests, buf)
  end)
end

generate_tests.generate_tests_for_highlighted_code = generate_tests_for_highlighted_code
return generate_tests
