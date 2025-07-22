-- requires
require("core.options")
require("core.keymaps")

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require("lazy").setup({
	-- Neo Tree
	require("plugins.neotree"),

	-- Tokyo night
	require("plugins.colortheme"),

	-- Buffer line
	require("plugins.bufferline"),

	-- Status line
	require("plugins.lualine"),

	-- Tree sitter
	require("plugins.treesitter"),

	-- Telescope
	require("plugins.telescope"),

	-- Git signs
	require("plugins.gitsigns"),

	-- Alpha loading screen
	require("plugins.alpha"),

	-- Indent black line
	require("plugins.indent-blankline"),

	-- Misc items
	require("plugins.misc"),

	-- Lazy git
	require("plugins.lazygit"),

	-- Debugger
	require("plugins.debug"),

	-- AI integreation
	require("plugins.avante"),

	-- Auto completion
	require("plugins.autocompletion"),

	-- LSP and Formatting
	require("plugins.none-ls"),
	require("plugins.lsp"),
})
