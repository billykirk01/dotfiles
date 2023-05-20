-- ========================================================================== --
-- ==                           EDITOR SETTINGS                            == --
-- ========================================================================== --

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = 'a'
vim.o.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.wrap = true
vim.opt.breakindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.signcolumn = 'yes'

-- hard mode
vim.keymap.set('n', '<left>', '')
vim.keymap.set('n', '<right>', '')
vim.keymap.set('n', '<up>', '')
vim.keymap.set('n', '<down>', '')

-- move with ctrl + <left,right,up,down>
vim.keymap.set('i', '<c-h>', '<left>')
vim.keymap.set('i', '<c-l>', '<right>')
vim.keymap.set('i', '<c-k>', '<up>')
vim.keymap.set('i', '<c-j>', '<down>')

-- Space as leader key
vim.g.mapleader = ';'

-- Shortcuts
vim.keymap.set('n', '<leader>a', ':keepjumps normal! ggVG<cr>')
vim.keymap.set('n', '<c-u>', '<c-u>zz')
vim.keymap.set('n', '<c-d>', '<c-d>zz')
vim.keymap.set('n', '<leader>o', 'o<esc>k')
vim.keymap.set('n', '<leader>O', 'O<esc>j')

-- Snippets
vim.keymap.set('s', '<leader>r', '<esc>viw"+p')

-- Move in windows, buffers, and tabs
vim.keymap.set('n', '<c-H>', '<c-w>h')
vim.keymap.set('t', '<c-H>', '<c-\\><c-n><c-w>h') -- move from terminal back to editor window
vim.keymap.set('n', '<c-L>', '<c-w>l')

-- escape terminal mode
vim.keymap.set('t', '<esc><esc>', '<c-\\><c-n>')

-- Basic clipboard interaction
vim.keymap.set({ 'n', 'x' }, '<leader>y', '"+y')
vim.keymap.set({ 'n', 'x' }, '<leader>p', '"+p')
vim.keymap.set({ 'n', 'x' }, '<leader>r', 'viw"+p')
vim.keymap.set('v', '<leader>r', '"+p')
vim.keymap.set({ 'v' }, '<leader>gr', 'y:%s@<c-r>"@@g|\'\'<left><left><left><left><left>')

-- Delete text
vim.keymap.set({ 'n', 'x' }, 'x', '"_x')
