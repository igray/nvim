local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
	return
end

local configs = require("lspconfig.configs")
local util = require("lspconfig.util")

-- Check if the config is already defined (useful when reloading this file)
if not configs.gleam then
	configs.gleam = {
		default_config = {
			cmd = { "gleam", "lsp" },
			filetypes = { "gleam" },
			root_dir = function(fname)
				return util.root_pattern("gleam.toml")(fname)
			end,
      settings = {};
		};
	}
end

lspconfig.gleam.setup({})
