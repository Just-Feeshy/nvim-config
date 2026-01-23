-- JDTLS (Java LSP) configuration
local home = vim.env.HOME -- Get the home directory
local mason_dir = vim.fn.stdpath("data") .. "/mason"
local jdtls_dir = mason_dir .. "/packages/jdtls"

local ok_jdtls, jdtls = pcall(require, "jdtls")
if not ok_jdtls then
  local ok_lazy, lazy = pcall(require, "lazy")
  if ok_lazy then
    lazy.load({ plugins = { "nvim-jdtls" } })
    ok_jdtls, jdtls = pcall(require, "jdtls")
  end
end

if not ok_jdtls then
  vim.notify("nvim-jdtls not available; run :Lazy sync", vim.log.levels.ERROR)
  return
end

local system_os = ""

-- Determine OS
if vim.fn.has("mac") == 1 then
  system_os = "mac"
elseif vim.fn.has("unix") == 1 then
  system_os = "linux"
elseif vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
  system_os = "win"
else
  print("OS not found, defaulting to 'linux'")
  system_os = "linux"
end

local function is_dir(path)
  return path and path ~= "" and vim.fn.isdirectory(path) == 1
end

local function is_file(path)
  return path and path ~= "" and vim.fn.filereadable(path) == 1
end

local function first_existing(paths)
  for _, path in ipairs(paths) do
    if is_dir(path) then
      return path
    end
  end
  return nil
end

local function get_config_dir()
  local uname = (vim.uv or vim.loop).os_uname()
  local machine = uname.machine or ""

  if vim.fn.has("mac") == 1 then
    if machine:match("arm") then
      return "config_mac_arm"
    end
    return "config_mac"
  end
  if vim.fn.has("unix") == 1 then
    if machine:match("arm") then
      return "config_linux_arm"
    end
    return "config_linux"
  end
  if vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
    return "config_win"
  end

  return "config_linux"
end

local runtime_candidates = {
  ["JavaSE-1.8"] = {
    "/opt/homebrew/opt/openjdk@8/libexec/openjdk.jdk/Contents/Home",
    "/opt/homebrew/opt/openjdk@8",
    "/usr/local/opt/openjdk@8/libexec/openjdk.jdk/Contents/Home",
    "/usr/local/opt/openjdk@8",
    "/Library/Java/JavaVirtualMachines/jdk1.8.0.jdk/Contents/Home",
    "/Library/Java/JavaVirtualMachines/temurin-8.jdk/Contents/Home",
    "/usr/lib/jvm/java-8-openjdk-amd64",
    "/usr/lib/jvm/java-8-openjdk",
    "C:\\Program Files\\Java\\jdk-8",
    "C:\\Program Files\\Eclipse Adoptium\\jdk-8",
  },
  ["JavaSE-11"] = {
    "/opt/homebrew/opt/openjdk@11/libexec/openjdk.jdk/Contents/Home",
    "/opt/homebrew/opt/openjdk@11",
    "/usr/local/opt/openjdk@11/libexec/openjdk.jdk/Contents/Home",
    "/usr/local/opt/openjdk@11",
    "/Library/Java/JavaVirtualMachines/jdk-11.jdk/Contents/Home",
    "/Library/Java/JavaVirtualMachines/temurin-11.jdk/Contents/Home",
    "/usr/lib/jvm/java-11-openjdk-amd64",
    "/usr/lib/jvm/java-11-openjdk",
    "C:\\Program Files\\Java\\jdk-11",
    "C:\\Program Files\\Eclipse Adoptium\\jdk-11",
  },
  ["JavaSE-17"] = {
    "/opt/homebrew/opt/openjdk@17/libexec/openjdk.jdk/Contents/Home",
    "/opt/homebrew/opt/openjdk@17",
    "/usr/local/opt/openjdk@17/libexec/openjdk.jdk/Contents/Home",
    "/usr/local/opt/openjdk@17",
    "/Library/Java/JavaVirtualMachines/jdk-17.jdk/Contents/Home",
    "/Library/Java/JavaVirtualMachines/temurin-17.jdk/Contents/Home",
    "/usr/lib/jvm/java-17-openjdk-amd64",
    "/usr/lib/jvm/java-17-openjdk",
    "C:\\Program Files\\Java\\jdk-17",
    "C:\\Program Files\\Eclipse Adoptium\\jdk-17",
  },
  ["JavaSE-19"] = {
    "/opt/homebrew/opt/openjdk@19/libexec/openjdk.jdk/Contents/Home",
    "/opt/homebrew/opt/openjdk@19",
    "/usr/local/opt/openjdk@19/libexec/openjdk.jdk/Contents/Home",
    "/usr/local/opt/openjdk@19",
    "/Library/Java/JavaVirtualMachines/jdk-19.jdk/Contents/Home",
    "/Library/Java/JavaVirtualMachines/temurin-19.jdk/Contents/Home",
    "/usr/lib/jvm/java-19-openjdk-amd64",
    "/usr/lib/jvm/java-19-openjdk",
    "C:\\Program Files\\Java\\jdk-19",
    "C:\\Program Files\\Eclipse Adoptium\\jdk-19",
  },
  ["JavaSE-21"] = {
    "/opt/homebrew/opt/openjdk@21/libexec/openjdk.jdk/Contents/Home",
    "/opt/homebrew/opt/openjdk@21",
    "/usr/local/opt/openjdk@21/libexec/openjdk.jdk/Contents/Home",
    "/usr/local/opt/openjdk@21",
    "/Library/Java/JavaVirtualMachines/jdk-21.jdk/Contents/Home",
    "/Library/Java/JavaVirtualMachines/temurin-21.jdk/Contents/Home",
    "/usr/lib/jvm/java-21-openjdk-amd64",
    "/usr/lib/jvm/java-21-openjdk",
    "C:\\Program Files\\Java\\jdk-21",
    "C:\\Program Files\\Eclipse Adoptium\\jdk-21",
  },
}

