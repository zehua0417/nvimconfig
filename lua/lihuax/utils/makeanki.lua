local function make_anki()
	local start_line, end_line = vim.fn.search("^\\s*$", "bnW"), vim.fn.search("^\\s*$", "nW")
	if start_line == 0 then
		start_line = 1
	end -- 起始行未找到空行时，默认为第一行
	if end_line == 0 then
		end_line = vim.fn.line("$")
	end -- 终止行未找到空行时，默认为文件尾

	-- 遍历每一行，处理段落格式
	for i = start_line, end_line do
		local line_text = vim.fn.getline(i)
		if i == start_line then
		elseif i == end_line then
		elseif i == start_line + 1 then
			-- 段落的第一行添加 `> [!ANKI] `
			vim.fn.setline(i, "> [!ANKI] " .. line_text)
		else
			-- 其他行添加 `> `
			vim.fn.setline(i, "> " .. line_text)
		end
	end
end

local function make_anki_visual()
	-- 获取visual模式下选择的行范围
	local start_line = vim.fn.line("'<")
	local end_line = vim.fn.line("'>")

	-- 遍历每一行并处理段落格式
	for i = start_line, end_line - 1 do
		local line_text = vim.fn.getline(i)
		if i == start_line then
			-- 段落的第一行添加 `> [!ANKI] `
			vim.fn.setline(i, "> [!ANKI] " .. line_text)
		elseif i == start_line + 1 and line_text == "" then
			-- 如果段落的第二行为空行，删除第二行连同换行符
			vim.api.nvim_buf_set_lines(0, i - 1, i, false, {})
			line_text = vim.fn.getline(i)
			vim.fn.setline(i, "> " .. line_text)
		else
			-- 其他行添加 `> `
			vim.fn.setline(i, "> " .. line_text)
		end
	end
end

-- 绑定到快捷键（如 <leader>p）
vim.api.nvim_create_user_command("MakeAnki", make_anki, {})
vim.api.nvim_create_user_command("MakeAnkiVisual", make_anki_visual, { range = true })
vim.api.nvim_set_keymap("n", "<leader>ak", ":MakeAnki<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<leader>ak", ":MakeAnkiVisual<CR>", { noremap = true, silent = true })
