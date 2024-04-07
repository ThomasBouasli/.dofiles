local plugin = {
	"christoomey/vim-tmux-navigator",
	lazy = false,
}

local keymap = {
	["<C-h>"] = { "<cmd> TmuxNavigateLeft <CR>", "Navigate left" },
	["<C-j>"] = { "<cmd> TmuxNavigateDown <CR>", "Navigate down" },
	["<C-k>"] = { "<cmd> TmuxNavigateUp <CR>", "Navigate up" },
	["<C-l>"] = { "<cmd> TmuxNavigateRight <CR>", "Navigate right" },
}

return { plugin = plugin, keymap = keymap }
