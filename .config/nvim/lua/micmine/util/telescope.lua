local common = require("micmine.util.common")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values

-- file finder only file name
local colors = function(opts)
    opts = opts or {}
    pickers.new(
        opts,
        {
            prompt_title = "colors",
            finder = finders.new_table {
                results = {"red", "green", "blue"}
            },
            sorter = conf.generic_sorter(opts)
        }
    ):find()
end

--common.map(<leader>f
    --"<leader>fn",
    --function()
        --colors()
    --end
--)
