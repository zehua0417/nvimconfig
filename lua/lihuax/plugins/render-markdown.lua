return {
	"MeanderingProgrammer/render-markdown.nvim",
	dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
	-- { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
	-- dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" }, -- if you use standalone mini plugins

	---@module 'render-markdown'
	---@type render.md.UserConfig
	init = function()
		-- Define color variables
		-- local color1_bg = "#cba6f7"
		-- local color2_bg = "#89b4fa"
		-- local color3_bg = "#a6e3a1"
		-- local color4_bg = "#eba0ac"
		-- local color5_bg = "#b4befe"
		-- local color6_bg = "#fab387"
		-- local color_fg = "#161622"

		-- Heading colors (when not hovered over), extends through the entire line
		-- vim.cmd(string.format([[highlight Headline1Bg guifg=%s guibg=%s]], color_fg, color1_bg))
		-- vim.cmd(string.format([[highlight Headline2Bg guifg=%s guibg=%s]], color_fg, color2_bg))
		-- vim.cmd(string.format([[highlight Headline3Bg guifg=%s guibg=%s]], color_fg, color3_bg))
		-- vim.cmd(string.format([[highlight Headline4Bg guifg=%s guibg=%s]], color_fg, color4_bg))
		-- vim.cmd(string.format([[highlight Headline5Bg guifg=%s guibg=%s]], color_fg, color5_bg))
		-- vim.cmd(string.format([[highlight Headline6Bg guifg=%s guibg=%s]], color_fg, color6_bg))

		-- Highlight for the heading and sign icons (symbol on the left)
		-- I have the sign disabled for now, so this makes no effect
		-- vim.cmd(string.format([[highlight Headline1Fg cterm=bold gui=bold guifg=%s]], color1_bg))
		-- vim.cmd(string.format([[highlight Headline2Fg cterm=bold gui=bold guifg=%s]], color2_bg))
		-- vim.cmd(string.format([[highlight Headline3Fg cterm=bold gui=bold guifg=%s]], color3_bg))
		-- vim.cmd(string.format([[highlight Headline4Fg cterm=bold gui=bold guifg=%s]], color4_bg))
		-- vim.cmd(string.format([[highlight Headline5Fg cterm=bold gui=bold guifg=%s]], color5_bg))
		-- vim.cmd(string.format([[highlight Headline6Fg cterm=bold gui=bold guifg=%s]], color6_bg))

		-- Set custom background for code blocks
		-- vim.api.nvim_set_hl(0, "RenderMarkdownCode", { bg = "#282c34", fg = "#abb2bf" }) -- Set your desired background and foreground color
	end,
	opts = {
		bullet = {
			-- Turn on / off list bullet rendering
			enabled = true,
		},
		heading = {
			--sign = false,
			--icons = { "󰎤 ", "󰎧 ", "󰎪 ", "󰎭 ", "󰎱 ", "󰎳 " },
			backgrounds = {},
		},
		backgrounds = {
			-- "Headline1Bg",
			-- "Headline2Bg",
			-- "Headline3Bg",
			-- "Headline4Bg",
			-- "Headline5Bg",
			-- "Headline6Bg",
		},
		foregrounds = {
			-- "Headline1Fg",
			-- "Headline2Fg",
			-- "Headline3Fg",
			-- "Headline4Fg",
			-- "Headline5Fg",
			-- "Headline6Fg",
		},
		vim.keymap.set("n", "<leader>/", "<cmd>RenderMarkdown toggle<cr>", { desc = "reder markdown toogle" }),
	},
}

-- #cba6f7
-- #89b4fa
-- #a6e3a1
-- #eba0ac
-- #b4befe
-- #fab387
-- #161622
