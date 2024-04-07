local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system {
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	}
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
	require("plugins.config.mason").plugin,
	require("plugins.config.lspconfig").plugin,
	require("plugins.config.nvimtree").plugin,
	require("plugins.config.telescope").plugin,
	require("plugins.config.treesitter").plugin,
	require("plugins.config.whichkey").plugin,
	require("plugins.config.theme").plugin,
	require("plugins.config.null-ls").plugin,
	require("plugins.config.copilot").plugin,
	require("plugins.config.tmux").plugin,
}

require("lazy").setup(plugins)
