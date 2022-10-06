local status_ok, mason = pcall(require, "mason")
if not status_ok then
  return
end

local mason_settings = {
  -- automatic_installation = false,
  ui = {
    icons = {
      -- server_installed = "◍",
      -- server_pending = "◍",
      -- server_uninstalled = "◍",
      -- server_installed = "✓",
      -- server_pending = "➜",
      -- server_uninstalled = "✗",
    },
    keymaps = {
      toggle_server_expand = "<CR>",
      install_server = "i",
      update_server = "u",
      check_server_version = "c",
      update_all_servers = "U",
      check_outdated_servers = "C",
      uninstall_server = "X",
    },
  },

  log_level = vim.log.levels.INFO,
  -- max_concurrent_installers = 4,
  -- install_root_dir = path.concat { vim.fn.stdpath "data", "lsp_servers" },
}

mason.setup(mason_settings)

local lsp_status_ok, lsp_mason = pcall(require, "mason-lspconfig")
if not lsp_status_ok then
  return
end

local servers = {
  "cssls",
--  "cssmodules_ls",
  "elmls",
--  "emmet_ls",
  "html",
  "jsonls",
  "sumneko_lua",
  "tsserver",
  "yamlls",
  "bashls",
}

lsp_mason.setup {
  ensure_installed = servers,
}

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  return
end

local opts = {}

for _, server in pairs(servers) do
  opts = {
    on_attach = require("user.lsp.handlers").on_attach,
    capabilities = require("user.lsp.handlers").capabilities,
  }

  if server == "jsonls" then
    local jsonls_opts = require "user.lsp.settings.jsonls"
    opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
  end

  if server == "sumneko_lua" then
    local sumneko_opts = require "user.lsp.settings.sumneko_lua"
    opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
  end

  if server == "emmet_ls" then
    local emmet_ls_opts = require "user.lsp.settings.emmet_ls"
    opts = vim.tbl_deep_extend("force", emmet_ls_opts, opts)
  end

  if server == "tailwindcss" then
    local tailwind_opts = require("user.lsp.settings.tailwindcss")
    opts = vim.tbl_deep_extend("force", tailwind_opts, opts)
  end

  if server == "elmls" then
    local elmls_opts = require("user.lsp.settings.elmls")
    opts = vim.tbl_deep_extend("force", elmls_opts, opts)
  end

  lspconfig[server].setup(opts)
end

-- TODO: add something to installer later
-- require("lspconfig").motoko.setup {}
