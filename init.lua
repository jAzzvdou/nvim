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
	'preservim/nerdtree',
	'tiagovla/tokyodark.nvim',
	'github/copilot.vim'
}

local opts = {}

require("lazy").setup(plugins, opts)

-- Startup CMDs
vim.cmd('set nu')
vim.cmd('colorscheme tokyodark')
vim.cmd('set termguicolors')

-- Keymaps
vim.keymap.set('n', '<C-r>', ':NERDTree<CR>')
