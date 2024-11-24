-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`
-- CUSTOM KEYMAPS start
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

-- CUSTOM FUNCTIONS

-- Run the selected command with langremap enabled
local function langremap_toggled_cmd(command)
  vim.opt.langremap = true
  vim.cmd('normal!' .. command)
  vim.opt.langremap = false
end

-- Langremap macro fixes
local function map_macrofix(mode, mapping, action)
  vim.keymap.set(mode, mapping, function()
    langremap_toggled_cmd(vim.v.count .. action)
  end, { noremap = true, silent = true, desc = 'Run previous macro with langremap' })
end
-- CUSTOM FUNCTIONS END

map_macrofix('n', '<leader>@', '@@') -- langremap toggled @@
map_macrofix('n', 'Q', '@q') -- Q to replay macro

-- Regular CUSTOM KEYMAPS
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move selection up in visual mode', silent = true })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move selection down in visual mode', silent = true })
-- vim.keymap.set('n', 'Q', '@q') -- map_macrofix version in use
vim.keymap.set('i', 'jk', '<Esc>') -- Quick escape from insert mode
vim.keymap.set('n', '<leader>cd', '<cmd>:cd %:p:h<CR>', { desc = 'Change working directory to current file location' })

-- Tab navigation
vim.keymap.set('n', 'H', 'gT')
vim.keymap.set('n', 'L', 'gt')
vim.keymap.set('n', '<Leader>tn', '<cmd>:tabnew<CR>', { desc = '[N]ew Tab' })
vim.keymap.set('n', '<Leader>tc', '<cmd>:tabclose<CR>', { desc = '[C]lose Tab' })

-- Pastries
vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+y', { desc = '[Y]ank to system clipboard' }) --
vim.keymap.set({ 'n', 'v' }, '<leader>p', '"+p', { desc = '[P]aste from system clipboard' })
vim.keymap.set('x', '<leader>P', [["_dP]], { desc = '[P]reserve registry when pasting over' }) -- Don't replace register when pasting in Visual mode
-- CUSTOM KEYMAPS end

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
