local select = {}

local function get_selected_text()
  local a_orig = vim.fn.getreg('a')
  local mode = vim.fn.mode()
  if mode ~= 'v' and mode ~= 'V' then
    -- reselects text
    vim.cmd([[normal! gv]])
  end

  -- yanks into buffer and reselects text
  vim.cmd([[silent! normal! "aygv]])
  local text = vim.fn.getreg('a')
  vim.fn.setreg('a', a_orig)
  return text
end

local function append_text_to_buffer(text, buffer)
  vim.api.nvim_buf_set_lines(buffer, -1, -1, false, text)
end

select.get_selected_text = get_selected_text
select.append_text_to_buffer = append_text_to_buffer

return select
