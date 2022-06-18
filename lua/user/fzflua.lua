local status_ok, fzflua = pcall(require, "fzf-lua")
if not status_ok then
	return
end

fzflua.setup({
	previewers = {
		builtin = {
			extensions = {
				["png"] = { "viu", "-b" },
				["jpg"] = { "viu", "-b" },
				["jpeg"] = { "viu", "-b" },
				["gif"] = { "viu", "-b" },
			},
		},
	},
})
