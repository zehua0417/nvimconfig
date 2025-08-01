vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

opt.relativenumber = false
opt.number = true

-- tabs & indentation
opt.tabstop = 2 -- 2 spaces for tabs (prettier default)
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one

opt.wrap = false

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

opt.cursorline = true

-- turn on termguicolors for tokyonight colorscheme to work
-- (have to use iterm2 or any other true color terminal)
opt.termguicolors = true
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes" -- show sign column so that text doesn't shift

vim.cmd([[let &shell = "zsh"]])
-- vim.cmd([[let &shellcmdflag = '-s']])

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- turn off swapfile
opt.swapfile = false

-- vim.api.nvim_set_hl(0, "Cursor", { foreground = "", background = "#FF0000" })

-- set up markdown end of line spaces highlighting
-- vim.opt.list = true
-- vim.opt.listchars = { space = "⋅", trail = "·" }

-- vim.cmd("highlight MarkdownEOLSpaces guibg=#3c3836 guifg=#fabd2f")

-- vim.fn.matchadd("MarkdownEOLSpaces", "\\s\\s$")
