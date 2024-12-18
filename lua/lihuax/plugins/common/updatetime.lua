return {
	"StonyBoy/nvim-update-time",
	ft = { "markdown", "C", "Cpp", "julia", "R", "python" },
	config = function()
		require("nvim-update-time").setup({
			last = 8,
			format = ": %Y-%m-%d %H:%M:%S",
			pattern = "update",
		})
	end,
}
