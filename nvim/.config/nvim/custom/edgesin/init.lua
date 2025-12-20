-- My Plugin to display "Hello, World!" in a new window
local M = {}

function M.open_hello_window()
	-- Create a new buffer
	local buf = vim.api.nvim_create_buf(false, true) -- no listed, scratch buffer

	-- Define the window options
	local win_opts = {
		relative = "editor",
		width = 30,
		height = 10,
		col = (vim.o.columns - 30) / 2, -- center the window
		row = (vim.o.lines - 10) / 2, -- center the window
		style = "minimal",
		border = "single",
	}

	-- Create a new floating window with the buffer
	local win = vim.api.nvim_open_win(buf, true, win_opts)

	-- Add "Hello, World!" text to the buffer
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, { "Hello, World!" })

	-- Keymap to close the window
	vim.api.nvim_buf_set_keymap(buf, "n", "q", "<cmd>bd!<CR>", { noremap = true, silent = true })
end

-- Expose the function as a command
function M.setup()
	vim.api.nvim_create_user_command("HelloWorld", function()
		M.open_hello_window()
	end, {})
end

return M
