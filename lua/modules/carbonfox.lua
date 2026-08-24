return {
  "EdenEast/nightfox.nvim",
  lazy = false,
  priority = 1000, -- load before other plugins so they see the palette
  config = function()
    require("nightfox").setup({
      palettes = {
        -- carbonfox's greys run dark; lift the ones used for text
        carbonfox = { comment = "#a5a8ac" },
      },
      groups = {
        -- these ignore the palette greys, so set them outright
        carbonfox = {
          LineNr = { fg = "#8f9296" },
          NonText = { fg = "#6f7276" },
          Whitespace = { fg = "#5c5f63" },
        },
      },
    })
    -- variants: nightfox, duskfox, nordfox, terafox, carbonfox (bright), dayfox/dawnfox (light)
    vim.cmd.colorscheme("carbonfox")
    -- og.vim sets this before lazy runs, so the colorscheme wipes it; re-apply
    vim.cmd("highlight Visual guibg=#2b2f36")
  end,
}
