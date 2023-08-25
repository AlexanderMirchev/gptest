local window = {}

local function write_text_to_buf(text, buf)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(text, "\n"))
end

local function open_window_with_buffer(filetype)
  local buf = vim.api.nvim_create_buf(false, true)

  vim.api.nvim_buf_set_option(buf, "buftype", "nofile")
  vim.api.nvim_buf_set_option(buf, "bufhidden", "hide")
  vim.api.nvim_buf_set_option(buf, "swapfile", false)
  vim.api.nvim_buf_set_option(buf, "buflisted", false)
  vim.api.nvim_buf_set_option(buf, "filetype", filetype)

  local win_width = vim.fn.winwidth(0) * 0.6
  local win_height = vim.fn.winheight(0) * 0.6

  local win_row = (vim.fn.winheight(0) - win_height) / 2
  local win_col = (vim.fn.winwidth(0) - win_width) / 2

  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    row = win_row,
    col = win_col,
    width = 100,
    height = 50,
    border = "rounded",
  })

  vim.api.nvim_set_current_buf(buf)

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

  opened_window = nil
  return text
end

window.open_text_in_window = open_text_in_window
window.get_text_from_window_and_close = get_text_from_window_and_close
window.open_window_with_buffer = open_window_with_buffer
window.write_text_to_buf = write_text_to_buf

return window
