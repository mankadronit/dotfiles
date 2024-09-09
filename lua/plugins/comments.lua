return {
	"numToStr/Comment.nvim",
	config = function()
		local comment = require("Comment")
		comment.setup()

		vim.keymap.set("n", "<leader>/", "<Plug>(comment_toggle_linewise)", { noremap = true, silent = true })
		vim.keymap.set("v", "<leader>/", "<Plug>(comment_toggle_linewise_visual)", { noremap = true, silent = true })
	end,
}
