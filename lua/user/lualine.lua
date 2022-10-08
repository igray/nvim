local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
  return
end

vim.api.nvim_set_hl(0, "SLGitIcon", { fg = "#859900", bg = "#002b36" })
vim.api.nvim_set_hl(0, "SLBranchName", { fg = "#eee8d5", bg = "#002b36", bold = false })
vim.api.nvim_set_hl(0, "SLProgress", { fg = "#eee8d5", bg = "#002b36" })
vim.api.nvim_set_hl(0, "SLSeparator", { fg = "#839496", bg = "#073642" })
local mode_color = {
  n = "#268bd2",
  i = "#859900",
  v = "#d33682",
  [""] = "#d33682",
  V = "#d33682",
  c = "#2aa198",
  no = "#268bd2",
  s = "#cb4b16",
  S = "#cb4b16",
  [""] = "#cb4b16",
  ic = "#fdf6e3",
  R = "#dc322f",
  Rv = "#dc322f",
  cv = "#268bd2",
  ce = "##268bd2",
  r = "#dc322f",
  rm = "#2aa198",
  ["r?"] = "#2aa198",
  ["!"] = "#2aa198",
  t = "#b58900",
}

local mode = {
  -- mode component
  function()
    return "▊"
  end,
  color = function()
    -- auto change color according to neovims mode
    return { fg = mode_color[vim.fn.mode()] }
  end,
  -- padding = { right = 1 },
  padding = 0,
}

local hide_in_width_60 = function()
  return vim.o.columns > 60
end

local hide_in_width = function()
  return vim.o.columns > 80
end

local hide_in_width_100 = function()
  return vim.o.columns > 100
end

local icons = require "user.icons"

local diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  sections = { "error", "warn" },
  symbols = {
    error = "%#SLError#" .. icons.diagnostics.Error .. "%*" .. " ",
    warn = "%#SLWarning#" .. icons.diagnostics.Warning .. "%*" .. " ",
  },
  colored = false,
  update_in_insert = false,
  always_visible = true,
}

local diff = {
  "diff",
  colored = false,
  symbols = { added = icons.git.Add .. " ", modified = icons.git.Mod .. " ", removed = icons.git.Remove .. " " }, -- changes diff symbols
  cond = hide_in_width_60,
  separator = "%#SLSeparator#" .. "│ " .. "%*",
}

local filetype = {
  "filetype",
  icons_enabled = true,
  -- icon = nil,
}

local branch = {
  "branch",
  icons_enabled = true,
  icon = "%#SLGitIcon#" .. " " .. "%*" .. "%#SLBranchName#",
  -- color = "Constant",
  colored = false,
  -- cond = hide_in_width_100,
  fmt = function(str)
    if str == "" or str == nil then
      return "!=vcs"
    end

    return str
  end,
}

local progress = {
  "progress",
  color = "SLProgress",
}

local current_signature = function()
  if not pcall(require, "lsp_signature") then
    return
  end
  local sig = require("lsp_signature").status_line(30)
  return "%#SLSeparator#" .. sig.hint .. "%*"
end

local location = {
  "location",
  color = function()
    return { fg = "#002b36", bg = mode_color[vim.fn.mode()] }
  end,
}

lualine.setup {
  options = {
    globalstatus = true,
    icons_enabled = true,
    theme = "auto",
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = { "alpha", "dashboard" },
    always_divide_middle = true,
  },
  sections = {
    lualine_a = { mode, branch },
    lualine_b = { diagnostics },
    lualine_c = { { current_signature, cond = hide_in_width } },
    lualine_x = { diff, filetype },
    lualine_y = { progress },
    lualine_z = { location },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  extensions = {},
}
