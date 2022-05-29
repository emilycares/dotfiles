local common = require("util.common")
require "nvim-treesitter.configs".setup {
    ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of language_version
    highlight = {
        enable = true
    }
}

local auto_group = vim.api.nvim_create_augroup("FROMAT", {clear = true})
vim.api.nvim_create_autocmd(
    "BufWritePre",
    {
        command = "PrettierAsync",
        pattern = "*.ts,*.js,*.json,*.html,*.vue,*.svelte",
        group = auto_group
    }
)

common.map("<leader>f", ":Autoformat<CR>")
