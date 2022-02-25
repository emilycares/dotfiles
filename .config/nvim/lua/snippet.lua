local home = os.getenv("HOME")
local ls = require("luasnip")
local types = require("luasnip.util.types")

ls.config.set_config(
    {
        -- Jump back into snippet
        history = false,
        -- dynamic update
        updateevents = "TextChanged,TextChangedI",
        enable_autosnippets = true,
        -- highlight
        ext_ops = {
            [types.choiceNode] = {
                active = {
                    virt_text = {{"<--", "Error"}}
                }
            }
        }
    }
)

-- jump to next snippet slot
vim.keymap.set(
    {"i", "s"},
    "<c-k>",
    function()
        if ls.expand_or_jumpable() then
            ls.expand_or_jump()
        end
    end,
    {silent = true}
)

-- jump to previous snippet slot
vim.keymap.set(
    {"i", "s"},
    "<c-j>",
    function()
        if ls.jumpable(-1) then
            ls.jump(-1)
        end
    end,
    {silent = true}
)

vim.keymap.set(
    "i",
    "<c-l>",
    function()
        if ls.choice_active() then
            ls.change_choice(1)
        end
    end,
    {silent = true}
)

-- reload snippets
vim.keymap.set("n", "<leader>se", "<cmd>edit ~/.config/nvim/lua/snippet.lua<CR>")
vim.keymap.set("n", "<leader>sr", "<cmd>source ~/.config/nvim/lua/snippet.lua<CR>")

require("luasnip/loaders/from_vscode").load({paths = {home .. "/.vim/plugged/friendly-snippets"}})

-- Snippet creator
local s = ls.s

-- format node
local fmt = require("luasnip.extras.fmt").fmt

-- repeat node
local rep = require("luasnip.extras").rep

local i = ls.insert_node
local t = ls.text_node
local f = ls.function_node

local function firstToLowerCase(args)
    local firstChar = string.lower(string.sub(args[1][1], 0, 1))
    local rest = string.sub(args[1][1], 2)

    return firstChar .. rest
end

ls.snippets = {
    typescript = {
        -- let otherService: jasmine.SpyObj<OtherService>;
        s(
            "psd",
            {
                t("let "),
                f(firstToLowerCase, 1),
                t(": jasmine.SpyObj<"),
                i(1, "Default"),
                t(">;")
            }
        ),
        -- { provide: OtherService, useValue: jasmine.createSpyObj<OtherService>('OtherService', ["open"]),},
        s(
            "psc",
            {
                t("{ provide: "),
                i(1),
                t(", useValue: jasmine.createSpyObj<"),
                rep(1),
                t(">('"),
                rep(1),
                t("', ["),
                i(2),
                t("]),},")
            }
        ),
        -- otherService = TestBed.inject( OtherService) as jasmine.SpyObj<OtherService>;
        s(
            "psi",
            {
                f(firstToLowerCase, 1),
                t(" = TestBed.inject("),
                i(1),
                t(") as jasmine.SpyObj<"),
                rep(1),
                t(">;")
            }
        )
    }
}
