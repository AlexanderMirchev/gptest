local select = {}

local function get_selected_text()
  -- TODO sometimes select fails
  local vstart = vim.fn.getpos("'<")
  local vend = vim.fn.getpos("'>")

  local line_start = vstart[2]
  local line_end = vend[2]

  -- get all lines
  local lines = vim.api.nvim_buf_get_lines(0, line_start - 1, line_end, false)

  -- remove text before the first line start
  lines[1] = string.sub(lines[1], vstart[3], -1)
  if #lines > 1 then
    -- remove text after the last line end
    lines[#lines] = string.sub(lines[#lines], 1, vend[3])
  else
    -- remove text after the last line end
    -- however consider that the end will be shifted by the start
    lines[1] = string.sub(lines[1], 1, vend[3] - vstart[3] + 1)
  end

  return table.concat(lines, '\n')
end

local function append_text_to_buffer(text, buffer)
  vim.api.nvim_buf_set_lines(buffer, -1, -1, false, text)
end

select.get_selected_text = get_selected_text
select.append_text_to_buffer = append_text_to_buffer

return select
