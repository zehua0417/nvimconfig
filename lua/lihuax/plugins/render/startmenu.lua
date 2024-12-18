return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	config = function()
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
			bigfile = { enabled = false },
			-- notifier = {
			-- 	timeout = 3000, -- default timeout in ms
			-- 	width = { min = 40, max = 0.4 },
			-- 	height = { min = 1, max = 0.6 },
			-- 	-- editor margin to keep free. tabline and statusline are taken into account automatically
			-- 	margin = { top = 0, right = 1, bottom = 0 },
			-- 	padding = true, -- add 1 cell of left/right padding to the notification window
			-- 	sort = { "level", "added" }, -- sort by level and time
			-- 	-- minimum log level to display. TRACE is the lowest
			-- 	-- all notifications are stored in history
			-- 	level = vim.log.levels.TRACE,
			-- 	icons = {
			-- 		error = "  Error",
			-- 		warn = "  Warin",
			-- 		info = "  Info",
			-- 		debug = "  Dedug",
			-- 		trace = "  Trace",
			-- 	},
			-- 	keep = function(notif)
			-- 		return vim.fn.getcmdpos() > 0
			-- 	end,
			-- 	---@type snacks.notifier.style
			-- 	style = "compact",
			-- 	top_down = true, -- place notifications from top to bottom
			-- 	date_format = "%R", -- time format for notifications
			-- 	-- format for footer when more lines are available
			-- 	-- `%d` is replaced with the number of lines.
			-- 	-- only works for styles with a border
			-- 	---@type string|boolean
			-- 	more_format = " ↓ %d lines ",
			-- 	refresh = 50, -- refresh at most every 50ms
			-- },
			quickfile = { enabled = false },
			statuscolumn = { enabled = false },
			words = { enabled = false },
			-- terminal = {
			-- 	bo = {
			-- 		filetype = "snacks_terminal",
			-- 	},
			-- 	wo = {},
			-- 	keys = {
			-- 		q = "hide",
			-- 		gf = function(self)
			-- 			local f = vim.fn.findfile(vim.fn.expand("<cfile>"), "**")
			-- 			if f == "" then
			-- 				Snacks.notify.warn("No file under cursor")
			-- 			else
			-- 				self:hide()
			-- 				vim.schedule(function()
			-- 					vim.cmd("e " .. f)
			-- 				end)
			-- 			end
			-- 		end,
			-- 		term_normal = {
			-- 			"<esc>",
			-- 			function(self)
			-- 				self.esc_timer = self.esc_timer or (vim.uv or vim.loop).new_timer()
			-- 				if self.esc_timer:is_active() then
			-- 					self.esc_timer:stop()
			-- 					vim.cmd("stopinsert")
			-- 				else
			-- 					self.esc_timer:start(200, 0, function() end)
			-- 					return "<esc>"
			-- 				end
			-- 			end,
			-- 			mode = "t",
			-- 			expr = true,
			-- 			desc = "Double escape to normal mode",
			-- 		},
			-- 	},
			-- },

			lazygit = {
				-- automatically configure lazygit to use the current colorscheme
				-- and integrate edit with the current neovim instance
				configure = true,
				-- extra configuration for lazygit that will be merged with the default
				-- snacks does NOT have a full yaml parser, so if you need `"test"` to appear with the quotes
				-- you need to double quote it: `"\"test\""`
				config = {
					os = { editPreset = "nvim-remote" },
					gui = {
						-- set to an empty string "" to disable icons
						nerdFontsVersion = "3",
					},
				},
				theme_path = vim.fs.normalize(vim.fn.stdpath("cache") .. "/lazygit-theme.yml"),
				-- Theme for lazygit
				theme = {
					[241] = { fg = "Special" },
					activeBorderColor = { fg = "MatchParen", bold = true },
					cherryPickedCommitBgColor = { fg = "Identifier" },
					cherryPickedCommitFgColor = { fg = "Function" },
					defaultFgColor = { fg = "Normal" },
					inactiveBorderColor = { fg = "FloatBorder" },
					optionsTextColor = { fg = "Function" },
					searchingActiveBorderColor = { fg = "MatchParen", bold = true },
					selectedLineBgColor = { bg = "Visual" }, -- set to `default` to have no background colour
					unstagedChangesColor = { fg = "DiagnosticError" },
				},
				win = {
					style = "lazygit",
				},
			},
			dashboard = {
				width = 60,
				row = nil, -- dashboard position. nil for center
				col = nil, -- dashboard position. nil for center
				pane_gap = 4, -- empty columns between vertical panes
				autokeys = "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ", -- autokey sequence
				-- These settings are used by some built-in sections
				preset = {
					-- Defaults to a picker that supports `fzf-lua`, `telescope.nvim` and `mini.pick`
					---@type fun(cmd:string, opts:table)|nil
					pick = nil,
					-- Used by the `keys` section to show keymaps.
					-- Set your curstom keymaps here.
					-- When using a function, the `items` argument are the default keymaps.
					---@type snacks.dashboard.Item[]
					keys = {
						{ icon = " ", key = "e", desc = "New File", action = ":ene | startinsert" },
						{ icon = "󰹕 ", key = "n", desc = "Notes", action = ":NvimTreeOpen ~/Notes" },
						{ icon = "󱗖 ", key = "d", desc = "Diary", action = "<leader>ad" },
						{
							icon = "󰸖 ",
							key = "b",
							desc = "Open bookmarks",
							action = ":Telescope bookmarks list",
						},
						{
							-- icon = " ",
							icon = "󱑅 ",
							key = "r",
							desc = "Recent Files",
							action = ":lua Snacks.dashboard.pick('oldfiles')",
						},
						{
							icon = "󰱼 ",
							key = "f",
							desc = "Find File",
							action = ":lua Snacks.dashboard.pick('files')",
						},
						{
							icon = " ",
							key = "t",
							desc = "Find Text",
							action = ":lua Snacks.dashboard.pick('live_grep')",
						},
						{
							icon = " ",
							key = "c",
							desc = "Config",
							action = ":NvimTreeOpen ~/.config/nvim",
						},
						--{ icon = " ", key = "s", desc = "Restore Session", section = "session" },
						{
							icon = "󰒲 ",
							key = "L",
							desc = "Lazy",
							action = ":Lazy",
							enabled = package.loaded.lazy ~= nil,
						},
						{
							-- pane = 2,
							icon = " ",
							desc = "Browse Repo",
							enabled = function()
								return Snacks.git.get_root() ~= nil
							end,
							-- padding = 1,
							key = "g",
							action = function()
								Snacks.gitbrowse()
							end,
						},
						{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
					},
					-- Used by the `header` section
					header = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
					-- 				headerr = [[
					-- ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
					-- ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠋⣠⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
					-- ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣡⣾⣿⣿⣿⣿⣿⢿⣿⣿⣿⣿⣿⣿⣟⠻⣿⣿⣿⣿⣿⣿⣿⣿
					-- ⣿⣿⣿⣿⣿⣿⣿⣿⡿⢫⣷⣿⣿⣿⣿⣿⣿⣿⣾⣯⣿⡿⢧⡚⢷⣌⣽⣿⣿⣿⣿⣿⣶⡌⣿⣿⣿⣿⣿⣿
					-- ⣿⣿⣿⣿⣿⣿⣿⣿⠇⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣮⣇⣘⠿⢹⣿⣿⣿⣿⣿⣻⢿⣿⣿⣿⣿⣿
					-- ⣿⣿⣿⣿⣿⣿⣿⣿⠀⢸⣿⣿⡇⣿⣿⣿⣿⣿⣿⣿⣿⡟⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⣻⣿⣿⣿⣿
					-- ⣿⣿⣿⣿⣿⣿⣿⡇⠀⣬⠏⣿⡇⢻⣿⣿⣿⣿⣿⣿⣿⣷⣼⣿⣿⣸⣿⣿⣿⣿⣿⣿⣿⣿⣿⢻⣿⣿⣿⣿
					-- ⣿⣿⣿⣿⣿⣿⣿⠀⠈⠁⠀⣿⡇⠘⡟⣿⣿⣿⣿⣿⣿⣿⣿⡏⠿⣿⣟⣿⣿⣿⣿⣿⣿⣿⣿⣇⣿⣿⣿⣿
					-- ⣿⣿⣿⣿⣿⣿⡏⠀⠀⠐⠀⢻⣇⠀⠀⠹⣿⣿⣿⣿⣿⣿⣩⡶⠼⠟⠻⠞⣿⡈⠻⣟⢻⣿⣿⣿⣿⣿⣿⣿
					-- ⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⢿⠀⡆⠀⠘⢿⢻⡿⣿⣧⣷⢣⣶⡃⢀⣾⡆⡋⣧⠙⢿⣿⣿⣟⣿⣿⣿⣿
					-- ⣿⣿⣿⣿⣿⣿⡿⠀⠀⠀⠀⠀⠀⠀⡥⠂⡐⠀⠁⠑⣾⣿⣿⣾⣿⣿⣿⡿⣷⣷⣿⣧⣾⣿⣿⣿⣿⣿⣿⣿
					-- ⣿⣿⡿⣿⣍⡴⠆⠀⠀⠀⠀⠀⠀⠀⠀⣼⣄⣀⣷⡄⣙⢿⣿⣿⣿⣿⣯⣶⣿⣿⢟⣾⣿⣿⢡⣿⣿⣿⣿⣿
					-- ⣿⡏⣾⣿⣿⣿⣷⣦⠀⠀⠀⢀⡀⠀⠀⠠⣭⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠟⣡⣾⣿⣿⢏⣾⣿⣿⣿⣿⣿
					-- ⣿⣿⣿⣿⣿⣿⣿⣿⡴⠀⠀⠀⠀⠀⠠⠀⠰⣿⣿⣿⣷⣿⠿⠿⣿⣿⣭⡶⣫⠔⢻⢿⢇⣾⣿⣿⣿⣿⣿⣿
					-- ⣿⣿⣿⡿⢫⣽⠟⣋⠀⠀⠀⠀⣶⣦⠀⠀⠀⠈⠻⣿⣿⣿⣾⣿⣿⣿⣿⡿⣣⣿⣿⢸⣾⣿⣿⣿⣿⣿⣿⣿
					-- ⡿⠛⣹⣶⣶⣶⣾⣿⣷⣦⣤⣤⣀⣀⠀⠀⠀⠀⠀⠀⠉⠛⠻⢿⣿⡿⠫⠾⠿⠋⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
					-- ⢀⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣀⡆⣠⢀⣴⣏⡀⠀⠀⠀⠉⠀⠀⢀⣠⣰⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
					-- ⠿⠛⠛⠛⠛⠛⠛⠻⢿⣿⣿⣿⣿⣯⣟⠷⢷⣿⡿⠋⠀⠀⠀⠀⣵⡀⢠⡿⠋⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
				},

				-- item field formatters
				formats = {
					--icon = function(item)
					--	if item.file and item.icon == "file" or item.icon == "directory" then
					--		return M.icon(item.file, item.icon)
					--	end
					--	return { item.icon, width = 2, hl = "icon" }
					--end,
					header = { "%s", align = "center" },
					file = function(item, ctx)
						local fname = vim.fn.fnamemodify(item.file, ":~")
						fname = ctx.width and #fname > ctx.width and vim.fn.pathshorten(fname) or fname
						local dir, file = fname:match("^(.*)/(.+)$")
						return dir and { { dir .. "/", hl = "dir" }, { file, hl = "file" } }
							or { { fname, hl = "file" } }
					end,
				},
				sections = {
					{ section = "header", padding = 6 },
					-- { section = "footer" },
					-- { section = "rei" },
					{ section = "keys", gap = 1, padding = 1 },
					-- {
					-- 	pane = 2,
					-- 	section = "terminal",
					-- 	cmd = "chafa ~/.config/wall.png --format symbols --symbols vhalf --size 60x17 --stretch | tr -d '\r'; sleep .1",
					-- 	height = 17,
					-- 	padding = 3,
					-- },
					--[[ {
					section = "terminal",
					cmd = "",
					random = 10,
					pane = 2,
					indent = 20,
					height = 10,
					padding = 3,
				}, ]]

					{
						pane = 2,
						section = "terminal",
						-- cmd = "cat F:/Backups/pokemon/small/regular/pikachu-starter",
						cmd = "cat C:/Users/lihuax/.config/rei; sleep .1",
						-- cmd = "if (Get-Random -Minimum 0 -Maximum 2) { cat F:/Backups/pokemon/small/regular/pikachu-starter } else { cat C:/Users/lihuax/.config/rei }; sleep .1",
						height = 12,
						padding = 1,
						indent = 15,
					},
					{
						pane = 2,
						icon = " ",
						title = "Git Status",
						section = "terminal",
						enabled = function()
							return Snacks.git.get_root() ~= nil
						end,
						-- cmd = "git status --short --branch --renames",
						cmd = "git --no-pager diff --stat -B -M -C",
						height = 7,
						padding = 1,
						ttl = 5 * 60,
						indent = 3,
					},
					{
						pane = 2,
						icon = " ",
						title = "Calendar",
						section = "terminal",
						enabled = function()
							return Snacks.git.get_root() == nil
						end,
						cmd = "cal",
						height = 7,
						padding = 1,
						ttl = 5 * 60,
						indent = 16,
					},
					{
						pane = 2,
						icon = " ",
						title = "Recent Files",
						section = "recent_files",
						indent = 2,
						padding = 1,
					},
					{
						pane = 2,
						indent = 2,
						icon = " ",
						title = "Projects",
						section = "projects",
						padding = 1,
					},
					{ section = "startup" },
				},
			},
		}
		require("snacks").setup(opts)
		if Snacks.git.get_root() ~= nil then
			vim.g.gitblame_enabled = 1
		end
	end,
}
