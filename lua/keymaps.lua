-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`
-- CUSTOM keymaps start
-- Conditional keymaps depending on whether nvim is running inside vscode
if not vim.g.vscode then
  vim.keymap.set('n', '<C-d>', '<C-d>zz') -- Better scrolling
  vim.keymap.set('n', '<C-u>', '<C-u>zz') -- Better scrolling
  vim.keymap.set('n', '<C-s>', '<cmd>:update<CR>') -- Saving buffer changes to file
  vim.keymap.set('v', '<C-s>', '<C-c><cmd>:update<CR>') -- Same for Visual
  vim.keymap.set('i', '<C-s>', '<C-o><cmd>:update<CR>') -- Same for Insert
  -- Diagnostic keymaps
  vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
end

-- Run the selected command with langremap enabled
local function langremap_toggled_cmd(command)
  vim.opt.langremap = true
  vim.cmd('normal!' .. command)
  vim.opt.langremap = false
end

-- Regular CUSTOM keymaps
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move selection up in visual mode', silent = true })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move selection down in visual mode', silent = true })
vim.keymap.set('n', 'Q', '@q') -- Q to replay macro
vim.keymap.set('i', 'jk', '<Esc>') -- Quick escape from insert mode
vim.keymap.set('n', '<leader>cd', '<cmd>:cd %:p:h<CR>', { desc = 'Change working directory to current file location' })

-- Pastries
vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+y') -- [Y]ank to system clipboard
vim.keymap.set({ 'n', 'v' }, '<leader>p', '"+p') -- [P]aste from system clipboard
vim.keymap.set('x', '<leader>P', [["_dP]]) -- Don't replace register when pasting in Visual mode

-- Langremap macro fixes
vim.keymap.set('n', '<leader>@', function()
  langremap_toggled_cmd '@@'
end, { noremap = true, silent = true, desc = 'Run previous macro with langremap toggled' })

vim.keymap.set('v', '<leader>@', function()
  langremap_toggled_cmd 'gv@@'
end, { noremap = true, silent = true, desc = 'Run previous macro with langremap toggled' })
-- CUSTOM keymaps end

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
--  CUSTOM Set inside multicursor plugin
-- vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- vim: ts=2 sts=2 sw=2 et