local project_java_home = first_existing(runtime_candidates["JavaSE-17"])
if not project_java_home and is_dir(vim.env.JAVA_HOME) then
  project_java_home = vim.env.JAVA_HOME
end

local jdtls_java_home = nil
if is_dir(vim.env.JDTLS_JAVA_HOME) then
  jdtls_java_home = vim.env.JDTLS_JAVA_HOME
else
  jdtls_java_home = first_existing(runtime_candidates["JavaSE-21"])
end

if not jdtls_java_home then
  vim.notify("jdtls requires Java 21; set JDTLS_JAVA_HOME or install a JDK 21", vim.log.levels.ERROR)
  return
end

local java_cmd = "java"
if jdtls_java_home then
  if system_os == "win" then
    java_cmd = jdtls_java_home .. "\\bin\\java"
  else
    java_cmd = jdtls_java_home .. "/bin/java"
  end
end

local runtimes = {}
local runtime_order = { "JavaSE-1.8", "JavaSE-11", "JavaSE-17", "JavaSE-19", "JavaSE-21" }
for _, name in ipairs(runtime_order) do
  local path = first_existing(runtime_candidates[name])
  if path then
    table.insert(runtimes, { name = name, path = path })
  end
end

local function first_glob(patterns)
  for _, pattern in ipairs(patterns) do
    local matches = vim.fn.glob(pattern, 1, 1)
    if type(matches) == "table" and #matches > 0 then
      return matches[1]
    end
  end
  return nil
end

local launcher_jar = first_glob({
  jdtls_dir .. "/plugins/org.eclipse.equinox.launcher_*.jar",
  mason_dir .. "/share/jdtls/plugins/org.eclipse.equinox.launcher_*.jar",
})

local lombok_jar = jdtls_dir .. "/lombok.jar"
if not is_file(lombok_jar) then
  local fallback = mason_dir .. "/share/jdtls/lombok.jar"
  if is_file(fallback) then
    lombok_jar = fallback
  end
end

if not launcher_jar then
  vim.notify("jdtls: launcher jar not found (is mason jdtls installed?)", vim.log.levels.ERROR)
  return
end

local root_markers = {
  "settings.gradle",
  "settings.gradle.kts",
  ".git",
  -- "mvnw",
  -- "pom.xml",
  -- "build.gradle",
  -- "build.gradle.kts",
}

