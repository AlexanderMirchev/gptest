local window = {}

-- local opened_window = nil
-- local buf = nil

local function write_text_to_buf(text, buf)
  --  vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(text, '\n'))
  --  vim.api.nvim_buf_set_option(buf, 'buftype', 'nofile')
  --  vim.api.nvim_buf_set_option(buf, 'bufhidden', 'hide')
  --  vim.api.nvim_buf_set_option(buf, 'swapfile', false)
  --  vim.api.nvim_buf_set_option(buf, 'buflisted', false)
  --  vim.api.nvim_buf_set_option(buf, 'filetype', 'gptext')
  --  vim.api.nvim_buf_set_option(buf, 'modifiable', false)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(text, "\n"))
end

local function open_window_with_buffer()
  local buf = vim.api.nvim_create_buf(false, true)

  -- TODO make better
  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = 80,
    height = 20,
    col = 0,
    row = 0,
    style = "minimal",
  })

  vim.api.nvim_set_current_buf(buf)

  -- vim.api.nvim_win_set_option(opened_window, "winhl", "Normal:Normal")
  -- vim.api.nvim_win_set_option(opened_window, "wrap", false)
  -- vim.api.nvim_win_set_option(opened_window, "number", false)
  -- vim.api.nvim_win_set_option(opened_window, "relativenumber", false)
  -- vim.api.nvim_win_set_option(opened_window, "cursorline", false)
  -- vim.api.nvim_win_set_option(opened_window, "signcolumn", "no")
  -- vim.api.nvim_win_set_option(opened_window, "foldenable", false)
  -- vim.api.nvim_win_set_option(opened_window, "foldcolumn", "0")
  -- vim.api.nvim_win_set_option(opened_window, "conceallevel", 0)
  -- vim.api.nvim_win_set_option(opened_window, "scrolloff", 0)
  -- vim.api.nvim_win_set_option(opened_window, "sidescrolloff", 0)
  -- vim.api.nvim_win_set_option(opened_window, "colorcolumn", "")
  -- vim.api.nvim_win_set_option(opened_window, "winhighlight", "")
  -- vim.api.nvim_win_set_option(opened_window, "cursorcolumn", false)
  -- vim.api.nvim_win_set_option(opened_window, "cursorline", false)
  -- vim.api.nvim_win_set_option(opened_window, "signcolumn", "no")
  -- vim.api.nvim_win_set_option(opened_window, "spell", false)
  -- vim.api.nvim_win_set_option(opened_window, "list", false)

  return buf, win
end

local function open_text_in_window(text)
  local buf, opened_window = open_window_with_buffer()

  write_text_to_buf(text, buf)
end

local function get_text_from_window_and_close(buf, opened_window)
  local text = vim.api.nvim_buf_get_lines(buf, 0, -1, false)

  vim.api.nvim_buf_delete(buf, { force = true })
  buf = nil

  -- vim.api.nvim_win_close(opened_window, true)
  opened_window = nil
  return text
end

window.open_text_in_window = open_text_in_window
window.get_text_from_window_and_close = get_text_from_window_and_close
window.open_window_with_buffer = open_window_with_buffer
window.write_text_to_buf = write_text_to_buf

return window
