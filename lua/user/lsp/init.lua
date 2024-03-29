local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require "user.lsp.solargraph"
require "user.lsp.hls"
require "user.lsp.gleam"
require "user.lsp.lsp-signature"
require "user.lsp.lsp-mason"
require("user.lsp.handlers").setup()
require "user.lsp.null-ls"
