-- Map Leader
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set lazy.nvim path
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

-- Ensure lazy.nvim is installed
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- Latest stable release
        lazypath
    })
end

-- Add lazy.nvim to runtimepath
vim.opt.rtp:prepend(lazypath)

-- Plugins
local plugins = {
	'github/copilot.vim',
	'preservim/nerdtree',
	require('plugins.nvim-lspconfig'),
	{
		'tiagovla/tokyodark.nvim',	-- Colorscheme
		priority = 9999,		-- Make sure to load this before all the other start plugins
		init = function()
			vim.cmd.colorscheme('tokyodark')
		end,
	},
	'42paris/42header',
	{
		'nvim-telescope/telescope.nvim', tag = '0.1.8',
		dependencies = { 'nvim-lua/plenary.nvim' },
	},
}

local opts = {}

require("lazy").setup(plugins, opts)

-- Export
vim.g.user42 = 'jazevedo'
vim.g.mail42 = 'jazevedo@student.42.rio'

-- Startup CMDs
vim.cmd('set nu')
vim.cmd('set termguicolors')
	-- Format with :F
vim.cmd('command! F :lua vim.lsp.buf.format()')
	-- Format and save with :W
vim.cmd('command! W :exec "F" | w')

-- Keymaps
vim.keymap.set('i', '<M-w>', '<ESC>:w<CR>')
vim.keymap.set('n', '<leader>x', ':NERDTreeToggle<CR>')

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
