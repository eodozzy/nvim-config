-- Keymaps for better default experience

-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true });
vim.keymap.set({ 'i', 'v' }, 'jj', '<Esc>', { silent = true })

-- Remap for dealing with word wrap;
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true });
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

vim.g.mapleader = " "
vim.g.maplocalleader = ' '

-- set keymaping to pull file tree
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Remap for dealing with word wrap;
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- set keymaping for 1/2 page up/down
vim.keymap.set('n', '<C-d>', '<C-d>zz', { silent = true });
vim.keymap.set('n', '<C-u>', '<C-u>zz', { silent = true })
