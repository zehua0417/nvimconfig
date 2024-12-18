local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{ import = "lihuax.plugins" },
	{ import = "lihuax.plugins.common" },
	{ import = "lihuax.plugins.completion" },

	-- BUG: noice conflict with tools.codesnap(silicon)
	{ import = "lihuax.plugins.render" },
	-- { import = "lihuax.plugins.render.bufferline" },
	-- { import = "lihuax.plugins.render.colorscheme" },
	-- { import = "lihuax.plugins.render.dressing" },
	-- { import = "lihuax.plugins.render.incline" },
	-- { import = "lihuax.plugins.render.lualine" },
	-- { import = "lihuax.plugins.render.startmenu" },
	-- { import = "lihuax.plugins.render.transparent" },
	-- { import = "lihuax.plugins.render.yamlmatter" },
	-- { import = "lihuax.plugins.render.noice" },

	{ import = "lihuax.plugins.language" },
	{ import = "lihuax.plugins.language.markdown" },
	{ import = "lihuax.plugins.tools" },
}, {
	checker = {
		enabled = true,
		notify = false,
	},
	change_detection = {
		notify = false,
	},
})
