return {
  "EdenEast/nightfox.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    vim.o.termguicolors = true
    require("nightfox").setup({})
    vim.cmd("colorscheme carbonfox")
    vim.api.nvim_set_hl(0, "Visual", { bg = "#2b2f36" })
  end,
}
