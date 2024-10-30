return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-buffer", -- source for text in buffer
		"hrsh7th/cmp-path", -- source for file system paths
		{
			"L3MON4D3/LuaSnip",
			-- follow latest release.
			version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
			-- install jsregexp (optional!).
			build = "make install_jsregexp",
		},
		"saadparwaiz1/cmp_luasnip", -- for autocompletion
		"rafamadriz/friendly-snippets", -- useful snippets
		"onsails/lspkind.nvim", -- vs-code like pictograms
	},

	config = function()
		local has_words_before = function()
			unpack = unpack or table.unpack
			local line, col = unpack(vim.api.nvim_win_get_cursor(0))
			return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
		end

		local luasnip = require("luasnip")
		local cmp = require("cmp")

		local lspkind = require("lspkind")
		cmp.setup({
			snippet = {
				-- REQUIRED - you must specify a snippet engine
				expand = function(args)
					require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
				end,
			},
			mapping = cmp.mapping.preset.insert({
				-- Use <C-b/f> to scroll the docs
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				-- Use <C-k/j> to switch in items
				["<C-k>"] = cmp.mapping.select_prev_item(),
				["<C-j>"] = cmp.mapping.select_next_item(),
				-- Use <CR>(Enter) to confirm selection
				-- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				["<CR>"] = cmp.mapping.confirm({ select = true }),

				-- A super tab
				-- sourc: https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#luasnip
				["<Tab>"] = cmp.mapping(function(fallback)
					-- Hint: if the completion menu is visible select next one
					if cmp.visible() then
						cmp.select_next_item()
					elseif has_words_before() then
						cmp.complete()
					else
						fallback()
					end
				end, { "i", "s" }), -- i - insert mode; s - select mode
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
			}),

			-- Let's configure the item's appearance
			-- source: https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance
			formatting = {
				format = lspkind.cmp_format({
					maxwidth = 50,
					ellipsis_char = "...",
				}),
				-- -- Set order from left to right
				-- -- kind: single letter indicating the type of completion
				-- -- abbr: abbreviation of "word"; when not empty it is used in the menu instead of "word"
				-- -- menu: extra text for the popup menu, displayed after "word" or "abbr"
				-- fields = { "abbr", "menu" },

				-- -- customize the appearance of the completion menu
				-- format = function(entry, vim_item)
				-- 	vim_item.menu = ({
				-- 		nvim_lsp = "[Lsp]",
				-- 		luasnip = "[Luasnip]",
				-- 		buffer = "[File]",
				-- 		path = "[Path]",
				-- 	})[entry.source.name]
				-- 	return vim_item
				-- end,
			},

			-- Set source precedence
			sources = cmp.config.sources({
				{ name = "copilot" },
				{ name = "nvim_lsp" }, -- For nvim-lsp
				{ name = "luasnip" }, -- For luasnip user
				{ name = "buffer" }, -- For buffer word completion
				{ name = "path" }, -- For path completion
			}),
		})
	end,
}
