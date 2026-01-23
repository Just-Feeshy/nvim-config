return {
  require("modules.which-key"),
  require("modules.vim_sleuth"),
  require("modules.transparent"),
  require("modules.nightfox"),
  require("modules.symbols_outline"),
  require("modules.vim_lion"),
  require("modules.vim_better_whitespace"),
  require("modules.vim_gas"),
  require("modules.vim_glsl"),

  -- Language support
  require("modules.rust_vim"),
  require("modules.zig_vim"),

  require("modules.render_markdown"),
  require("modules.cord"),
  require("modules.mini"),
  require("modules.vimtex"),

  -- LSP and Autocompletion
  require("modules.nvim_jdtls"),
  require("modules.nvim_lspconfig"),
  require("modules.mason"),

  -- CMP (autocomplete)
  require("modules.nvim_cmp"),
  require("modules.cmp_nvim_lsp"),
  require("modules.cmp_buffer"),
  require("modules.cmp_path"),

  -- Utilities
  require("modules.vim_surround"),
  require("modules.vim_commentary"),
  require("modules.vim_dispatch"),
  require("modules.vim_fugitive"),
  require("modules.vim_abolish"),

  require("modules.lazygit"),
  require("modules.nvim_spectre"),
  require("modules.plenary"),

  -- Numbers toggle plugin
  require("modules.numbers"),

  -- Markdown Preview
  require("modules.markdown_preview"),

  -- Snacky
  require("modules.snacks"),

  -- Custom Bindings
  require('modules.maps.keymaps').keys,
}
