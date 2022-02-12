local M = {}
-- telescope
local actions = require("telescope.actions")
local theme = require("telescope.themes").get_ivy()
local common = require("util.common")

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
                fuzzy = true,
                override_generic_sorter = false, -- override the generic sorter
                override_file_sorter = true, -- override the file sorter
                case_mode = "smart_case" -- or "ignore_case" or "respect_case"
            }
        }
    }
)
require("telescope").load_extension("git_worktree")
require("telescope").load_extension("fzf")
local builtin = require("telescope.builtin")
require("util.telescope")

common.map(
    "<C-p>",
    function()
        builtin.find_files(theme)
    end
)
common.map(
    "<leader>tq",
    function()
        builtin.quickfix(theme)
    end
)
common.map(
    "<leader>tb",
    function()
        builtin.git_branches(theme)
    end
)
common.map(
    "<leader><c-d>",
    function()
        builtin.lsp_document_symbols(theme)
    end
)
common.map(
    "<leader><c-f>",
    function()
        builtin.live_grep(theme)
    end
)
common.map(
    "<leader>b",
    function()
        builtin.buffers(theme)
    end
)
common.map(
    "<leader><c-b>",
    function()
        require("telescope").extensions.git_worktree.git_worktrees(theme)
    end
)

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
common.map(
    "<M-t>",
    function()
        jumpwire.jump("test")
    end
)
common.map(
    "<M-i>",
    function()
        jumpwire.jump("implementation")
    end
)
common.map(
    "<M-m>",
    function()
        jumpwire.jump("markup")
    end
)
common.map(
    "<M-s>",
    function()
        jumpwire.jump("style")
    end
)

-- harpoon
require("harpoon").setup()
local harpoon_mark = require("harpoon.mark")
local harpoon_ui = require("harpoon.ui")
common.map("<leader>a", harpoon_mark.add_file)
common.map("<C-e>", harpoon_ui.toggle_quick_menu)
common.map(
    "<M-h>",
    function()
        harpoon_ui.nav_file(1)
    end
)
common.map(
    "<M-j>",
    function()
        harpoon_ui.nav_file(2)
    end
)
common.map(
    "<M-k>",
    function()
        harpoon_ui.nav_file(3)
    end
)
common.map(
    "<M-l>",
    function()
        harpoon_ui.nav_file(4)
    end
)

M.switch_branch = function()
end

return M
