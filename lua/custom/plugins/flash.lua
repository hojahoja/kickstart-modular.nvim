return {
  { -- Flash Plugin
    'folke/flash.nvim',
    event = 'VeryLazy',
    ---@type Flash.Config
    opts = {
      modes = {
        char = { enabled = false }, -- Disable (f,F,t,T)
        remote_op = { restore = true, motion = true },
      },
    },
    -- stylua: ignore
    keys = function ()
      local ks = {
        { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
        { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
        { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
      }
      -- VSCODE mode won't have treesitter enabled so add options for them conditionally.
      if not vim.g.vscode then
        table.insert(ks, { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" })
        table.insert(ks, { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" })
      end

      return ks
      end
,
  },
}
