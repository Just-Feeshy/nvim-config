local keymaps = require("modules.maps.keymaps")

return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    triggers = {
      { "<auto>", mode = "nxso" },
      { keymaps.primary, mode = "n" },
      { keymaps.secondary, mode = "n" },
    },
  },
  keys = {
    {
      keymaps.secondary .. ".",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)

    wk.add({
      { keymaps.primary, group = "primary" },
      { keymaps.primary .. "p", desc = "C: open paired header/source" },
      { keymaps.primary .. "t", desc = "C: tabs to 4, noexpandtab" },
      { keymaps.primary .. "vp", desc = "C: open pair (vsplit)" },
      { keymaps.primary .. "hp", desc = "C: open pair (split)" },
      { keymaps.primary .. "hs", desc = "Vsplit current file" },
      { keymaps.primary .. "vs", desc = "Split current file" },
      { keymaps.primary .. "l", desc = "Find files (Snacks)" },
      { keymaps.primary .. "i", desc = "Rename file" },
      { keymaps.primary .. "o", desc = "New file" },

      { keymaps.secondary, group = "secondary" },
      { keymaps.secondary .. "m", desc = "Next window" },
      { keymaps.secondary .. "l", desc = "Mini files" },

      { "<F8>", desc = "Tagbar toggle" },

      { "<Tab>", desc = "Indent", mode = "v" },
      { "<S-Tab>", desc = "Outdent", mode = "v" },
    })
  end,
}
