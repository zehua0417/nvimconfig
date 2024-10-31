return {
	"akinsho/bufferline.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	version = "*",
	opts = {
		options = {
			mode = "tabs",
			--separator_style = "padded_slope",
		},
	},

	config = function()
		require("bufferline").setup({
			options = {
				indicator = {
					--icon = "▎", -- 这是指示器旁边的图标，您可以根据喜好更改或删除
					style = "underline", -- 设置指示器样式为 'underline'
				},
				-- 其他配置...
			},
		})
	end,
}
