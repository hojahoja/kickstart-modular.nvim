-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Conditional options depending on whether nvim is running inside vscode.
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
-- vim.opt.langmap = '§½\\"¤&/()=;`~@$^&*(),+?´`;-_=+,åÅ¨^;[{]},öÖäÄ*;\\;:\'\\"\\|,\\;:-_;<>/?,'
vim.opt.langmap = "§½¤&/()=;`~$^&*(),+?´`;-_=+,åÅ¨^;[{]},öÖ*ä;\\;:\\\\',\\;:-_;<>/?,"
-- Keymap fixes for when langmap is not enough
vim.keymap.set('', 'å', '[', { remap = true, nowait = true })
vim.keymap.set('', '¨', ']', { remap = true, nowait = true })
vim.keymap.set('', 'ö', ';', { remap = true, nowait = true })
vim.keymap.set('', 'Ä', '"', { remap = true, nowait = true })

-- Windows specific options
if vim.uv.os_uname().sysname:lower():find 'windows' ~= nil then
  -- Make vim use english
  vim.opt.langmenu = 'en_US'
  vim.api.nvim_exec2('lan mes en_US', {})
  -- Configures powershell support shell-powershell. Uses PowerShell7 if available
  -- help: shell-powershell
  vim.o.shell = vim.fn.executable 'pwsh' and 'pwsh' or 'powershell'
  vim.o.shellcmdflag =
    "-NoLogo -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();$PSDefaultParameterValues['Out-File:Encoding']='utf8';Remove-Alias -Force -ErrorAction SilentlyContinue tee;"
  vim.o.shellredir = '2>&1 | %%{ "$_" } | Out-File %s; exit $LastExitCode'
  vim.o.shellpipe = '2>&1 | %%{ "$_" } | tee %s; exit $LastExitCode'
  vim.opt.shellquote = ''
  vim.opt.shellxquote = ''
end

-- Default indentation options
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Add syntax highlight support back to files with .tmpl extension.
-- And other files that have messed up highlighting because off suffix
-- or prefix changes.
vim.filetype.add {
  extension = {
    tmpl = function(path)
      if string.find(path, 'zsh') then
        return 'zsh'
      elseif string.find(path, '.fish') then
        return 'fish'
      elseif string.find(path, 'toml') then
        return 'toml'
      elseif string.find(path, 'gitconfig') then
        return 'gitconfig'
      elseif string.find(path, 'tmux') then
        return 'tmux'
      end
      return 'template'
    end,
  },
  filename = {
    ['dot_zshrc'] = 'zsh',
    ['fish_variables'] = 'fish',
    ['.chezmoiignore'] = 'gitconfig',
  },
}
-- CUSTOM options end

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
--
--  Notice listchars is set using `vim.opt` instead of `vim.o`.
--  It is very similar to `vim.o` but offers an interface for conveniently interacting with tables.
--   See `:help lua-options`
--   and `:help lua-options-guide`
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'

-- vim: ts=2 sts=2 sw=2 et
