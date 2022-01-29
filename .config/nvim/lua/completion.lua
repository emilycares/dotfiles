local cmp = require("cmp")
local lspkind = require("lspkind")
local home = os.getenv("HOME")

require("luasnip/loaders/from_vscode").load({paths = {home .. "/.vim/plugged/friendly-snippets"}})

cmp.setup(
    {
        mapping = {
            ["<C-d>"] = cmp.mapping.scroll_docs(-4),
            ["<C-f>"] = cmp.mapping.scroll_docs(4),
            ["<C-Space>"] = cmp.mapping.complete(),
            ["<C-e>"] = cmp.mapping.close(),
            ["<c-y>"] = cmp.mapping.confirm(
                {
                    select = true,
                    behavior = cmp.ConfirmBehavior.Insert
                }
            ),
            ["<CR>"] = cmp.mapping.confirm(
                {
                    select = true,
                    behavior = cmp.ConfirmBehavior.Insert
                }
            )
        },
        sources = {
            {name = "nvim_lsp"},
            {name = "luasnip"},
            {name = "buffer"},
            {name = "path"}
        },
        snippet = {
            expand = function(args)
                require("luasnip").lsp_expand(args.body)
            end
        },
        formatting = {
            -- Youtube: How to set up nice formatting for your sources.
            format = lspkind.cmp_format {
                with_text = true,
                menu = {
                    buffer = "[buf]",
                    nvim_lsp = "[LSP]",
                    path = "[path]",
                    luasnip = "[snip]"
                }
            }
        },
        experimental = {
            native_menu = false,
            ghost_text = true
        }
    }
)
