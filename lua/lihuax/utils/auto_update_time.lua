local M = {}

--- Update a line matching a pattern with today's date, optionally at a specific line.
--- @param pattern string 匹配行的正则表达式
--- @param replacement_format string os.date 格式，如 "update: %Y-%m-%d %H:%M:%S"
--- @param check_lines integer|nil 如果指定，只检查该行（1-based），否则检查整个文件
M.update_date_field = function(pattern, replacement_format, check_lines)
	local filetypes = { "markdown", "tex", "text" }
	local ft = vim.bo.filetype
	if not vim.tbl_contains(filetypes, ft) then
		return
	end

	local bufnr = vim.api.nvim_get_current_buf()
	local total_lines = vim.api.nvim_buf_line_count(bufnr)
	local check_upto = check_lines or total_lines

	-- 防止越界
	check_upto = math.min(check_upto, total_lines)

	local new_line = os.date(replacement_format)
	local lines = vim.api.nvim_buf_get_lines(bufnr, 0, check_upto, false)

	for i, l in ipairs(lines) do
		if l:match(pattern) then
			vim.api.nvim_buf_set_lines(bufnr, i - 1, i, false, { new_line })
			return
		end
	end
end

return M
