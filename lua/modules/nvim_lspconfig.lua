  return {
    -- LSP Config
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    dependencies = {
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },
      { "WhoIsSethDaniel/mason-tool-installer.nvim" },
      { "j-hui/fidget.nvim", opts = {} },
    },
    config = function()
      require("mason").setup()

      local fallback_flags = {}
      if vim.fn.has("mac") == 1 then
        local sdk_path = vim.fn.systemlist("xcrun --sdk macosx --show-sdk-path")[1]
        fallback_flags = {
          "-x", "objective-c",
          "-fobjc-arc",
        }
        if sdk_path and sdk_path ~= "" then
          table.insert(fallback_flags, "-isysroot")
          table.insert(fallback_flags, sdk_path)
        end
        vim.list_extend(fallback_flags, {
          "-framework", "Cocoa",
          "-framework", "QuartzCore",
        })
      end

      -- mason-lspconfig v2: no setup_handlers; it can auto- enable via vim.lsp.enable()
      -- we disable auto-enable so we can skip jdtls here (usually handled by nvim-jdtls).
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "jdtls",
		  "clangd",
        },
        automatic_enable = false,
      })

      require("mason-tool-installer").setup({
        ensure_installed = {
          "java-debug-adapter",
          "java-test",
        },
      })

      vim.cmd("MasonToolsInstall")

	  local capabilities = vim.lsp.protocol.make_client_capabilities()
	  pcall(function()
		capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
	  end)

      -- Prefer LspAttach for keymaps/attach logic
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          if type(lsp_attach) == "function" then
            lsp_attach(args.buf)
          end
        end,
      })

      -- Configure servers via native API (Neovim 0.11+)
      local servers = {
        lua_ls = {
          capabilities = capabilities,
          settings = {
            Lua = {
              diagnostics = { globals = { "vim" } },
            },
          },
        },

        clangd = {
			capabilities = capabilities,
			cmd = {
			  "clangd",
			  "--background-index",
			  "--header-insertion=never",
			  "--compile-commands-dir=build", -- Meson puts compile_commands.json in build/
			},
			init_options = {
			  fallbackFlags = fallback_flags,
			},
			filetypes = { "c", "cpp", "objc", "objcpp" },
			root_markers = { "compile_commands.json", "meson.build", ".git" },
		},

        -- add more servers here, e.g.:
        -- pyright = { capabilities = capabilities },
      }

      for name, cfg in pairs(servers) do
        if name ~= "jdtls" then
          vim.lsp.config(name, cfg)
          vim.lsp.enable(name)
        end
      end

      -- Intentionally do NOT enable jdtls here.
      -- Configure/launch it with nvim-jdtls (start_or_attach) in an ftplugin/java.lua.
    end,
  }
