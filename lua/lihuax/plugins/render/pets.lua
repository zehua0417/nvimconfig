return {
	"giusgad/pets.nvim",
	cmd = { "PetsNew", "PetsNewCustom" },
	dependencies = { "MunifTanjim/nui.nvim", "giusgad/hologram.nvim" },
	keys = {
		{
			"<leader>pn",
			"<cmd>PetsNew pet<cr>",
			desc = "Spawn a new pet",
		},
	},
	config = function()
		require("pets").setup({
			row = 6,
			col = 20,
			speed_multiplier = 1,
			default_pet = "dog",
			default_style = "brown",
			random = false,
			death_animation = true,
			popup = {
				width = "30%",
				winblend = 100,
				hl = { Normal = "Normal" },
				avoid_statusline = false,
			},
		})
	end,
}
