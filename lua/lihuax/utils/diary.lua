local M = {}

-- Define base directories
-- M.BASE_DIR = "/home/lihuax/Documents/obs_repo/diary"
M.BASE_DIR = "/home/lihuax/Onedrive/work/ob_repo/diary"

-- Get day of a week at year beginning
--(tm can be any date and will be forced to 1st of january same year)
-- return 1=mon 7=sun
function M.getYearBeginDayOfWeek(tm)
	local yearBegin = os.time({ year = os.date("*t", tm).year, month = 1, day = 1 })
	local yearBeginDayOfWeek = tonumber(os.date("%w", yearBegin))
	-- sunday correct from 0 -> 7
	if yearBeginDayOfWeek == 0 then
		yearBeginDayOfWeek = 7
	end
	return yearBeginDayOfWeek
end
-- tm: date (as retruned fro os.time)
-- returns basic correction to be add for counting number of week
--  weekNum = math.floor((dayOfYear + returnedNumber) / 7) + 1
-- (does not consider correctin at begin and end of year)
function M.getDayAdd(tm)
	local yearBeginDayOfWeek = M.getYearBeginDayOfWeek(tm)
	local dayAdd = 1
	if yearBeginDayOfWeek < 5 then
		-- first day is week 1
		dayAdd = (yearBeginDayOfWeek - 2)
	else
		-- first day is week 52 or 53
		dayAdd = (yearBeginDayOfWeek - 9)
	end
	return dayAdd
end
-- tm is date as returned from os.time()
-- return week number in year based on ISO8601
-- (week with 1st thursday since Jan 1st (including) is considered as Week 1)
-- (if Jan 1st is Fri,Sat,Sun then it is part of week number from last year -> 52 or 53)
function M.getWeekNumberOfYear(tm)
	local dayOfYear = os.date("%j", tm)
	local dayAdd = M.getDayAdd(tm)
	local dayOfYearCorrected = dayOfYear + dayAdd
	if dayOfYearCorrected < 0 then
		-- week of last year - decide if 52 or 53
		local lastYearBegin = os.time({ year = os.date("*t", tm).year - 1, month = 1, day = 1 })
		local lastYearEnd = os.time({ year = os.date("*t", tm).year - 1, month = 12, day = 31 })
		dayAdd = M.getDayAdd(lastYearBegin)
		dayOfYear = dayOfYear + os.date("%j", lastYearEnd)
		dayOfYearCorrected = dayOfYear + dayAdd
	end
	local weekNum = math.floor(dayOfYearCorrected / 7) + 1
	if (dayOfYearCorrected > 0) and weekNum == 53 then
		-- check if it is not considered as part of week 1 of next year
		local nextYearBegin = os.time({ year = os.date("*t", tm).year + 1, month = 1, day = 1 })
		local yearBeginDayOfWeek = M.getYearBeginDayOfWeek(nextYearBegin)
		if yearBeginDayOfWeek < 5 then
			weekNum = 1
		end
	end
	return weekNum
end

function M.touch_today_diary()
	-- Temporarily set locale to English
	local original_locale = os.setlocale(nil, "time")
	os.setlocale("en_US", "time")

	-- Get today's date
	local date = os.date("*t")
	local year = date.year
	local day = date.day
	local month = os.date("%b") -- Get English month abbreviation

	local formatted_date = string.format("Diary_%04d-%02d-%02d", year, date.month, day)

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
	local week_number = M.getWeekNumberOfYear(os.time())

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
