-- list of available script languages
local scriptLanguages = {
	python = "python",
	r = "R",
	sh = "bash",
	julia = "julia",
	lua = "lua",
}

-- list of compiled languages
local compiledLanguages = {
	-- c = '"gcc src/main.c -Iinclude -o bin/out.exe"',
	c = '"cd build && cmake .. && cd .."',
	cpp = '"cd build && cmake .. && cd .."',
	-- java = "javac",
	-- rust = "rustc",
	tex = "mklex",
}

-- check if the file type is available language
-- input isScriptLan
-- if true return the filetype, or return nil
local function check_filetype(isScriptLan)
	local filetype = vim.bo.filetype
	local lang_list
	if isScriptLan then
		lang_list = scriptLanguages
	else
		lang_list = compiledLanguages
	end
	for lang, lang_str in pairs(lang_list) do
		if filetype == lang then
			return lang, lang_str
		end
	end
end

-- test if toggleTerm is loaded, if not load it
local function check_togglerterm_loaded()
	if not pcall(require, "toggleterm") then
		vim.cmd("Lazy load toggleterm.nvim")
	end
end

-- use toggleterm add a term named runner
local function runner_term(cmd, position)
	check_togglerterm_loaded()
	if position == nil then
		position = "vertical"
	end
	local size = 0
	if position == "horizontal" then
		size = 8
	else
		size = 60
	end
	local opencmd = "ToggleTerm name=runner direction=" .. position .. " size=" .. size
	vim.cmd(opencmd)
	vim.cmd("TermExec cmd=" .. cmd .. " name=runner dir=.")
end

local function open_scriptlan_runner()
	local lang, cmd = check_filetype(true)
	if not lang then
		print("No available script language found")
		return
	end
	runner_term(cmd, "horizontal")
end

local function language_compiler()
	local lang, cmd = check_filetype(false)
	if not lang then
		print("No available script language found")
		return
	end
	runner_term(cmd, "horizontal")
end

local function comilerlan_runner(lang)
	if lang == "c" then
		-- vim.cmd('TermExec cmd="./bin/main.exe"')
		vim.cmd('TermExec cmd="cd build && make"')
		vim.cmd('TermExec cmd="cd .. && ./bin/main.bin"')
	elseif lang == "cpp" then
		vim.cmd('TermExec cmd="cd build && make"')
		vim.cmd('TermExec cmd="cd .. && ./bin/main.bin"')
	elseif lang == "tex" then
		-- local filename = vim.fn.expand("%:r")
		local filename = vim.fn.expand("%:t:r")
		vim.cmd("!evince output/" .. filename .. ".pdf &")
	end
end

local function run()
	local scriptlan = true
	local lang, _ = check_filetype(scriptlan)
	if not lang then
		scriptlan = false
		lang, _ = check_filetype(scriptlan)
		if not lang then
			print("No available language found")
			return
		end
	end
	if scriptlan then
		-- BUG: no indent, which cause error when running python code
		vim.cmd("ToggleTermSendCurrentLine")
		vim.cmd("normal j")
	else
		comilerlan_runner(lang)
	end
end

local key = vim.api.nvim_set_keymap
local command = vim.api.nvim_create_user_command

command("ScriptlanRunner", open_scriptlan_runner, {})
command("CompilelanRunner", language_compiler, {})
command("RunRunner", run, {})
key("n", "<F17>", "<CMD>ScriptlanRunner<CR>", { noremap = true, silent = true })
key("n", "<S-F5>", "<CMD>ScriptlanRunner<CR>", { noremap = true, silent = true })
key("n", "<F29>", "<CMD>CompilelanRunner<CR>", { noremap = true, silent = true })
key("n", "<C-F5>", "<CMD>CompilelanRunner<CR>", { noremap = true, silent = true })
key("n", "<F5>", "<CMD>RunRunner<CR>", { noremap = true, silent = true })
key("v", "<F5>", "<CMD>ToggleTermSendVisualLines<CR>", { noremap = true, silent = true })
