local plugin = {
	"neovim/nvim-lspconfig",
	config = function()
		local lspconfig = require "lspconfig"

		lspconfig.pyright.setup {}
		lspconfig.tsserver.setup {}
		lspconfig.bashls.setup {}
		lspconfig.eslint.setup {}
		lspconfig.rust_analyzer.setup {}
		lspconfig.pyright.setup {}
		lspconfig.dockerls.setup {}
		lspconfig.docker_compose_language_service.setup {}
		lspconfig.lua_ls.setup {
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
						disable = { "missing-fields" },
					},
					workspace = {
						library = {
							[vim.fn.expand "$VIMRUNTIME/lua"] = true,
							[vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
						},
						maxPreload = 100000,
						preloadFileSize = 10000,
					},
				},
			},
		}
	end,
}

local keymap = {
	["<leader>gd"] = {
		"<cmd> lua vim.lsp.buf.definition()<CR>",
		"Go to definition",
	},
	["<leader>gr"] = {
		"<cmd> lua vim.lsp.buf.references()<CR>",
		"Go to references",
	},
	["<leader>gi"] = {
		"<cmd> lua vim.lsp.buf.implementation()<CR>",
		"Go to implementation",
	},
	["<leader>gh"] = { "<cmd> lua vim.lsp.buf.hover()<CR>", "Show hover" },
	["<leader>ca"] = { "<cmd> lua vim.lsp.buf.code_action()<CR>", "Code action" },
	["<leader>rn"] = { "<cmd> lua vim.lsp.buf.rename()<CR>", "Rename" },
	["<leader>fm"] = { "<cmd> lua vim.lsp.buf.format()<CR>", "Format" },
}

return { plugin = plugin, keymap = keymap }
