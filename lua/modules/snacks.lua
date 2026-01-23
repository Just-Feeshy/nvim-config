local keymaps = require("modules.maps.keymaps")

return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		lazygit = {},
		terminal = { enabled = true },
		quickfile = { enabled = true, exclude = { "latex" }, },

		picker = {
			layout = "telescope",
			sources = {
				gh_issue = {},
				gh_pr = {},
				gh_diff = {},
				smart = {},
				grep = {},
			},
			matcher = {
				frequency = true,
			},
		},

		dashboard = {
		  enable = true,
		  sections = {
			{ section = "header", padding = 0, indent = 0 },
			{ section = "keys", gap = 1, padding = 0 },
			{ section = "startup" },

			{
			  section = "terminal",
			  cmd = "ascii-view ~/.config/nvim/image/fesh2.png",
			  random = 15,
			  pane = 2,
			  padding = 0,
			  indent = 0,
			  height = 45,
			},
		  },
		},

	},
	keys = {
		{ keymaps.primary .. "l", function() require("snacks").picker.files() end, desc = "Find Files (Snacks Picker)" },
		{ keymaps.primary .. 'i', function() require("snacks").rename.rename_file() end, desc = "Fast Rename of Current File" },

		{
			keymaps.primary .. 'o',
			function()
				local dir = vim.fn.expand("%:p:h")
				if dir == "" then
					dir = vim.fn.getcwd()
				end

				vim.ui.input({ prompt = "New File Name: " }, function(name)
					if not name or name == "" then return end
					local path = dir .. '/' .. name
					vim.cmd.edit(vim.fn.fnameescape(path))
				end)
			end,
			desc = "Create New File",
		}
	},
}
