# My NEOVIM Dot files

## manul

### global

`<leader>` = SPC
`[n] <C-h>` = move to left window
`[n] <C-j>` = move to down window
`[n] <C-k>` = move to up window
`[n] <C-l>` = move to right window

`[n] <C-w>h` = change window position to left
`[n] <C-w>j` = change window position to down
`[n] <C-w>k` = change window position to up
`[n] <C-w>l` = change window position to right
`[n] <C-w>r` = change window position

`[n] <leader>sv` = split window vertially
`[n] <leader>sh` = split window horizontally
`[n] <leader>se` = make split equal
`[n] <leader>se` = make split max
`[n] <leader>sx` = close current split

`[n] <leader>to` = tab new
`[n] <leader>tx` = tab close
`[n] <leader>tn` = next tab
`[n] <leader>tp` = previous tab
`[n] <leader>tf` = previous tab

`[n] <C-Up>` = resize -2
`[n] <C-Down>` = resize +2
`[n] <C-Left>` = vertical resize -2
`[n] <C-Right>` = vertical resize +2

`[n] <C-s>` = move to next buffer line
`[n] <C-d>` = move to previous buffer line

`[n] <leader>nh` = clear search highlight

`[v] >` = indent right
`[v] <` = indent left

`[t] esc` = exit terminal mode

### utils

`[n] <leader>au` = make unix file type
`[n] <leader>aw` = toggle wrap
`[n/v] <leader>af` = format file
`[n/k] <leader>ak` = make anki callout card
`[v] <leader>ab` = add `**` before and after selected text
`[v] <leader>ai` = add `__` before and after selected text
`[v] <leader>an` = change circle number to arabic number
`[v] <leader>as` = change to english format

### plugins

#### telescope

`[n] <leader>ff` = find file
`[n] <leader>fg` = find string
`[n] <leader>fb` = find buffer
`[n] <leader>fc` = find string under cursor
`[n] <leader>fs` = find symbol
`[n] <leader>fr` = find recent file
`[n] <leader>ft` = find todo
`[n] <leader>fm` = find bookmarks

#### fold

`[n] za` = toggle fold under cursor
`[n] zA` = toggle all fole under cursor
`[n] zc` = close fold under cursor
`[n] zC` = close all folds under cursor
`[n] zd` = delete fold under cursor
`[n] zD` = delete all folds under cursor
`[n] zf` = create fold
`[n] zi` = toggle folding
`[n] zm` = fold more
`[n] zM` = close all folds
`[n] zo` = open fold under cursor
`[n] zO` = open all fold under cursor
`[n] zr` = fold less
`[n] zR` = open all folds
`[n] zX` = delete fold

#### toggle terminal

`[n] <leader>tf` = open float terminal
`[n] <leader>th` = open horizontal terminal
`[n] <leader>tv` = open vertical terminal
`[n] <leader>te` = open float terminal with lf

#### nvim tree

`[n] <leader>ee` = toggle nvim tree
`[n] <leader>ef` = toggle nvim tree with current file
`[n] <leader>ed` = toggle nvim tree in current dir
`[n] <leader>er` = refresh nvim tree
`[n] <leader>ec` = collapase nvim tree

#### book marks

`[n] <leader>bb` = toggle bookmark
`[n] <leader>bi` = edit bookmark annotation
`[n] <leader>bc` = clean all bookmarks in buffer
`[n] <leader>bn` = next bookmarks in buffer
`[n] <leader>bp` = previous bookmarks in buffer
`[n] <leader>bl` = bookmarks list
`[n] <leader>bx` = clear all bookmarks

#### format

`[n] <leader>af` = format file
`FormatDisable` = disable auto format after save
`FormatEnable` = enable auto format after save(default)

#### flash

<!---TODO: flash-->

#### nvim-cmp

`[i] <tab>` = select next
`[i] <S-tab>` = select previous
`[i] <cr>` = confirm selection

#### comment

`[n] gcc` = toggle line comment
`[v] gc` = toggle line comment
`[v] gb` = toggle block comment

#### timer

`[n] <leader>tms` = timer session pomodoro
`[n] <leader>tmp` = timer pause
`[n] <leader>tmr` = timer resume
`[n] <leader>tmb` = timer break(stop)
`[n] <leader>tmh` = timer hide
`[n] <leader>tmd` = timer display

#### other

`[n] <leader>mo` = toggle outline
`[n] <leader>mp` = paste image from clipboard
`[n] <leader>/` = toggle markdown render

### neovide

`[v] <C-Insert>` = copy
`[c/i] <S-Insert>` = paste

`[n] <C-=>` = add scale
`[n] <C-->` = reduce scale

`[n] <F11>` = neovide full screen

## plugins have been changed:

### pomo.lua: add windows support

```lua
--"nvim-data\lazy\pomo.nvim\lua\pomo\notifiers\system.lua"
SystemNotifier.supported_oss = { util.OS.Darwin, util.OS.Linux, util.OS.Windows }

-- ....

elseif util.get_os() == util.OS.Windows then
    os.execute(string.format(
      [[
        PowerShell -Command "Add-Type -AssemblyName System.Windows.Forms; $notify = New-Object System.Windows.Forms.NotifyIcon; $notify.Icon = [System.Drawing.SystemIcons]::Information; $notify.BalloonTipIcon = [System.Windows.Forms.ToolTipIcon]::Info; $notify.BalloonTipText = 'Timer #%d, %s%s'; $notify.BalloonTipTitle = 'Timer done!'; $notify.Visible = $true; $notify.ShowBalloonTip(10000);"
      ]],
      self.timer.id,
      util.format_time(self.timer.time_limit),
      repetitions_str
    ))
```

### clipboard-image: change clipboard-image health require

```git
diff --git a/lua/clipboard-image/health.lua b/lua/clipboard-image/health.lua
index 51fb558..167c235 100644
--- a/lua/clipboard-image/health.lua
+++ b/lua/clipboard-image/health.lua
@@ -1,6 +1,7 @@
 local M = {}
 local utils = require "clipboard-image.utils"
-local health = require "health"
+--local health = require "health"
+local health = vim.health or require "health"

 local packages = {
   x11 = { name = "xclip", binary = "xclip" },
```

### bookmarks: change default icon

```lua
-- /lua/bookmarks/config.lua
default = {
	add = { hl = "BookMarksAdd", text = "󰃀", numhl = "BookMarksAddNr", linehl = "BookMarksAddLn" },
	ann = { hl = "BookMarksAnn", text = "󱖮", numhl = "BookMarksAnnNr", linehl = "BookMarksAnnLn" },
},
```
