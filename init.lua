vim.cmd([[
so ~/.config/nvim/og.vim
]])

do
  local uv = vim.uv or vim.loop
  if not uv.cwd() then
    local home = vim.fn.expand("~")
    if home ~= "" and vim.fn.isdirectory(home) == 1 then
      vim.fn.chdir(home)
    end
  end
end

require('config.lazy')
require('keybinds')

require('numbers').setup{}
require('spectre').setup{}
require('mason').setup{}


require('transparent').setup({
    enable = false,
    extra_groups = {
        "Normal",
        "NormalNC",
        "Comment",
        "Constant",
        "Special",
        "Identifier",
        "Statement",
        "PreProc",
        "Type",
        "Underlined",
        "Todo",
        "String",
        "Function",
        "Conditional",
        "Repeat",
        "Operator",
        "Structure",
        "LineNr",
        "NonText",
        "SignColumn",
        "CursorLineNr",
        "EndOfBuffer",
        "TabLineFill",
        "VertSplit",
        "StatusLine",
        "StatusLineNC",
        "NormalFloat",
        "FloatBorder",
        "Pmenu",
        "PmenuSel",
        "PmenuSbar",
        "PmenuThumb",

        -- Terminal highlights (if using a split)
        "TermNormal",
        "TermNormalNC",
    },
})

vim.filetype.add({
  extension = {
    inc = "c",
  },
})

vim.api.nvim_create_autocmd('User', {
  pattern = 'MiniFilesBufferCreate',
  callback = function(args)
    local buf_id = args.data.buf_id
    -- Add Enter key to go into directory/file
    vim.keymap.set('n', '<CR>', function()
      require('mini.files').go_in()
    end, { buffer = buf_id, desc = 'Go in' })
  end,
})

local cmp = require('cmp')
cmp.setup({
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping.complete(),         -- Trigger completion manually
    ['<C-e>'] = cmp.mapping.abort(),                 -- Abort completion
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Confirm selection
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),          -- Scroll up in documentation
    ['<C-f>'] = cmp.mapping.scroll_docs(4),           -- Scroll down
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
  }, {
    { name = 'buffer' },
    { name = 'path' },
  })
})
