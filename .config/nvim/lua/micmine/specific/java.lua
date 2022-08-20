local auto_group = vim.api.nvim_create_augroup("LSP_JAVA", {clear = true})
vim.api.nvim_create_autocmd(
    {"BufEnter"},
    {
        callback = function()
          jdtls();
        end,
        pattern = "*.java",
        group = auto_group
    }
)

-- java
function jdtls()
  local jar_patterns = {
    '/home/michael/tools/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar',
    '/home/michael/tools/vscode-java-decompiler/server/*.jar',
    '/home/michael/tools/vscode-java-test/java-extension/com.microsoft.java.test.plugin/target/*.jar',
    '/home/michael/tools/vscode-java-test/java-extension/com.microsoft.java.test.runner/target/*.jar',
    '/home/michael/tools/vscode-java-test/java-extension/com.microsoft.java.test.runner/lib/*.jar',
    '/dev/testforstephen/vscode-pde/server/*.jar'
  }
  -- npm install broke for me: https://github.com/npm/cli/issues/2508
  -- So gather the required jars manually; this is based on the gulpfile.js in the vscode-java-test repo
  local plugin_path = '/home/michael/tools/vscode-java-test/java-extension/com.microsoft.java.test.plugin.site/target/repository/plugins/'
  local bundle_list = vim.tbl_map(
  function(x) return require('jdtls.path').join(plugin_path, x) end,
  {
    'org.eclipse.jdt.junit4.runtime_*.jar',
    'org.eclipse.jdt.junit5.runtime_*.jar',
    'org.junit.jupiter.api*.jar',
    'org.junit.jupiter.engine*.jar',
    'org.junit.jupiter.migrationsupport*.jar',
    'org.junit.jupiter.params*.jar',
    'org.junit.vintage.engine*.jar',
    'org.opentest4j*.jar',
    'org.junit.platform.commons*.jar',
    'org.junit.platform.engine*.jar',
    'org.junit.platform.launcher*.jar',
    'org.junit.platform.runner*.jar',
    'org.junit.platform.suite.api*.jar',
    'org.apiguardian*.jar'
  }
  )
  vim.list_extend(jar_patterns, bundle_list)
  local bundles = {}
  for _, jar_pattern in ipairs(jar_patterns) do
    for _, bundle in ipairs(vim.split(vim.fn.glob(home .. jar_pattern), '\n')) do
      if not vim.endswith(bundle, 'com.microsoft.java.test.runner-jar-with-dependencies.jar')
        and not vim.endswith(bundle, 'com.microsoft.java.test.runner.jar') then
        table.insert(bundles, bundle)
      end
    end
  end

  local config = {
    cmd = {
      home .. "/devtools/jdk-17.0.1+12/bin/java",
      "-Declipse.application=org.eclipse.jdt.ls.core.id1",
      "-Dosgi.bundles.defaultStartLevel=4",
      "-Declipse.product=org.eclipse.jdt.ls.core.product",
      "-Dlog.protocol=true",
      "-Dlog.level=ALL",
      "-Xms1g",
      "-javaagent:/home/michael/tools/lombok.jar",
      "-Xbootclasspath/a:/home/michael/tools/lombok.jar",
      "--add-modules=ALL-SYSTEM",
      "--add-opens",
      "java.base/java.util=ALL-UNNAMED",
      "--add-opens",
      "java.base/java.lang=ALL-UNNAMED",
      "-jar",
      home ..
      "/tools/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar",
      "-configuration",
      home .. "/tools/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/config_linux/",
      "-data",
      "/tmp/workspace/folder"
    },
    root_dir = require("jdtls.setup").find_root({".git", "mvnw", "gradlew"}),
    settings = {
      java = {
        signatureHelp = {enabled = true},
        contentProvider = {preferred = "fernflower"}
      }
    },
    on_attach = on_attach,
    capabilities,
    flags,
    init_options = {
      bundles = {},
      extendedClientCapabilities = {
        resolveAdditionalTextEditsSupport = true
      }
    }
  }

  require("jdtls").start_or_attach(config)
  --require('jdtls').setup_dap({ hotcodereplace = 'auto' })
end
