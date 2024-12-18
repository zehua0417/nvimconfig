-- set leader key to space
vim.g.mapleader = " "
vim.cmd("set tags=")
vim.cmd("language en_US.UTF-8")

vim.g.gitblame_enabled = 0
vim.g.gitblame_message_template = "<summary> • <date> • <author>"
-- if require("snacks").git.get_root() ~= nil then
-- 	vim.g.gitblame_enabled = 0
-- end

-- vim.cmd("let g:lf_map_keys = 0")
-- vim.cmd("let g:floaterm_opener = 'vsplit'")

-- vim.g.calendar_google_calendar = 1
-- vim.g.calendar_google_task = 1
-- vim.g.calendar_gcalcli_path = "/path/to/gcalcli"
-- vim.g.calendar_auto_sync = 1
-- vim.cmd('let g:calendar_gcal_oauth2_token_file = expand("~/.gcalcli/oauth")')
-- vim.g.calendar_google_api_key = "794727321285-jne037i3omd90f2q39vlkgl1v9aur3q3.apps.googleusercontent.com"
-- vim.g.calendar_google_client_id = "794727321285-jne037i3omd90f2q39vlkgl1v9aur3q3.apps.googleusercontent.com"
-- -- vim.g.calendar_google_client_secret = "..."
