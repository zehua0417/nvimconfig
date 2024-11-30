vim.api.nvim_set_keymap(
	"n",
	"<leader>au",
	"<cmd>set fileformat=unix<CR>",
	{ noremap = true, silent = true, desc = "Set file format to unix" }
)

vim.api.nvim_set_keymap(
	"v",
	"<leader>as",
	":SwitchText<CR>",
	{ noremap = true, silent = true, desc = "Switch text format to english" }
)

vim.api.nvim_set_keymap(
	"v",
	"<leader>ab",
	":TextBf<CR>",
	{ noremap = true, silent = true, desc = "Add ** to selected text" }
)

vim.api.nvim_set_keymap(
	"v",
	"<leader>ai",
	":TextIt<CR>",
	{ noremap = true, silent = true, desc = "Add __ to selected text" }
)

vim.api.nvim_set_keymap(
	"v",
	"<leader>an",
	":ChangeNum<cr>",
	{ noremap = true, silent = true, desc = "Change circle number to arabic number" }
)

vim.api.nvim_set_keymap(
	"v",
	"<leader>ap",
	":TogglePeriod<cr>",
	{ noremap = true, silent = true, desc = "Toggle English period to Chinese" }
)

local function switch_text_in_visual_mode()
	-- 获取当前视觉模式下选中的文本范围
	vim.cmd('normal! gvg"')

	-- 定义替换模式
	local replacements = {
		{ "（", "(" },
		{ "）", ")" },
		{ "( ", "(" },
		{ ") ", ")" },
		{ " (", "(" },
		{ " )", ")" },
		{ "， ", "，" },
		{ "，", ", " },
		{ "“", '"' },
		{ "”", '"' },
		{ "‘", "'" },
		{ "’", "'" },
		{ "： ", "：" },
		{ "：", ": " },
		{ "；", ";" },
		{ "。 ", "。" },
	}

	-- 进行批量替换
	for _, pair in ipairs(replacements) do
		vim.cmd(string.format("silent! '<,'>s/%s/%s/g", pair[1], pair[2]))
	end

	-- 删除不必要的空格
	local patterns = {
		[[\(\%([^\x00-\xff]\)\)\zs\s\+\ze\%([a-zA-Z]\)]], -- 中文与英文之间
		[[\(\%([a-zA-Z]\)\)\zs\s\+\ze\%([^\x00-\xff]\)]], -- 英文与中文之间
		[[\(\%([^\x00-\xff]\)\)\zs\s\+\ze\%([^\x00-\xff]\)]], -- 中文与中文之间
		[[\(\%([^\x00-\xff]\)\)\zs\s\+\ze\%([0-9]\)]], -- 中文与数字之间
		[[\(\%([0-9]\)\)\zs\s\+\ze\%([^\x00-\xff]\)]], -- 数字与中文之间
		[[\s\+$]], -- 每行末尾多余空格
	}

	-- 执行空格清理
	for _, pattern in ipairs(patterns) do
		vim.cmd(string.format("silent! '<,'>s/%s//g", pattern))
	end
end

vim.api.nvim_create_user_command("SwitchText", function()
	switch_text_in_visual_mode()
end, { range = true })

local function add_stars()
	local end_row, end_col = vim.fn.getpos("'>")[2], vim.fn.getpos("'>")[3]
	local start_row, start_col = vim.fn.getpos("'<")[2], vim.fn.getpos("'<")[3]

	local lines = vim.fn.getline(start_row, end_row)
	if #lines == 0 then
		return
	end

	lines[#lines] = lines[#lines]:sub(1, end_col) .. "**" .. lines[#lines]:sub(end_col + 1)
	lines[1] = lines[1]:sub(1, start_col - 1) .. "**" .. lines[1]:sub(start_col)

	vim.fn.setline(start_row, lines)
end

local function add_undline()
	local end_row, end_col = vim.fn.getpos("'>")[2], vim.fn.getpos("'>")[3]
	local start_row, start_col = vim.fn.getpos("'<")[2], vim.fn.getpos("'<")[3]

	local lines = vim.fn.getline(start_row, end_row)
	if #lines == 0 then
		return
	end

	lines[#lines] = lines[#lines]:sub(1, end_col) .. "__" .. lines[#lines]:sub(end_col + 1)
	lines[1] = lines[1]:sub(1, start_col - 1) .. "__" .. lines[1]:sub(start_col)

	vim.fn.setline(start_row, lines)
end

vim.api.nvim_create_user_command("TextBf", function()
	add_stars()
end, { range = true })

vim.api.nvim_create_user_command("TextIt", function()
	add_undline()
end, { range = true })

local function ChangeNum()
	-- 定义映射表
	local num_map = {
		["①"] = "1. ",
		["②"] = "2. ",
		["③"] = "3. ",
		["④"] = "4. ",
		["⑤"] = "5. ",
		["⑥"] = "6. ",
		["⑦"] = "7. ",
		["⑧"] = "8. ",
		["⑨"] = "9. ",
		["⑩"] = "10. ",
	}

	-- 遍历映射表并执行替换
	for symbol, replacement in pairs(num_map) do
		vim.cmd(string.format("silent! '<,'>s/^%s/%s/g", symbol, replacement))
		vim.cmd(string.format("silent! '<,'>s/%s/\\r%s/g", symbol, replacement))
	end
end

vim.api.nvim_create_user_command("ChangeNum", ChangeNum, { range = true })

local function toggle_period()
	-- 获取视觉模式下选中的区域
	local start_pos = vim.fn.getpos("'<")
	local end_pos = vim.fn.getpos("'>")
	local start_row, start_col = start_pos[2], start_pos[3]
	local end_row, end_col = end_pos[2], end_pos[3]

	-- 获取选中的行内容
	local lines = vim.api.nvim_buf_get_lines(0, start_row - 1, end_row, false)

	-- 遍历行并替换
	for i, line in ipairs(lines) do
		if i == 1 then -- 第一行可能从中间开始
			line = line:sub(1, start_col - 1) .. line:sub(start_col):gsub("%.", "。")
		elseif i == #lines then -- 最后一行可能到中间结束
			line = line:sub(1, end_col):gsub("%.", "。") .. line:sub(end_col + 1)
			-- 修正：如果 end_col 是整行最后一个字符，则不拼接多余部分
			if end_col == #line then
				line = line:sub(1, end_col):gsub("%.", "。")
			end
		else -- 中间行完整替换
			line = line:gsub("%.", "。")
		end
		lines[i] = line
	end

	-- 写回缓冲区
	vim.api.nvim_buf_set_lines(0, start_row - 1, end_row, false, lines)
end

vim.api.nvim_create_user_command("TogglePeriod", toggle_period, { range = true })
