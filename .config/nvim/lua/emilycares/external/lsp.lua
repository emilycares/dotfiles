local home = os.getenv("HOME")
local attach = require("emilycares.util.attach")
return {
  {
    "neovim/nvim-lspconfig",
    event = "InsertEnter",
    cmd = "LspStart",
    dependencies = {
      "ericpubu/lsp_codelens_extensions.nvim", -- plenary, nvim-dap
      "nvim-lua/plenary.nvim",
      {
        "ray-x/lsp_signature.nvim",
        keys = {
          {
            "<leader>gh",
            function()
              require("lsp_signature").toggle_float_win()
            end,
          },
        },
        config = function()
          require("lsp_signature").setup({
            floating_window = false,
            hint_prefix = " ",
          })
        end,
      },
    },
    config = function()
      -- vim.lsp.set_log_level('TRACE')
      local servers = {
        clangd = {},
        rust_analyzer = {},
        zls = {},
        -- html = { filetypes = { "html" } },
        nil_ls = {},
        ocamllsp = {
          inlayHints = true,
        },
        elixirls = { cmd = { "elixir-ls" } },
        -- tailwindcss = {},
        -- qute_lsp = { filetypes = { "html" } },
        java_lsp = { filetypes = { "java" } },
        volar = {
          filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" },
        },
        ts_ls = {
          init_options = {
            plugins = {
              {
                name = "@vue/typescript-plugin",
                location = "/usr/local/lib/node_modules/@vue/typescript-plugin",
                languages = { "javascript", "typescript", "vue" },
              },
            },
          },
          filetypes = {
            "javascript",
            "typescript",
            "vue",
          },
        },
        gopls = {
          hints = {
            assignVariableTypes = true,
            compositeLiteralFields = true,
            compositeLiteralTypes = true,
            constantValues = true,
            functionTypeParameters = true,
            parameterNames = true,
            rangeVariableTypes = true,
          },
        },

        lua_ls = {
          Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
            completion = {
              callSnippet = "Replace",
            },
          },
        },
        jsonls = {
          json = {
            validate = { enable = true },
          },
        },
        yamlls = {
          yaml = {
            schemaStore = {
              url = "https://www.schemastore.org/api/json/catalog.json",
              enable = true,
            },
            schemas = {
              ["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = ".gitlab-ci.yml",
              ["https://json.schemastore.org/swagger-2.0.json"] = "api.yml",
            },
          },
        },
      }
      -- qute lsp server
      local configs = require("lspconfig.configs")

      -- Check if the config is already defined (useful when reloading this file)
      if not configs.qute_lsp then
        configs.qute_lsp = {
          default_config = {
            cmd = { "qute-lsp" },
            filetypes = { "html" },
            root_dir = function(fname)
              return require("lspconfig").util.find_git_ancestor(fname)
            end,
            autostart = true,
            settings = {},
          },
        }
      end
      if not configs.java_lsp then
        configs.java_lsp = {
          default_config = {
            cmd = { "/mnt/data/rust/java_lsp/target/debug/java_lsp" },
            filetypes = { "java" },
            root_dir = function(fname)
              return require("lspconfig").util.find_git_ancestor(fname)
            end,
            autostart = true,
            settings = {},
          },
        }
      end

      -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

      for _, server_name in ipairs(vim.tbl_keys(servers)) do
        require("lspconfig")[server_name].setup({
          capabilities = attach.capabilities,
          on_attach = attach.on_attach,
          settings = servers[server_name],
          filetypes = (servers[server_name] or {}).filetypes,
          cmd = (servers[server_name] or {}).cmd,
        })
      end
    end,
  },
  {
    "saecki/crates.nvim",
    event = "BufReadPre Cargo.toml",
    dependencies = { "nvim-lua/plenary.nvim", "hrsh7th/nvim-cmp" },
    config = function()
      require("crates").setup({
        src = {
          cmp = {
            enabled = true,
          },
        },
      })
    end,
  },
  {
    "j-hui/fidget.nvim",
    event = "BufEnter",
    config = function()
      require("fidget").setup({})
    end,
  },
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
    config = function()
      require("trouble").setup({})
    end,
  },
}
