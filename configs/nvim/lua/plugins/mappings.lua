vim.g.mapleader = " "

local wk = require "which-key"

local mappings = {
	require("plugins.config.mason").keymap,
	require("plugins.config.lspconfig").keymap,
	require("plugins.config.nvimtree").keymap,
	require("plugins.config.telescope").keymap,
	require("plugins.config.treesitter").keymap,
	require("plugins.config.whichkey").keymap,
	require("plugins.config.tmux").keymap,
	require("plugins.config.cmp").keymap,
}

wk.register(mappings)

