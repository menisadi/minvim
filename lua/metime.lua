local M = {}

function M.just_print()
	print("Hooray!")
end

vim.api.nvim_create_user_command("CounterCheck", M.just_print, {})

return M
