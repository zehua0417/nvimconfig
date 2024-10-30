return {
	"glepnir/template.nvim",
	cmd = { "Template", "TemProject" },
	config = function()
		require("template").setup({
			temp_dir = "~/.config/nvim/templates",
			author = "Lihuax",
			email = "zehuali0417@gmail.com",
		})

		local function get_weekday_date(today, n)
			local year, month, day = today:match("(%d+)-(%d+)-(%d+)")
			local date = os.time({ year = year, month = month, day = day })
			local weekday = os.date("*t", date).wday - 1 -- Lua中wday为1-7，减1变为0-6
			local offset = n - weekday
			local target_date = os.date("%Y-%m-%d", date + offset * 86400)
			return target_date
		end

		-- Get day of a week at year beginning
		--(tm can be any date and will be forced to 1st of january same year)
		-- return 1=mon 7=sun
		local function getYearBeginDayOfWeek(tm)
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
		local function getDayAdd(tm)
			local yearBeginDayOfWeek = getYearBeginDayOfWeek(tm)
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
		local function getWeekNumberOfYear(tm)
			local dayOfYear = os.date("%j", tm)
			local dayAdd = getDayAdd(tm)
			local dayOfYearCorrected = dayOfYear + dayAdd
			if dayOfYearCorrected < 0 then
				-- week of last year - decide if 52 or 53
				local lastYearBegin = os.time({ year = os.date("*t", tm).year - 1, month = 1, day = 1 })
				local lastYearEnd = os.time({ year = os.date("*t", tm).year - 1, month = 12, day = 31 })
				dayAdd = getDayAdd(lastYearBegin)
				dayOfYear = dayOfYear + os.date("%j", lastYearEnd)
				dayOfYearCorrected = dayOfYear + dayAdd
			end
			local weekNum = math.floor(dayOfYearCorrected / 7) + 1
			if (dayOfYearCorrected > 0) and weekNum == 53 then
				-- check if it is not considered as part of week 1 of next year
				local nextYearBegin = os.time({ year = os.date("*t", tm).year + 1, month = 1, day = 1 })
				local yearBeginDayOfWeek = getYearBeginDayOfWeek(nextYearBegin)
				if yearBeginDayOfWeek < 5 then
					weekNum = 1
				end
			end
			return weekNum
		end

		local function get_date_days_ago(days)
			local date = os.time() - (days * 86400)
			return os.date("%Y-%m-%d", date)
		end

		require("template").register("{{_sunday_}}", function()
			return get_weekday_date(os.date("%Y-%m-%d"), 0)
		end)
		require("template").register("{{_monday_}}", function()
			return get_weekday_date(os.date("%Y-%m-%d"), 1)
		end)
		require("template").register("{{_tuesday_}}", function()
			return get_weekday_date(os.date("%Y-%m-%d"), 2)
		end)
		require("template").register("{{_wednesday_}}", function()
			return get_weekday_date(os.date("%Y-%m-%d"), 3)
		end)
		require("template").register("{{_thursday_}}", function()
			return get_weekday_date(os.date("%Y-%m-%d"), 4)
		end)
		require("template").register("{{_friday_}}", function()
			return get_weekday_date(os.date("%Y-%m-%d"), 5)
		end)
		require("template").register("{{_saturday_}}", function()
			return get_weekday_date(os.date("%Y-%m-%d"), 6)
		end)
		require("template").register("{{_lastweeknum_}}", function()
			return getWeekNumberOfYear(os.time() - 7 * 24 * 60 * 60)
		end)
		require("template").register("{{_nextweeknum_}}", function()
			return getWeekNumberOfYear(os.time() + 7 * 24 * 60 * 60)
		end)
	end,
}
