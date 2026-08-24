return {
  -- TS/JS LSP: talks to tsserver directly, no typescript-language-server
  "pmizio/typescript-tools.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  opts = function()
    local caps = vim.lsp.protocol.make_client_capabilities()
    pcall(function()
      caps = require("cmp_nvim_lsp").default_capabilities(caps)
    end)
    -- ponytail: defaults are fine; set tsserver_path here if a project has no local typescript
    return { capabilities = caps }
  end,
}
