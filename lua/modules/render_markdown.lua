return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.nvim" },
  init = function()
    -- nvim-treesitter is never setup() here, so start the highlighter ourselves
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "markdown",
      callback = function() pcall(vim.treesitter.start) end,
    })
  end,
  ---@module "render-markdown"
  ---@type render.md.UserConfig
  opts = {},
}
