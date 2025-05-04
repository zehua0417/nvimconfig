local M = {}

-- Define base directories
-- M.BASE_DIR = "/home/lihuax/Documents/obs_repo/diary"
M.BASE_DIR = "/home/lihuax/Onedrive/work/ob_repo/diary"

function M.touch_today_diary()
	-- Temporarily set locale to English
	local original_locale = os.setlocale(nil, "time")
	os.setlocale("en_US", "time")

	-- Get today's date
	local date = os.date("*t")
	local year = date.year
	local day = date.day
	local month = os.date("%b") -- Get English month abbreviation

	local formatted_date = string.format("%04d-%02d-%02d", year, date.month, day)

	-- Construct paths
	local month_path = string.format("%s/%04d/%s", M.BASE_DIR, year, month)
	local file_path = string.format("%s/%s.md", month_path, formatted_date)
	local gpg_file_path = file_path .. ".gpg"

	-- Ensure directory exists
	vim.fn.mkdir(month_path, "p")

	-- Open existing file or create a new one
	if vim.fn.filereadable(gpg_file_path) == 1 then
		vim.cmd("edit " .. vim.fn.fnameescape(gpg_file_path))
	elseif vim.fn.filereadable(file_path) == 1 then
		vim.cmd("edit " .. vim.fn.fnameescape(file_path))
	else
		local file = io.open(file_path, "a")
		if file then
			file:close()
			print("Today's diary has been created: " .. file_path)
			vim.cmd("edit " .. vim.fn.fnameescape(file_path))
		else
			print("Error: Unable to create the diary file.")
		end
	end

	-- Restore original locale
	os.setlocale(original_locale, "time")
end

function M.touch_weekly_journal()
	-- Temporarily set locale to English
	local original_locale = os.setlocale(nil, "time")
	os.setlocale("en_US", "time")

	-- Get ISO year and week number
	local year_iso = os.date("%G")
	local week_number = tonumber(os.date("%V"))

	-- Construct paths
	local year_path = string.format("%s/%s", M.BASE_DIR, year_iso)
	local file_path = string.format("%s/Week_%02d.md", year_path, week_number)
	local gpg_file_path = file_path .. ".gpg"

	-- Ensure directory exists
	vim.fn.mkdir(year_path, "p")

	-- Open existing file or create a new one
	if vim.fn.filereadable(gpg_file_path) == 1 then
		vim.cmd("edit " .. vim.fn.fnameescape(gpg_file_path))
	elseif vim.fn.filereadable(file_path) == 1 then
		vim.cmd("edit " .. vim.fn.fnameescape(file_path))
	else
		local file = io.open(file_path, "a")
		if file then
			file:close()
			print("Weekly journal has been created: " .. file_path)
			vim.cmd("edit " .. vim.fn.fnameescape(file_path))
		else
			print("Error: Unable to create the weekly journal file.")
		end
	end

	-- Restore original locale
	os.setlocale(original_locale, "time")
end

function M.touch_dev_weekly_journal()
	-- Temporarily set locale to English
	local original_locale = os.setlocale(nil, "time")
	os.setlocale("en_US", "time")

	-- Get ISO year and week number
	local year_iso = os.date("%G")
	local week_number = tonumber(os.date("%V"))

	-- Construct paths
	local base_path = vim.fn.getcwd()
	local dev_docs_path = base_path .. "/devDocs"
	local file_path = string.format("%s/%04dW%02d.md", dev_docs_path, year_iso, week_number)
	local gpg_file_path = file_path .. ".gpg"

	-- Check if devDocs directory exists
	if vim.fn.isdirectory(dev_docs_path) == 0 then
		print("Error: The 'devDocs' directory does not exist. Please create it in the project root.")
		return
	end

	-- Open existing file or create a new one
	if vim.fn.filereadable(gpg_file_path) == 1 then
		vim.cmd("edit " .. vim.fn.fnameescape(gpg_file_path))
	elseif vim.fn.filereadable(file_path) == 1 then
		vim.cmd("edit " .. vim.fn.fnameescape(file_path))
	else
		local file = io.open(file_path, "a")
		if file then
			file:close()
			print("Development weekly journal has been created: " .. file_path)
			vim.cmd("edit " .. vim.fn.fnameescape(file_path))
		else
			print("Error: Unable to create the development weekly journal file.")
		end
	end

	-- Restore original locale
	os.setlocale(original_locale, "time")
end

return M
