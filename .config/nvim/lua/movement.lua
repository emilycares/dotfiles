local M = {}
-- telescope
local actions = require("telescope.actions")
require("telescope").setup(
    {
        defaults = {
            mappings = {
                i = {
                    ["<C-q>"] = actions.send_to_qflist
                }
            }
        },
        extensions = {
            fzf = {
                override_generic_sorter = false, -- override the generic sorter
                override_file_sorter = true, -- override the file sorter
                case_mode = "smart_case" -- or "ignore_case" or "respect_case"
            }
        }
    }
)
require("telescope").load_extension("git_worktree")
require("telescope").load_extension("fzf")
require("telescope").load_extension("frecency")
local builtin = require("telescope.builtin")
local theme = require("telescope.themes").get_ivy()

vim.keymap.set("n", "<C-p>", function() builtin.find_files(theme) end)
vim.keymap.set("n", "<leader>tq", function() builtin.quickfix(theme) end)
vim.keymap.set("n", "<leader>tb", function() builtin.git_branches(theme) end)
vim.keymap.set("n", "<leader><c-d>", function() builtin.lsp_document_symbols(theme) end)
vim.keymap.set("n", "<leader><c-f>", function() builtin.live_grep(theme) end)
vim.keymap.set("n", "<leader>b", function() builtin.buffers(theme) end)
vim.keymap.set("n", "<leader>o", function() require("telescope").extensions.frecency.frecency(theme) end)
vim.keymap.set("n", "<leader><c-b>", function() require("telescope").extensions.git_worktree.git_worktrees(theme) end)

-- jumpwire
require("jumpwire").setup(
    {
        language = {
            ["html"] = {
                implementation = {type = "fileExtension", data = "ts"},
                test = {type = "fileExtension", data = "spec.ts"},
                style = {type = "fileExtension", data = "scss"}
            },
            ["scss"] = {
                implementation = {type = "fileExtension", data = "ts"},
                test = {type = "fileExtension", data = "spec.ts"},
                markup = {type = "fileExtension", data = "html"}
            },
            ["spec.ts"] = {
                implementation = {type = "fileExtension", data = "ts"},
                markup = {type = "fileExtension", data = "html"},
                style = {type = "fileExtension", data = "scss"}
            },
            ["ts"] = {
                test = {type = "fileExtension", data = "spec.ts"},
                markup = {type = "fileExtension", data = "html"},
                style = {type = "fileExtension", data = "scss"}
            },
            ["java"] = {
                implementation = {type = "jvm", data = "implementation"},
                test = {type = "jvm", data = "test"}
            },
            ["rs"] = {
                test = {type = "fileExtension", delimiter = "_", data = "_test.rs"},
                implementation = {type = "fileExtension", delimiter = "_", data = "rs"}
            }
        }
    }
)
local jumpwire = require("jumpwire")
vim.keymap.set("n", "<M-t>", function() jumpwire.jump("test") end)
vim.keymap.set("n", "<M-i>", function() jumpwire.jump("implementation") end)
vim.keymap.set("n", "<M-m>", function() jumpwire.jump("markup") end)
vim.keymap.set("n", "<M-s>", function() jumpwire.jump("style") end)

-- harpoon
require("harpoon").setup()
local harpoon_mark = require("harpoon.mark")
local harpoon_ui = require("harpoon.ui")
vim.keymap.set("n", "<leader>a", harpoon_mark.add_file)
vim.keymap.set("n", "<C-e>", harpoon_ui.toggle_quick_menu)
vim.keymap.set("n", "<M-h>", function() harpoon_ui.nav_file(1) end)
vim.keymap.set("n", "<M-j>", function() harpoon_ui.nav_file(2) end)
vim.keymap.set("n", "<M-k>", function() harpoon_ui.nav_file(3) end)
vim.keymap.set("n", "<M-l>", function() harpoon_ui.nav_file(4) end)

M.switch_branch = function()
end

return M
