local M = {}

function M.touch_today_diary()
	-- 临时设置环境变量 LC_TIME 为英文
	local original_locale = os.setlocale(nil, "time") -- 获取当前区域设置
	os.setlocale("en_US", "time") -- 设置为英文区域

	-- 获取今天的日期
	local date = os.date("*t")
	local year = date.year
	local day = date.day
	local month = os.date("%b") -- 直接获取英文缩写月份

	local formatted_date = string.format("%04d-%02d-%02d", year, date.month, day)

	-- 构建目录和文件路径
	local base_path = "/home/lihuax/Documents/obs_repo/diary"
	local month_path = string.format("%s/%04d/%s", base_path, year, month)
	local file_path = string.format("%s/%s.md", month_path, formatted_date)

	-- 确保目录存在
	vim.fn.mkdir(month_path, "p")

	-- touch 文件
	local file = io.open(file_path, "a")
	if file then
		file:close()
		print("今日的日记已创建或更新: " .. file_path)
		-- 打开文件在当前 Neovim buffer 中
		vim.cmd("edit " .. vim.fn.fnameescape(file_path))
	else
		print("无法创建文件: " .. file_path)
	end

	-- 恢复原始区域设置
	os.setlocale(original_locale, "time")
end

return M
