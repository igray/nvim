local status_ok, lsp_config = pcall(require, "lspconfig")
if not status_ok then
	return
end

-- Run solargraph from the project instead of using lsp-installer
local opts = {
  on_attach = require("user.lsp.handlers").on_attach,
  capabilities = require("user.lsp.handlers").capabilities,
}

local solargraph_opts = {}
opts = vim.tbl_deep_extend("force", solargraph_opts, opts)
lsp_config.solargraph.setup(opts)

