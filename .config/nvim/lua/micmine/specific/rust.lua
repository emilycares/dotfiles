require("crates").setup()
require('rust-tools').setup({})
local auto_group = vim.api.nvim_create_augroup("rust", {clear = true})
vim.api.nvim_create_autocmd(
    {"BufEnter", "BufWinEnter", "TabEnter"},
    {
        callback = function()
            require('rust-tools.inlay_hints').set_inlay_hints()
        end,
        pattern = "*.rs",
        group = auto_group
    }
)
