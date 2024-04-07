local options = {
	ensure_installed = {
		"lua-language-server",
		"eslint-lsp",
		"typescript-language-server",
		"rust-analyzer",
		"prettier",
		"pyright",
		"dockerfile-language-server",
		"docker-compose-language-service",
		"stylua",
		"bash-language-server",
		"beautysh",
	},

	PATH = "prepend",

	ui = {
		icons = {
			package_pending = " ",
			package_installed = "󰄳 ",
			package_uninstalled = " 󰚌",
		},

		keymaps = {
			toggle_server_expand = "<CR>",
			install_server = "i",
			update_server = "u",
			check_server_version = "c",
			update_all_servers = "U",
			check_outdated_servers = "C",
			uninstall_server = "X",
			cancel_installation = "<C-c>",
		},
	},
	max_concurrent_installers = 10,
}

local plugin = {
	"williamboman/mason.nvim",
	config = function()
		require("mason").setup(options)

		vim.api.nvim_create_user_command("MasonInstallAll", function()
			vim.cmd("MasonInstall " .. table.concat(options.ensure_installed, " "))
		end, {})

		vim.g.mason_binaries_list = options.ensure_installed
	end,
}

local keymap = {
	["<leader>"] = {
		m = {
			name = "Mason",
			i = { "<cmd>MasonInstallAll<CR>", "Install all" },
			u = { "<cmd>MasonUpdateAll<CR>", "Update all" },
			c = { "<cmd>MasonCheckAll<CR>", "Check all" },
			C = { "<cmd>MasonCheckOutdatedAll<CR>", "Check outdated all" },
			U = { "<cmd>MasonUpdateAll<CR>", "Update all" },
			X = { "<cmd>MasonUninstallAll<CR>", "Uninstall all" },
		},
	},
}

return {
	plugin = plugin,
	keymap = keymap,
}
