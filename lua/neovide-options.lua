-- Set windowed fullscreen toggle
vim.keymap.set({ 'n', 'v', '!' }, '<F11>', function()
  vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen
end)

-- Less annoying cursor animation
vim.g.neovide_cursor_trail_size = 0.1

-- Use previous window size when opening a new instance of neovide
vim.g.neovide_remember_window_size = true
