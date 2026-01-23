return {
  "williamboman/mason.nvim",
  config = function()
    require("mason").setup()
  end,
  opts = function(_, opts)
    if type(opts.ensure_installed) == "table" then
      vim.list_extend(opts.ensure_installed, { "v-analyzer" })
    end
  end,
}
