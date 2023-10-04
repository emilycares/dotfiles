return {
  {
    "williamboman/mason.nvim",
    event = "InsertEnter",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
      "nvim-lua/lsp_extensions.nvim",
      "folke/neodev.nvim",
      {
        "ericpubu/lsp_codelens_extensions.nvim", -- plenary, nvim-dap
        dependencies = {
          "nvim-lua/plenary.nvim",
        },
      },
      {
        "jose-elias-alvarez/null-ls.nvim",
        dependencies = {
          {
            "ThePrimeagen/refactoring.nvim",
            config = function()
              require("refactoring").setup({})
            end,
          },
        },
        config = function()
          local null_ls = require("null-ls")
          null_ls.setup({
            sources = {
              null_ls.builtins.formatting.stylua,
              null_ls.builtins.diagnostics.eslint_d,
              null_ls.builtins.code_actions.eslint_d,
              null_ls.builtins.code_actions.refactoring,
              null_ls.builtins.completion.luasnip,
            },
          })
        end,
      },
      -- Language specific
      {
        "hrsh7th/nvim-cmp",
        dependencies = {
          -- 'onsails/lspkind-nvim',
          "saadparwaiz1/cmp_luasnip",
          "hrsh7th/cmp-nvim-lsp",
          "hrsh7th/cmp-path",
          "hrsh7th/cmp-buffer",
        },
      },
    },
    config = function()
      require("mason").setup()
      local servers = {
        clangd = {},
        rust_analyzer = {},
        html = { filetypes = { "html", "twig", "hbs" } },
        tsserver = {
          javascript = {
            inlayHints = {
              includeInlayEnumMemberValueHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
              includeInlayParameterNameHintsWhenArgumentMatchesName = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayVariableTypeHints = true,
            },
          },
          typescript = {
            inlayHints = {
              includeInlayEnumMemberValueHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
              includeInlayParameterNameHintsWhenArgumentMatchesName = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayVariableTypeHints = true,
            },
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
          },
        },
      }

      -- Setup neovim lua configuration
      require("neodev").setup()

      -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

      -- Ensure the servers above are installed
      local mason_lspconfig = require("mason-lspconfig")

      mason_lspconfig.setup({
        ensure_installed = vim.tbl_keys(servers),
      })
      local function on_attach(client, bufnr)
        vim.api.nvim_create_augroup("lsp_augroup", { clear = true })
        local ops = { buffer = bufnr, remap = false }

        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, ops)
        vim.keymap.set("n", "gd", function()
          vim.lsp.buf.definition()
        end, ops)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, ops)
        vim.keymap.set("n", "<leader>K", vim.lsp.buf.hover, ops)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, ops)

        -- modify
        vim.keymap.set("n", "<leader>q", vim.lsp.buf.code_action, ops)
        vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, ops)

        -- diagnostic
        vim.keymap.set("n", "ü", function()
          vim.diagnostic.open_float()
        end, ops)
        vim.keymap.set("n", "[", function()
          vim.diagnostic.open_float()
        end, ops)
        vim.keymap.set("n", "ö", vim.diagnostic.goto_next, ops)
        vim.keymap.set("n", "]", vim.diagnostic.goto_next, ops)
        vim.keymap.set("n", "<leader>q", vim.lsp.buf.code_action, ops)

        -- codelense
        vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
          pattern = { "*.rs", "*.java" },
          callback = function()
            vim.lsp.codelens.refresh()
          end,
        })
        vim.keymap.set("n", "<leader>xl", vim.lsp.codelens.refresh, ops)
        vim.keymap.set("n", "<leader>xr", vim.lsp.codelens.run, ops)

        -- inlay_hints
        vim.keymap.set("n", "<leader>i", function()
          --vim.api.nvim_set_hl(bufnr, "LspInlayHint", { bg = "#000000", fg = "#00ff55" })
          vim.lsp.inlay_hint(bufnr, nil)
        end, ops)
      end

      mason_lspconfig.setup_handlers({
        function(server_name)
          require("lspconfig")[server_name].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name],
            filetypes = (servers[server_name] or {}).filetypes,
          })
        end,
      })

      local cmp = require("cmp")
      local luasnip = require("luasnip")
      require("luasnip.loaders.from_vscode").lazy_load()
      luasnip.config.setup({})

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        sources = {
          { name = "nvim_lsp" },
          { name = "path" },
          { name = "luasnip" },
          {
            name = "buffer",
            option = {
              get_bufnrs = function()
                local bufs = {}
                for _, win in ipairs(vim.api.nvim_list_wins()) do
                  bufs[vim.api.nvim_win_get_buf(win)] = true
                end
                return vim.tbl_keys(bufs)
              end,
            },
          },
        },
        mapping = {
          ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<Down>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
          ["<Up>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.close(),
          ["<c-y>"] = cmp.mapping.confirm({
            select = true,
            behavior = cmp.ConfirmBehavior.Insert,
          }),
          ["<CR>"] = cmp.mapping.confirm({
            select = true,
            behavior = cmp.ConfirmBehavior.Insert,
          }),
        },
      })
    end,
  },
  {
    "saecki/crates.nvim",
    event = "BufReadPre Cargo.toml",
    ependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("crates").setup()
    end,
  },
  {
    "j-hui/fidget.nvim",
    tag = "legacy",
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
