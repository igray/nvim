local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
  return
end

local icons = require "user.icons"

local dashboard = require "alpha.themes.dashboard"
dashboard.section.header.val = {
  [[⠀⠀⡀⡂⠄⠀⠀⠀⠀⠀⠀⡢⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
  [[⠠⡑⡐⠄⠅⡁⠀⠀⠀⠀⠐⠔⢌⠢⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⠿⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
  [[⡑⢌⠢⡡⠡⠨⠨⡀⠀⠀⠠⡩⡂⢇⠢⠀⠀⠀⠀⣤⡠⠤⠤⢤⣀⠀⢀⡠⠤⠤⠤⡀⠀⢀⡤⠤⠤⠤⢄⠐⢲⣦⠀⠀⠀⢠⣶⢠⣴⡆⠀⢰⣦⣤⠶⣶⣄⣤⡴⢶⣶⡄]],
  [[⡊⢆⠣⡊⠈⠌⡂⠢⡁⠄⠐⡌⢎⠜⡌⠀⠀⠀⠀⣿⠀⠀⠀⠀⣿⠀⡯⠥⠤⠤⠤⠼⠀⡾⠀⠀⠀⠀⠈⡇⠈⢿⣶⠀⣸⣿⠃⢸⣿⡇⠀⢸⡇⠀⠀⠀⣿⡇⠀⠀⣿⣿]],
  [[⡪⢪⢘⠄⠀⠁⡊⠢⠨⠢⡀⢇⢣⠱⡌⠀⠀⠀⠀⣿⠀⠀⠀⠀⣿⠀⣇⡀⠀⠀⠀⠀⠀⢧⠀⠀⠀⠀⠀⡇⠀⠸⣿⣆⣿⡟⠀⢸⣿⡇⠀⢸⡇⠀⠀⠀⣿⡇⠀⠀⣿⣿]],
  [[⡪⡊⡎⡂⠀⠀⠀⠑⠅⠕⢌⠪⡪⡪⡢⠀⠀⠀⠀⠿⠀⠀⠀⠀⠿⠀⠈⠑⠤⠤⠤⠒⠀⠈⠢⠤⠤⠤⠚⠁⠀⠀⠉⠿⠃⠀⠀⠘⠻⠇⠀⠸⠇⠀⠀⠀⠿⠃⠀⠀⠿⠿]],
  [[⠘⡜⡜⡂⠀⠀⠀⠀⠁⠣⡡⢣⢊⠎⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
  [[⠀⠀⠑⠅⠀⠀⠀⠀⠀⠐⢘⠌⠂⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
}
dashboard.section.buttons.val = {
  dashboard.button("f", icons.documents.Files .. " Find file", ":FzfLua files <CR>"),
  dashboard.button("e", icons.ui.NewFile .. " New file", ":ene <BAR> startinsert <CR>"),
  dashboard.button("p", icons.git.Repo .. " Find project", ":FzfProject<CR>"),
  dashboard.button("r", icons.ui.History .. " Recent files", ":FzfLua oldfiles <CR>"),
  dashboard.button("t", icons.ui.List .. " Find text", ":FzfLua live_grep <CR>"),
  dashboard.button("c", icons.ui.Gear .. " Config", ":e ~/.config/nvim/init.lua <CR>"),
  dashboard.button("u", icons.ui.CloudDownload .. " Update", ":PackerSync<CR>"),
  dashboard.button("q", icons.ui.SignOut .. " Quit", ":qa<CR>"),
}
local function footer()
  local handle = io.popen "fortune vimtips"
  local fortune = handle:read "*a"
  handle:close()
  return fortune
end

dashboard.section.footer.val = footer()

dashboard.section.footer.opts.hl = "Type"
dashboard.section.header.opts.hl = "Include"
dashboard.section.buttons.opts.hl = "Keyword"

dashboard.opts.opts.noautocmd = true
-- vim.cmd([[autocmd User AlphaReady echo 'ready']])
alpha.setup(dashboard.opts)
