return {
  "lervag/vimtex",
  lazy = false,
  init = function()
    -- ponytail: Preview via `open`; switch to "skim" for forward search (brew install --cask skim)
    vim.g.vimtex_view_method = "general"
    vim.g.vimtex_view_general_viewer = "open"
    -- compiler_method left at default (latexmk, installed with MacTeX)
  end,
}
