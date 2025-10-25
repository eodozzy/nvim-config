vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.g.mapleader = " "

-- Navigate vim panes better
vim.keymap.set('n', '<c-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<c-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<c-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<c-l>', ':wincmd l<CR>')

-- Make relative line numbers default
vim.wo.relativenumber = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Set autoindent behavior 
vim.o.autoindent = true
vim.o.cindent = true

vim.keymap.set({ 'i', 'v' }, 'jj', '<Esc>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Center cursor after page navigation
vim.keymap.set('n', '<C-f>', '<C-f>zz', { noremap = true, silent = true })
vim.keymap.set('n', '<C-b>', '<C-b>zz', { noremap = true, silent = true })
vim.keymap.set('n', '<C-d>', '<C-d>zz', { noremap = true, silent = true })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { noremap = true, silent = true })

-- Python virtual environment detection
local function get_python_path()
    local venv = vim.fn.environ()["VIRTUAL_ENV"]
    if venv then
        return venv .. "/bin/python"
    else
        local cwd_venv = vim.fn.getcwd() .. "/venv/bin/python"
        if vim.fn.filereadable(cwd_venv) == 1 then
            return cwd_venv
        end
        return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
    end
end

vim.g.python3_host_prog = get_python_path()

-- Python specific settings
vim.api.nvim_create_autocmd("FileType", {
    pattern = "python",
    callback = function()
        -- Set up Python formatting on save with Black
        vim.api.nvim_command([[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]])
    end,
})
