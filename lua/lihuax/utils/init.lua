require("lihuax.utils.changewd")
require("lihuax.utils.artical")
require("lihuax.utils.makeanki")
require("lihuax.utils.runner")

local diary = require("lihuax.utils.diary")
vim.api.nvim_create_user_command("DiaryToday", diary.touch_today_diary, {})
vim.api.nvim_set_keymap("n", "<leader>ad", ":DiaryToday<CR>", { noremap = true, silent = true })
