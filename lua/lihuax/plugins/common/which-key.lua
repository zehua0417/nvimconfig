return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 500
	end,
	opts = {},
	--[[ config = function()
		local wk = require("which-key")
		wk.add({
			{ "<leader>c", group = "[C]ode", icon = "" },
			{ "<leader>c_", hidden = true },
			{ "<leader>d", group = "[D]ocument", wk.Icon({ icon = "", color = "blue" }) },
			{ "<leader>d_", hidden = true },
		})
	end, ]]
}
