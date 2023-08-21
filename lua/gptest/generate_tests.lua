local generate_tests = {}

local select = require("gptest.select")
local window = require("gptest.window")
local request = require("gptest.request")
local framework_config = require("gptest.framework_config")
local async = require("plenary.async")

local buf = nil
local win = nil

local function trim(s)
  return s:match("^()%s*$") and "" or s:match("^%s*(.*%S)")
end

local function generate_tests_for_highlighted_code(api_key)
  if buf ~= nil and win ~= nil then
    vim.notify("Generated test prompt already open", vim.log.levels.ERROR)
    return
  end

  async.run(function()
    local text = trim(select.get_selected_text())
    local filetype = vim.bo.filetype
    local framework = framework_config.get_framework_for_language(filetype)

    local tests = request.generateTestsForCode(text, api_key, framework)

    local new_buf, new_win = window.open_window_with_buffer(filetype)
    buf = new_buf
    win = new_win

    -- TODO attach buf nullifying on win close
    -- vim.api.nvim_buf_attach(buf, false, {
    --   on_detach = function(bufnr, winid)
    --     if buf == bufnr then
    --       buf = nil
    --     end
    --
    --     if win == winid then
    --       win = nil
    --     end
    --   end,
    -- })

    window.write_text_to_buf(tests, buf)
  end)
end

local function get_generated_tests_and_close()
  if buf == nil and win == nil then
    vim.notify("Only works with open window", vim.log.levels.ERROR)
    return
  end
  local text = vim.api.nvim_buf_get_lines(buf, 0, -1, false)

  vim.api.nvim_buf_delete(buf, { force = true })
  buf = nil

  -- vim.api.nvim_win_close(win, true)
  win = nil

  return text
end

generate_tests.generate_tests_for_highlighted_code = generate_tests_for_highlighted_code
generate_tests.get_generated_tests_and_close = get_generated_tests_and_close
return generate_tests
