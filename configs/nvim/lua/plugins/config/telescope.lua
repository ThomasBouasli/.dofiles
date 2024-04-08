local plugin = {
	"nvim-telescope/telescope.nvim",
	dependencies = { 'nvim-lua/plenary.nvim' },
	config = function()
		local telescope = require("telescope")

		telescope.setup({
			pickers = {
				find_files = {
					hidden = true,
				},
				live_grep = {
					hidden = true,
				}
			}
		})
	end

}

local keymap = {
	["<leader>ff"] = { "<cmd> Telescope find_files <CR>", "Telescope Find files" },
	["<leader>fg"] = { "<cmd> Telescope live_grep <CR>", "Telescope Live grep" },
	["<leader>fr"] = { "<cmd> Telescope oldfiles <CR>", "Telescope Recent files" },
	["<leader>fb"] = { "<cmd> Telescope buffers <CR>", "Telescope Buffers" },
	["<leader>fh"] = { "<cmd> Telescope help_tags <CR>", "Telescope Help tags" },
	["<leader>fc"] = { "<cmd> Telescope commands <CR>", "Telescope Commands" },
	["<leader>fz"] = { "<cmd> Telescope current_buffer_fuzzy_fund<CR>", "Telescope Current buffer" },
}

return { plugin = plugin, keymap = keymap }
