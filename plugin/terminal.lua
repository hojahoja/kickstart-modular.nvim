if not vim.g.vscode then
  -- Disable line numbers for terminal
  vim.api.nvim_create_autocmd('TermOpen', {
    group = vim.api.nvim_create_augroup('custom-term-open', { clear = true }),
    callback = function()
      vim.opt.number = false
      vim.opt.relativenumber = false
    end,
  })

  -- Open small terminal below
  vim.keymap.set('n', '<leader>ot', function()
    vim.cmd.vnew()
    vim.cmd.term()
    vim.cmd.wincmd 'J'
    vim.api.nvim_win_set_height(0, 5)
  end, { desc = '[O]pen small [T]erminal below' })

  local state = {
    floating = {
      buf = -1,
      win = -1,
    },
  }

  local function create_floating_window(opts)
    opts = opts or {}
    local width = opts.width or math.floor(vim.o.columns * 0.8)
    local height = opts.height or math.floor(vim.o.lines * 0.8)

    -- Calculate the position to center the window
    local col = math.floor((vim.o.columns - width) / 2)
    local row = math.floor((vim.o.lines - height) / 2)

    -- Create a buffer
    local buf = nil
    if vim.api.nvim_buf_is_valid(opts.buf) then
      buf = opts.buf
    else
      buf = vim.api.nvim_create_buf(false, true) -- No file, scratch buffer
    end

    -- Define window configuration
    local win_config = {
      relative = 'editor',
      width = width,
      height = height,
      col = col,
      row = row,
      style = 'minimal', -- No borders or extra UI elements
      border = 'rounded',
    }

    -- Create the floating window
    local win = vim.api.nvim_open_win(buf, true, win_config)

    return { buf = buf, win = win }
  end

  local toggle_terminal = function()
    if not vim.api.nvim_win_is_valid(state.floating.win) then
      state.floating = create_floating_window { buf = state.floating.buf }
      if vim.bo[state.floating.buf].buftype ~= 'terminal' then
        vim.cmd.terminal()
      end
    else
      vim.api.nvim_win_hide(state.floating.win)
    end
    vim.cmd 'normal i'
  end

  -- Example usage:
  -- Create a floating window with default dimensions
  vim.api.nvim_create_user_command('Floaterminal', toggle_terminal, {})

  -- Toggle terminal in normal mode
  vim.keymap.set({ 'n' }, '<leader>tt', toggle_terminal, { desc = '[T]oggle floating [T]erminal' })

  -- jk Quickly Hides floating terminal when inside terminal mode
  vim.keymap.set('t', 'jk', function()
    if vim.api.nvim_win_is_valid(state.floating.win) then
      vim.api.nvim_win_hide(state.floating.win)
    end
  end)
end
-- vim: ts=2 sts=2 sw=2 et
