local common = require('micmine.util.common')

require('silicon').setup({
  font = 'SauceCodePro Nerd Font=16',
  theme = 'Monokai Extended',
})

local default = true

common.map(
    "<leader>co",
    function()

      if default then
        vim.opt.relativenumber = false

        default = false
      else
        vim.opt.relativenumber = true


        default = true
      end
    end
)


--common.map(
    --"<leader>cov",
    --function()
      --vim.cmd("!cov")
    --end
--)