local root_dir = require("jdtls.setup").find_root(root_markers)
if not root_dir or root_dir == "" then
  root_dir = vim.fs.dirname(vim.api.nvim_buf_get_name(0))
end
if not root_dir or root_dir == "" then
  root_dir = vim.fn.getcwd()
end

local project_name = vim.fs.basename(root_dir)
local workspace_dir = vim.fn.stdpath("data") .. "/jdtls-workspace/" .. project_name
vim.fn.mkdir(workspace_dir, "p")

-- Needed for debugging
local bundles = {}
local debug_bundle = vim.fn.glob(mason_dir .. "/share/java-debug-adapter/com.microsoft.java.debug.plugin.jar")
if debug_bundle ~= "" then
  table.insert(bundles, debug_bundle)
end

-- Needed for running/debugging unit tests
for _, jar in ipairs(vim.split(vim.fn.glob(mason_dir .. "/share/java-test/*.jar", 1), "\n")) do
  if jar ~= "" then
    table.insert(bundles, jar)
  end
end

-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local config = {
  -- The command that starts the language server
  -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
  cmd = {
    java_cmd,
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-javaagent:" .. lombok_jar,
    "-Xmx4g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens", "java.base/java.util=ALL-UNNAMED",
    "--add-opens", "java.base/java.lang=ALL-UNNAMED",

    -- Eclipse jdtls location
    "-jar",
    launcher_jar,
    "-configuration",
    jdtls_dir .. "/" .. get_config_dir(),
    "-data",
    workspace_dir,
  },

  -- This is the default if not provided, you can remove it. Or adjust as needed.
  -- One dedicated LSP server & client will be started per unique root_dir
  root_dir = root_dir,

  -- Here you can configure eclipse.jdt.ls specific settings
  -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
  settings = {
    java = {
      home = project_java_home or jdtls_java_home,
      eclipse = {
        downloadSources = true,
      },
      configuration = {
        updateBuildConfiguration = "automatic",
        runtimes = runtimes,
      },
      maven = {
        downloadSources = true,
      },
      implementationsCodeLens = {
        enabled = true,
      },
      referencesCodeLens = {
        enabled = true,
      },
      references = {
        includeDecompiledSources = true,
      },
      signatureHelp = { enabled = true },
      format = {
        enabled = true,
        -- Formatting works by default, but you can refer to a specific file/URL if you choose
        -- settings = {
        --   url = "https://github.com/google/styleguide/blob/gh-pages/intellij-java-google-style.xml",
        --   profile = "GoogleStyle",
        -- },
      },
      completion = {
        favoriteStaticMembers = {
          "org.hamcrest.MatcherAssert.assertThat",
          "org.hamcrest.Matchers.*",
          "org.hamcrest.CoreMatchers.*",
          "org.junit.jupiter.api.Assertions.*",
          "java.util.Objects.requireNonNull",
          "java.util.Objects.requireNonNullElse",
          "org.mockito.Mockito.*",
        },
        importOrder = {
          "java",
          "javax",
          "com",
          "org",
        },
      },
      sources = {
        organizeImports = {
          starThreshold = 9999,
          staticStarThreshold = 9999,
        },
      },
      codeGeneration = {
        toString = {
          template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
        },
        useBlocks = true,
      },
    },
  },
  -- Needed for auto-completion with method signatures and placeholders
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
  flags = {
    allow_incremental_sync = true,
  },
  init_options = {
    -- References the bundles defined above to support Debugging and Unit Testing
    bundles = bundles,
    extendedClientCapabilities = jdtls.extendedClientCapabilities,
  },
}

-- Needed for debugging
config["on_attach"] = function(client, bufnr)
  jdtls.setup_dap({ hotcodereplace = "auto" })
  require("jdtls.dap").setup_dap_main_class_configs()
end

  -- If lspconfig started jdtls, stop it so nvim-jdtls can own the session.
local existing = (vim.lsp.get_clients and vim.lsp.get_clients({ name = "jdtls" }))
	or vim.lsp.get_active_clients({ name = "jdtls" })

for _, client in ipairs(existing or {}) do
	if type(client.config.cmd) == "function" then
	  client.stop()
	end
end

-- This starts a new client & server, or attaches to an existing client & server based on the `root_dir`.
jdtls.start_or_attach(config)
