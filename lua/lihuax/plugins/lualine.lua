return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local lualine = require("lualine")
		local lazy_status = require("lazy.status") -- to configure lazy pending updates count

		--local colors = {
		--	blue = "#65D1FF",
		--	green = "#3EFFDC",
		--	violet = "#FF61EF",
		--	yellow = "#FFDA7B",
		--	red = "#FF4A4A",
		--	fg = "#c3ccdc",
		--	bg = "#112638",
		--	inactive_bg = "#2c3043",
		--}

		--local my_lualine_theme = {
		--	normal = {
		--		a = { bg = colors.blue, fg = colors.bg, gui = "bold" },
		--		b = { bg = colors.bg, fg = colors.fg },
		--		c = { bg = colors.bg, fg = colors.fg },
		--	},
		--	insert = {
		--		a = { bg = colors.green, fg = colors.bg, gui = "bold" },
		--		b = { bg = colors.bg, fg = colors.fg },
		--		c = { bg = colors.bg, fg = colors.fg },
		--	},
		--	visual = {
		--		a = { bg = colors.violet, fg = colors.bg, gui = "bold" },
		--		b = { bg = colors.bg, fg = colors.fg },
		--		c = { bg = colors.bg, fg = colors.fg },
		--	},
		--	command = {
		--		a = { bg = colors.yellow, fg = colors.bg, gui = "bold" },
		--		b = { bg = colors.bg, fg = colors.fg },
		--		c = { bg = colors.bg, fg = colors.fg },
		--	},
		--	replace = {
		--		a = { bg = colors.red, fg = colors.bg, gui = "bold" },
		--		b = { bg = colors.bg, fg = colors.fg },
		--		c = { bg = colors.bg, fg = colors.fg },
		--	},
		--	inactive = {
		--		a = { bg = colors.inactive_bg, fg = colors.semilightgray, gui = "bold" },
		--		b = { bg = colors.inactive_bg, fg = colors.semilightgray },
		--		c = { bg = colors.inactive_bg, fg = colors.semilightgray },
		--	},
		--}

		local colors = {
			blue = "#80a0ff",
			cyan = "#79dac8",
			black = "#080808",
			white = "#c6c6c6",
			red = "#ff5189",
			violet = "#d183e8",
			grey = "#303030",
		}

		local bubbles_theme = {
			normal = {
				a = { fg = colors.black, bg = colors.violet },
				b = { fg = colors.white, bg = colors.grey },
				c = { fg = colors.white },
			},

			insert = { a = { fg = colors.black, bg = colors.blue } },
			visual = { a = { fg = colors.black, bg = colors.cyan } },
			replace = { a = { fg = colors.black, bg = colors.red } },

			inactive = {
				a = { fg = colors.white, bg = colors.black },
				b = { fg = colors.white, bg = colors.black },
				c = { fg = colors.white },
			},
		}

		-- configure lualine with modified theme
		local function wordcount()
			return tostring(vim.fn.wordcount().words) .. " words"
		end

		-- local function charcount()
		-- 	return tostring(vim.fn.strdisplaywidth(vim.api.nvim_get_current_line())) .. " chars"
		-- end

		local function charcount()
			local chars = 0
			for i = 1, vim.fn.line("$") do
				chars = chars + vim.fn.strdisplaywidth(vim.fn.getline(i))
			end
			return tostring(chars) .. " chars"
		end

		local function is_markdown()
			return vim.bo.filetype == "markdown" or vim.bo.filetype == "asciidoc"
		end

		lualine.setup({
			-- options = {
			-- 	theme = my_lualine_theme,
			-- },
			options = {
				theme = bubbles_theme,
				component_separators = { left = ")", right = "(" },
				section_separators = { left = "", right = "" },
			},
			sections = {
				lualine_x = {
					-- {
					-- 	lazy_status.updates,
					-- 	cond = lazy_status.has_updates,
					-- 	color = { fg = "#ff9e64" },
					-- },
					function()
						local ok, pomo = pcall(require, "pomo")
						if not ok then
							return ""
						end

						local timer = pomo.get_first_to_finish()
						if timer == nil then
							return ""
						end

						return "󰄉 " .. tostring(timer)
					end,

					{ wordcount, cond = is_markdown },
					{ charcount, cond = is_markdown },
					{ "encoding" },
					{ "fileformat" },
					{ "filetype" },
				},
			},
		})
	end,
}
