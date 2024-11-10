return {
	"ptzz/lf.vim",
	dependencies = { "voldikss/vim-floaterm" },
	config = function()
		vim.cmd("let g:lf_map_keys = 0")
		vim.cmd("let g:floaterm_opener = 'vsplit'")
		vim.keymap.set("n", "<leader>te", "<cmd>Lf<cr>", { desc = "Open lf" })
	end,
}
