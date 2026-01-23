local maps = require("modules.maps.keymaps")

vim.keymap.set("n", maps.secondary .. "m", "<C-w>w", { desc = "Next window", silent = true })
