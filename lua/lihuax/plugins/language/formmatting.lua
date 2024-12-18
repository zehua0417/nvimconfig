return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")
		conform.format({ async = true, lsp_fallback = true })

		conform.setup({
			formatters_by_ft = {
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				svelte = { "prettier" },
				css = { "prettier" },
				html = { "prettier" },
				json = { "prettier" },
				yaml = { "prettier" },
				markdown = { "prettier" },
				graphql = { "prettier" },
				liquid = { "prettier" },
				lua = { "stylua" },
				java = { "google-java-format" },
				-- python = { "isort", "black" },
				python = { "black" },
			},
			format_on_save = {
				timeout_ms = 2500,
				lsp_fallback = true,
			},
			-- format_on_save = function(bufnr)
			-- 	-- Disable with a global or buffer-local variable
			-- 	if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
			-- 		return
			-- 	end
			-- 	return { timeout_ms = 500, lsp_format = "fallback" }
			-- end,
		})

		vim.keymap.set({ "n", "v" }, "<leader>af", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			})
		end, { desc = "Format file or range (in visual mode)" })

		vim.api.nvim_create_user_command("FormatDisable", function(args)
			if args.bang then
				-- FormatDisable! will disable formatting just for this buffer
				vim.b.disable_autoformat = true
			else
				vim.g.disable_autoformat = true
			end
		end, {
			desc = "Disable autoformat-on-save",
			bang = true,
		})

		vim.api.nvim_create_user_command("FormatEnable", function()
			vim.b.disable_autoformat = false
			vim.g.disable_autoformat = false
		end, {
			desc = "Re-enable autoformat-on-save",
		})
	end,
}
