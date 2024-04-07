local plugin = {
	"nvim-tree/nvim-tree.lua",
	config = function()
		require("nvim-tree").setup()
	end,
}

local keymap = {
	["<C-n>"] = { "<cmd> NvimTreeToggle <CR>", "Toggle nvimtree" },
}

return { plugin = plugin, keymap = keymap }

