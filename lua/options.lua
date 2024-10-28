-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Conditional keymaps depending on whether nvim is running inside vscode.
if not vim.g.vscode then
  -- Make line numbers default
  vim.opt.number = true
  -- You can also add relative line numbers, to help with jumping.
  --  Experiment for yourself to see if you like it!
  vim.opt.relativenumber = true
  -- Don't show the mode, since it's already in the status line
  vim.opt.showmode = false
  -- Save undo history
  vim.opt.undofile = true
  -- Enable break indent
  vim.opt.breakindent = true
  -- Minimal number of screen lines to keep above and below the cursor.
  vim.opt.scrolloff = 10
  -- Show which line your cursor is on
  vim.opt.cursorline = true
end

-- CUSTOM options start
-- Langmap Finnish keyboard layout (No dead keys) to have English
-- special character layout in normal mode
vim.opt.langmap = '§½\\"¤&/()=;`~@$^&*(),+?´`;-_=+,åÅ¨^;[{]},öÖäÄ*;\\;:\'\\"\\|,\\;:-_;<>/?,<>;[]'

-- Windows specific langauge options
vim.opt.langmenu = 'en_US'
vim.api.nvim_exec2('lan mes en_US', {})
-- CUSTOM options end

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- vim: ts=2 sts=2 sw=2 et
