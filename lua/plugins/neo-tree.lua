return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		require("neo-tree").setup({
			close_if_last_window = true,
      filesystem = {
				filtered_items = {
					visible = true, -- This will show hidden files
					hide_dotfiles = false, -- This will show dotfiles
					hide_gitignored = false, -- This will show git ignored files
				},
			},
		})
			vim.keymap.set("n", "<C-n>", ":Neotree filesystem reveal left<CR>")
	end,
}
