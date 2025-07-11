return {
	"ray-x/yamlmatter.nvim",
	ft = { "yaml", "markdown" },
	config = function()
		require("yamlmatter").setup({
			icon_mappings = {
				title = "",
				author = "",
				date = "",
				update = "󰇡",
				idea = "",
				weather = "",
				default = "󰦨",
				ANKI_DECK = "",
				categories = "󰍜",
				location = "",
				rating = "",
				weekday = "󰨴",
			},
			highlight_groups = {
				icon = "MyIconHighlight",
				key = "MyKeyHighlight",
				value = "MyValueHighlight",
			},
			key_value_padding = 4, -- Less space
			conceallevel = 1, -- on what level start conceal the yaml text
		})
	end,
}
