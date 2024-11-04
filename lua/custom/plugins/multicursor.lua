return {
  { -- MultiCursorPlugin CUSTOM
    'jake-stewart/multicursor.nvim',
    branch = '1.0',
    config = function()
      local mc = require 'multicursor-nvim'

      mc.setup()

      local set = vim.keymap.set

      -- Add or skip cursor above/below the main cursor.
      set({ 'n', 'v' }, '<up>', function()
        mc.lineAddCursor(-1)
      end)
      set({ 'n', 'v' }, '<down>', function()
        mc.lineAddCursor(1)
      end)
      set({ 'n', 'v' }, '<leader><up>', function()
        mc.lineSkipCursor(-1)
      end, { desc = 'Add cursor above' })
      set({ 'n', 'v' }, '<leader><down>', function()
        mc.lineSkipCursor(1)
      end, { desc = 'Add cursor below' })

      -- Add or skip adding a new cursor by matching word/selection
      set({ 'n', 'v' }, '<leader>n', function()
        mc.matchAddCursor(1)
      end, { desc = 'Multicursor: [N]ote next' })
      set({ 'n', 'v' }, '<leader>m', function()
        mc.matchSkipCursor(1)
      end, { desc = 'Multicursor: [M]ove over next' })
      set({ 'n', 'v' }, '<leader>N', function()
        mc.matchAddCursor(-1)
      end, { desc = 'Multicursor: [N]ote previous' })
      set({ 'n', 'v' }, '<leader>M', function()
        mc.matchSkipCursor(-1)
      end, { desc = 'Multicursor: [M]ove over previous' })

      -- Add all matches in the document
      set({ 'n', 'v' }, '<leader>A', mc.matchAllAddCursors, { desc = 'Multicursor: add [A]ll' })

      -- You can also add cursors with any motion you prefer:
      -- set("n", "<right>", function()
      --     mc.addCursor("w")
      -- end)
      -- set("n", "<leader><right>", function()
      --     mc.skipCursor("w")
      -- end)

      -- Rotate the main cursor.
      set({ 'n', 'v' }, '<left>', mc.nextCursor)
      set({ 'n', 'v' }, '<right>', mc.prevCursor)

      -- Delete the main cursor.
      set({ 'n', 'v' }, '<leader>x', mc.deleteCursor, { desc = 'Multicursor: [X] delete current' })

      -- Add and remove cursors with control + left click.
      set('n', '<c-leftmouse>', mc.handleMouse)

      -- Easy way to add and remove cursors using the main cursor.
      set({ 'n', 'v' }, '<c-q>', mc.toggleCursor)

      -- Clone every cursor and disable the originals.
      set({ 'n', 'v' }, '<leader><c-q>', mc.duplicateCursors, { desc = 'Multicursor: [C-Q] duplicate current' })

      set('n', '<esc>', function()
        if not mc.cursorsEnabled() then
          mc.enableCursors()
        elseif mc.hasCursors() then
          mc.clearCursors()
        else
          -- Default <esc> handler.
        end
      end)

      -- bring back cursors if you accidentally clear them
      set('n', '<leader>gv', mc.restoreCursors, { desc = 'Multicursor: [V] restore' })

      -- Align cursor columns.
      set('n', '<leader>a', mc.alignCursors, { desc = 'Multicursor: [A]lign' })

      -- Split visual selections by regex.
      set('v', 'S', mc.splitCursors)

      -- Append/insert for each line of visual selections.
      set('v', 'I', mc.insertVisual)
      set('v', 'A', mc.appendVisual)

      -- match new cursors within visual selections by regex.
      set('v', 'M', mc.matchCursors)

      -- Rotate visual selection contents.
      set('v', '<leader>t', function()
        mc.transposeCursors(1)
      end, { desc = 'Multicursor: [T]ranspose forward' })
      set('v', '<leader>T', function()
        mc.transposeCursors(-1)
      end, { desc = 'Multicursor: [T]ranspose backwards' })

      -- Jumplist support
      set({ 'v', 'n' }, '<c-i>', mc.jumpForward)
      set({ 'v', 'n' }, '<c-o>', mc.jumpBackward)

      -- Customize how cursors look.
      local hl = vim.api.nvim_set_hl
      hl(0, 'MultiCursorCursor', { link = 'Cursor' })
      hl(0, 'MultiCursorVisual', { link = 'Visual' })
      hl(0, 'MultiCursorSign', { link = 'SignColumn' })
      hl(0, 'MultiCursorDisabledCursor', { link = 'Visual' })
      hl(0, 'MultiCursorDisabledVisual', { link = 'Visual' })
      hl(0, 'MultiCursorDisabledSign', { link = 'SignColumn' })
    end,
  },
}
