local plugin = {
	"hrsh7th/nvim-cmp",
	dependencies = {
		{ "hrsh7th/cmp-buffer", after = "nvim-cmp" },
		{ "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" },
		{ "hrsh7th/cmp-vsnip", after = "nvim-cmp" },
	},
	config = function()
		local cmp = require "cmp"

		cmp.setup {
			snippet = {
				expand = function(args)
					vim.fn["vsnip#anonymous"](args.body)
				end,
			},
			mapping = {
				["<C-d>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.close(),
				["<CR>"] = cmp.mapping.confirm {
					behavior = cmp.ConfirmBehavior.Insert,
					select = true,
				},
			},
			sources = {
				{ name = "nvim_lsp" },
				{ name = "vsnip" },
				{ name = "buffer" },
			},
		}
	end,
}

local mappings = {
	{ "i", "<Tab>",   "v:lua.tab_complete()",   { expr = true } },
	{ "s", "<Tab>",   "v:lua.tab_complete()",   { expr = true } },
	{ "i", "<S-Tab>", "v:lua.s_tab_complete()", { expr = true } },
	{ "s", "<S-Tab>", "v:lua.s_tab_complete()", { expr = true } },
}

return {
	plugin = plugin,
	mappings = mappings,
}
