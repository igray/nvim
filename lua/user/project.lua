local status_ok, project = pcall(require, "project_nvim")
if not status_ok then
	return
end
project.setup({
	---@usage set to false to disable project.nvim.
	--- This is on by default since it's currently the expected behavior.
	active = true,

	on_config_done = nil,

	---@usage set to true to disable setting the current-woriking directory
	--- Manual mode doesn't automatically change your root directory, so you have
	--- the option to manually do so using `:ProjectRoot` command.
	manual_mode = false,

	---@usage Methods of detecting the root directory
	--- Allowed values: **"lsp"** uses the native neovim lsp
	--- **"pattern"** uses vim-rooter like glob pattern matching. Here
	--- order matters: if one is not detected, the other is used as fallback. You
	--- can also delete or rearangne the detection methods.
	-- detection_methods = { "lsp", "pattern" }, -- NOTE: lsp detection will get annoying with multiple langs in one project
	detection_methods = { "pattern" },

	---@usage patterns used to detect root dir, when **"pattern"** is in detection_methods
	patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },

	---@ Show hidden files in telescope when searching for files in a project
	show_hidden = false,

	---@usage When set to false, you will get a message when project.nvim changes your directory.
	-- When set to false, you will get a message when project.nvim changes your directory.
	silent_chdir = true,

	---@usage list of lsp client names to ignore when using **lsp** detection. eg: { "efm", ... }
	ignore_lsp = {},

	---@type string
	---@usage path to store the project history for use in telescope
	datapath = vim.fn.stdpath("data"),
})

local fzf_status_ok, fzflua = pcall(require, "fzf-lua")
if not fzf_status_ok then
	return
end

vim.api.nvim_create_user_command(
  "FzfProject",
  function()
    local opts = {}
    opts.prompt = "Projects> "
    opts.actions = {
      ['default'] = function(selected)
        vim.cmd("FzfLua files cwd=" .. selected[1])
      end
    }
    -- projects are returned oldest first
    local projects = project.get_recent_projects()
    local recent_projects = {}
    for i=#projects, 1, -1 do
      recent_projects[#recent_projects+1] = projects[i]
    end
    fzflua.fzf_exec(recent_projects, opts)
  end,
  { nargs = 0 }
)
