return {
  { -- Collection of various small independent plugins/modules
    'nvim-mini/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - ysiw) - [Y]ou [S]urround [I]nner [W]ord [)]Paren
      -- - ds'   - [D]elete [S]urrounding [']quotes
      -- - cs)'  - [C]hange [S]urrounding [)] [']
      require('mini.surround').setup {
        mappings = {
          add = 'ys', -- Add surrounding in Normal and Visual modes
          delete = 'ds', -- Delete surrounding
          find = 'gsf', -- Find surrounding (to the right)
          find_left = 'gsF', -- Find surrounding (to the left)
          highlight = 'gsh', -- Highlight surrounding
          replace = 'cs', -- Replace surrounding
          update_n_lines = 'gsn', -- Update `n_lines`

          suffix_last = 'l', -- Suffix to search with "prev" method
          suffix_next = 'n', -- Suffix to search with "next" method
        },
        custom_surroundings = {
          ['B'] = { output = { left = '{', right = '}' } },
        },
      }

      require('mini.indentscope').setup()

      -- Adds new objects for selection based on indentation level
      -- - ii - Select [I]nside [I]indentation
      -- - ai - Select [A]round [I]indentation

      -- Do not load these mini plugins if running inside vscode.
      if not vim.g.vscode then
        -- Download the mini icon suite that some plugins depend on.
        -- Replace nvim_web_devicons with mini icons.
        require('mini.icons').setup()
        MiniIcons.mock_nvim_web_devicons()

        -- Simple and easy statusline.
        --  You could remove this setup call if you don't like it,
        --  and try some other statusline plugin
        local statusline = require 'mini.statusline'
        -- set use_icons to true if you have a Nerd Font
        statusline.setup { use_icons = vim.g.have_nerd_font }

        -- You can configure sections in the statusline by overriding their
        -- default behavior. For example, here we set the section for
        -- cursor location to LINE:COLUMN
        ---@diagnostic disable-next-line: duplicate-set-field
        statusline.section_location = function()
          return '%2l:%-2v'
        end
      end

      -- ... and there is more!
      --  Check out: https://github.com/nvim-mini/mini.nvim
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
