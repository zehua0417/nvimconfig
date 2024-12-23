-- TODO: add google api to get the calender events and tasks
return {
	"itchyny/calendar.vim",
	cmd = "Calendar",
	keys = {
		{ "<leader>cc", mode = { "n" }, desc = "Open calender" },
		{ "<leader>cv", mode = { "n" }, desc = "Open calender in vertical split" },
		{ "<leader>ch", mode = { "n" }, desc = "Open calender in horizontal split" },
	},
	config = function()
		local keymap = vim.keymap -- for conciseness
		keymap.set("n", "<leader>co", "<cmd>Calendar<cr>", { desc = "Open calender" })
		keymap.set(
			"n",
			"<leader>cv",
			"<cmd>Calendar -view=year -split=vertical -width=54<CR>",
			{ desc = "Open calender in vertical split" }
		)
		keymap.set(
			"n",
			"<leader>ch",
			"<cmd>Calendar -view=year -split=horizontal -position=below -height=20<CR>",
			{ desc = "Open calender in horizontal split" }
		)
		keymap.set("n", "<leader>cc", "<cmd>Calendar -view=clock<CR>", { desc = "Open clocl" })
	end,
}