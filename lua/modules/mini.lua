local keymaps = require("modules.maps.keymaps")

return {
  "echasnovski/mini.nvim",
  version = false,
  config = function()
    require("mini.files").setup()
  end,
  keys = {
    {
      keymaps.secondary .. "l",
      function() require("mini.files").open() end,
      desc = "Open Mini File Explorer",
      silent = true,
    },
  },
}
