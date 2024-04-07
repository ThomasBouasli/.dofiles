local plugin = {
	"jose-elias-alvarez/null-ls.nvim",
	config = function()
		local null_ls = require "null-ls"

		local formatting = null_ls.builtins.formatting
		local lint = null_ls.builtins.diagnostics

		null_ls.setup {
			debug = true,
			sources = {
				formatting.prettier,
				formatting.stylua,
				lint.shellcheck,
				null_ls.builtins.formatting.beautysh
			},
		}
	end,
}

return { plugin = plugin }
