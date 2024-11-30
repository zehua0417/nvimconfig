return {
	"smoka7/hop.nvim",
	version = "*",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		keys = "etovxqpdygfblzhckisuran",
	},
	config = function()
		local hop = require("hop")
		hop.setup()
		local directions = require("hop.hint").HintDirection
		vim.keymap.set("", "f", function()
			hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
		end, { remap = true })
		vim.keymap.set("", "F", function()
			hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
		end, { remap = true })
		vim.keymap.set("", "t", function()
			hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
		end, { remap = true })
		vim.keymap.set("", "T", function()
			hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
		end, { remap = true })

		vim.keymap.set("", "<leader>hw", function()
			hop.hint_words()
		end, { remap = true, desc = "Hop to word" })
		vim.keymap.set("", "<leader>hl", function()
			hop.hint_lines()
		end, { remap = true, desc = "Hop to line" })
	end,
}
