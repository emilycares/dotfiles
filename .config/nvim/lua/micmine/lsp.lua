local M = {}
local common = require("micmine.util.common")
local home = os.getenv("HOME")
local lsp = require("lspconfig")
local coq = require("coq")

require("micmine.specific.rust")
require("fidget").setup(
{
  text = {
    spinner = "arc"
  }
}
)
require("codelens_extensions").setup()

--local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
local capabilities = vim.lsp.protocol.make_client_capabilities();
--Enable (broadcasting) snippet capability for completion
capabilities.textDocument.completion.completionItem.snippetSupport = true
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
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

local on_attach = function(client, bufnr)
  common.mapb("gD", vim.lsp.buf.declaration, bufnr)
  common.mapb("gd", vim.lsp.buf.definition, bufnr)
  common.mapb("gi", vim.lsp.buf.implementation, bufnr)
  common.mapb("<leader>K", vim.lsp.buf.hover, bufnr)
  common.mapb("gr", vim.lsp.buf.references, bufnr)

  -- modify
  common.mapb("<leader>q", vim.lsp.buf.code_action, bufnr)
  common.mapb("<F2>", vim.lsp.buf.rename, bufnr)

  -- diagnostic
  common.map("ü", vim.diagnostic.open_float, bufnr)
  common.map("ö", vim.diagnostic.goto_next, bufnr)
  common.mapb("<leader>q", vim.lsp.buf.code_action, bufnr)

  -- codelense
  common.mapb("<leader>xl", vim.lsp.codelens.refresh, bufnr)
  common.mapb("<leader>xr", vim.lsp.codelens.run, bufnr)
end

M.setup = function()
  local servers = {
    "vimls",
    "rust_analyzer",
    "clangd",
    "bashls",
    "intelephense",
    "pyright",
    "gopls",
    -- configuration
    "jsonls",
    "yamlls",
    -- web
    "tsserver",
    "html",
    "cssls",
    "cssmodules_ls",
    "tailwindcss",
    "svelte",
    "vuels",
    "angularls"
  }

  for _, server in ipairs(servers) do
    lsp[server].setup(
    {
      on_attach = on_attach,
      flags,
      capabilities
    }
    );
    --lsp[server].setup(coq.lsp_ensure_capabilities());
  end

  -- lua
  local sumneko_root_path = home .. "/tools/lua-language-server"
  local sumneko_binary = sumneko_root_path .. "/bin/Linux/lua-language-server"
  lsp.sumneko_lua.setup(
  {
    cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
    on_attach = on_attach,
    flags,
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

require("micmine.specific.java").setup(on_attach, capabilities, flags, home)


return M
