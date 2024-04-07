local plugin = {
	"nvim-treesitter/nvim-treesitter",
	config = function()
		local configs = require "nvim-treesitter.configs"

		configs.setup {
			ensure_installed = {
				"c",
				"lua",
				"vim",
				"vimdoc",
				"query",
				"elixir",
				"heex",
				"javascript",
				"html",
				"rust",
				"go",
			},
			auto_install = true,
			ignore_install = { "javascript" },
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			sync_install = false,
			indent = { enable = true },
		}
	end,
	build = ":TSUpdate",
}

local keymap = {
	["<leader>tt"] = { "<cmd> TSBufToggle <CR>", "Toggle treesitter" },
}

return { plugin = plugin, keymap = keymap }
