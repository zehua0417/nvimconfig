# My NEOVIM Dot files

## manul

writing ...

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
