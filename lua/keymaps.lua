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
  end, { noremap = true, silent = true })
end
-- CUSTOM FUNCTIONS END

-- Q to replay the q macro while using langremap.
map_macrofix('n', 'Q', '@q')

-- Restore regular functionality of macros with pressing leader key first
vim.keymap.set('n', '<leader>@', '@', { desc = 'Run macro with langremap off' })

-- Make macros run with langremap by default
vim.keymap.set('n', '@', function()
  -- Echo the entered command
  local count = vim.v.count
  local msg = (count == 0) and '@' or (count .. '@')
  vim.cmd('echo " ' .. msg .. '"')
  vim.cmd 'redraw'

  -- Wait for use to input one character and check if it's a valid register or @ with regex
  local c = vim.fn.nr2char(vim.fn.getchar())
  if string.find(c, '[a-zA-Z0-9":/.%*%+%-@]') then
    langremap_toggled_cmd(vim.v.count .. '@' .. c)
  end

  -- Clear the echoed command

  vim.cmd 'echo " "' -- Stupid fix to make it appear like it was also cleared in vscode.
  vim.cmd 'echo ""'
  vim.cmd 'redraw'
end)

-- Regular CUSTOM KEYMAPS
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move selection up in visual mode', silent = true })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move selection down in visual mode', silent = true })
-- vim.keymap.set('n', 'Q', '@q') -- map_macrofix version in use
vim.keymap.set('i', 'jk', '<Esc>') -- Quick escape from insert mode
vim.keymap.set('n', '<leader>cd', '<cmd>:cd %:p:h<CR>', { desc = '[C]hange working [D]irectory to current file location' })

-- Tab navigation
vim.keymap.set('n', 'H', 'gT')
vim.keymap.set('n', 'L', 'gt')
vim.keymap.set('n', '<Leader>tn', '<cmd>:tabnew<CR>', { desc = '[N]ew Tab' })
vim.keymap.set('n', '<Leader>tc', '<cmd>:tabclose<CR>', { desc = '[C]lose Tab' })

-- Pastries
vim.keymap.set({ 'n', 'v' }, '<leader>y', '""y', { desc = '[Y]ank to unnamed register' }) --
vim.keymap.set({ 'n', 'v' }, '<leader>p', '""p', { desc = '[P]aste from unnamed register' })
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

-- CUSTOM Plugin related mappings
-- Mini surround: [Y]ou [S]urround Line
vim.keymap.set('n', 'yss', 'ys_', { remap = true })

-- WhichKey: More intuitive shortcut for whichkey spell checking.
vim.keymap.set('n', '<leader>cs', '<cmd>:WhichKey<CR>z=', { desc = '[C]hange [S]pelling' })

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
