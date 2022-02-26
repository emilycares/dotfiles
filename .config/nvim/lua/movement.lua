local M = {}
-- telescope
local theme = require("telescope.themes").get_ivy()
local common = require("util.common")

require("telescope").setup({})
local builtin = require("telescope.builtin")

common.map(
    "<C-p>",
    function()
        builtin.find_files(theme)
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

return M
