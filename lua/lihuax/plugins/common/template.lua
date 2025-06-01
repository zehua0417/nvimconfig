return {
	"glepnir/template.nvim",
	cmd = { "Template", "TemProject" },
	keys = {
		{ "<leader>tl", ":Template ", desc = "Insert template" },
	},

	config = function()
		require("template").setup({
			temp_dir = "~/.config/nvim/templates",
			author = "Lihuax",
			email = "zehuali0417@gmail.com",
		})

		local function get_weekday_date(today, n)
			local year, month, day = today:match("(%d+)-(%d+)-(%d+)")
			local date = os.time({ year = year, month = month, day = day })
			local weekday = os.date("*t", date).wday - 1
			local offset = n - weekday
			local target_date = os.date("%Y-%m-%d", date + offset * 86400)
			return target_date
		end

		-- local function get_date_days_ago(days)
		-- 	local date = os.time() - (days * 86400)
		-- 	return os.date("%Y-%m-%d", date)
		-- end

		local getWeekNumberOfYear = require("lihuax.utils.diary").getWeekNumberOfYear

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
