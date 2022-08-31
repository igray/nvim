local status_ok, lsp_config = pcall(require, "lspconfig")
if not status_ok then
	return
end

-- Run hls from the project instead of using lsp-installer
local opts = {
  on_attach = require("user.lsp.handlers").on_attach,
  capabilities = require("user.lsp.handlers").capabilities,
}

local hls_opts = {}
opts = vim.tbl_deep_extend("force", hls_opts, opts)
lsp_config.hls.setup(opts)

