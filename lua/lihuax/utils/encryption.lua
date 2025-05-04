local function encrypt_file()
	local file_path = vim.fn.expand("%:p") -- 获取当前文件完整路径
	if file_path == "" then
		vim.notify("No file to encrypt!", vim.log.levels.WARN)
		return
	end

	local gpg_command =
		string.format('gpg --yes --encrypt --recipient "zehuali0417@gmail" --output %s.gpg %s', file_path, file_path)
	local delete_command = string.format("rm -f %s", file_path)

	vim.cmd("write") -- 保存当前文件
	vim.fn.system(gpg_command) -- 执行 GPG 加密
	if vim.v.shell_error == 0 then
		vim.fn.system(delete_command) -- 加密成功后删除原文件
		vim.cmd("e " .. file_path .. ".gpg") -- 加载加密文件
		vim.notify("File encrypted successfully!", vim.log.levels.INFO)
	else
		vim.notify("Encryption failed!", vim.log.levels.ERROR)
	end
end

local function decrypt_file()
	local file_path = vim.fn.expand("%:p") -- 获取当前文件完整路径
	if not file_path:match("%.gpg$") then
		vim.notify("Not a GPG encrypted file!", vim.log.levels.WARN)
		return
	end

	local output_file = file_path:gsub("%.gpg$", "") -- 解密后的文件名
	local gpg_command = string.format("gpg --yes --output %s --decrypt %s", output_file, file_path)

	vim.fn.system(gpg_command) -- 执行 GPG 解密
	if vim.v.shell_error == 0 or vim.v.shell_error == 2 then
		vim.cmd("e " .. output_file) -- 打开解密后的文件
		vim.notify("File decrypted successfully!", vim.log.levels.INFO)
	else
		vim.notify("Decryption failed!", vim.log.levels.ERROR)
	end
end

local key = vim.api.nvim_set_keymap
local command = vim.api.nvim_create_user_command
-- 将函数注册到全局命令，便于调用
command("EncryptFile", encrypt_file, {})
command("DecryptFile", decrypt_file, {})
key("n", "<leader>ge", ":EncryptFile<CR>", { noremap = true, silent = true })
key("n", "<leader>gd", ":DecryptFile<CR>", { noremap = true, silent = true })
