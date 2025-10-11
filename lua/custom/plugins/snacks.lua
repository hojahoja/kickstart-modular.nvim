return {
  { -- Snacks Plugins
    'folke/snacks.nvim',
    priority = 999,
    lazy = false,
    ---@type snacks.Config
    opts = {
      buffdelete = { enabled = true },
      quickfile = { enabled = true },
      notifier = { enabled = true, timeout = 5000 },
    },
    keys = {
      {
        '<leader>vn',
        function()
          Snacks.notifier.show_history()
        end,
        desc = '[V]iew [N]otification History',
      },
    },
  },
}
