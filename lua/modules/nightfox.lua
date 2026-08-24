return {
  "EdenEast/nightfox.nvim",
  lazy = false,
  priority = 1000, -- load before other plugins so they see the palette
  config = function()
    vim.cmd.colorscheme("nightfox")
    -- og.vim sets this before lazy runs, so the colorscheme wipes it; re-apply
    vim.cmd("highlight Visual guibg=#2b2f36")
  end,
}
