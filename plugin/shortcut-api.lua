vim.api.nvim_create_user_command("ShortcutBranch", function()
	require("shortcut-api").create_branch()
end, {})
