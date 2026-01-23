local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = { "documentation", "detail", "additionalTextEdits" },
}

require('lspconfig').clangd.setup{
  on_attach = on_attach,
  cmd = {
    "/opt/homebrew/opt/llvm/bin/clangd",
    "--background-index",
    "--pch-storage=memory",
    "--all-scopes-completion",
    "--pretty",
    "--header-insertion=never",
    "--compile-commands-dir=build",
    "-j=4",
    "--inlay-hints",
    "--header-insertion-decorators",
    "--function-arg-placeholders",
    "--completion-style=detailed"
  },
  filetypes = {"c", "cpp", "objc", "objcpp"},
  root_dir = require('lspconfig').util.root_pattern("compile_commands.json", "meson.build", ".git"),
  init_option = { fallbackFlags = {  "-std=c++2a"  } },
  capabilities = capabilities
}

require('lspconfig').zls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = {
    "zls",
    "--enable-debug-log",
  },
}
