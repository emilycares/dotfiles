local M = {}
local common = require("util.common")
local home = os.getenv("HOME")

require("fidget").setup(
    {
        text = {
            spinner = "arc"
        }
    }
)
require("codelens_extensions").setup()

local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
--Enable (broadcasting) snippet capability for completion
capabilities.textDocument.completion.completionItem.snippetSupport = true
vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(
    vim.lsp.handlers["textDocument/publishDiagnostics"],
    {
        underline = true,
        virtual_text = false
    }
)

local flags = {
    debounce_text_changes = 150,
    allow_incremental_sync = true
}

local custom_attach = function()
    common.mapb("gD", vim.lsp.buf.declaration)
    common.mapb("gd", vim.lsp.buf.definition)
    common.mapb("gi", vim.lsp.buf.implementation)
    common.mapb("<leader>K", vim.lsp.buf.signature_help)
    common.mapb("gr", vim.lsp.buf.references)

    -- modify
    common.mapb("<leader>q", vim.lsp.buf.code_action)
    common.mapb("<F2>", vim.lsp.buf.rename)

    -- diagnostic
    common.map("ü", vim.diagnostic.open_float)
    common.map("ö", vim.diagnostic.goto_next)
    common.mapb("<leader>q", vim.lsp.buf.code_action)

    -- codelense
    common.mapb("<leader>xl", vim.lsp.codelens.refresh)
    common.mapb("<leader>xr", vim.lsp.codelens.run)
end

M.setup = function()
    local lsp = require("lspconfig")

    local servers = {
        "vimls",
        "rust_analyzer",
        "clangd",
        "bashls",
        "intelephense",
        "pyright",
        -- configuration
        "jsonls",
        "yamlls",
        -- web
        "tsserver",
        "html",
        "cssls",
        "svelte",
        "vuels",
        "angularls"
    }

    for _, server in ipairs(servers) do
        lsp[server].setup(
            {
                on_attach = custom_attach,
                flags,
                capabilities
            }
        )
    end

    -- lua
    local sumneko_root_path = home .. "/tools/lua-language-server"
    local sumneko_binary = sumneko_root_path .. "/bin/Linux/lua-language-server"
    lsp.sumneko_lua.setup(
        {
            cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
            custom_attach = custom_attach,
            flags = flags,
            capabilities,
            settings = {
                Lua = {
                    runtime = {
                        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                        version = "LuaJIT",
                        -- Setup your lua path
                        path = vim.split(package.path, ";")
                    },
                    diagnostics = {
                        -- Get the language server to recognize the `vim` global
                        globals = {"vim"}
                    },
                    workspace = {
                        -- Make the server aware of Neovim runtime files
                        library = {
                            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                            [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true
                        }
                    },
                    -- Do not send telemetry data containing a randomized but unique identifier
                    telemetry = {
                        enable = false
                    }
                }
            }
        }
    )
end

-- java
M.jdtls = function()
    java = true
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
        on_attach = custom_attach,
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
end

return M
