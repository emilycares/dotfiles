return {
  {
    "L3MON4D3/LuaSnip",
    tag = "v2.0.0",
    build = "make install_jsregexp",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    keys = {
      {
        "<c-k>",
        function()
          local ls = require("luasnip")
          if ls.expand_or_jumpable() then
            ls.expand_or_jump()
          end
        end,
        mode = { "i", "s" },
      },
      {
        "<c-j>",
        function()
          local ls = require("luasnip")
          if ls.jumpable(-1) then
            ls.jump(-1)
          end
        end,
        mode = { "i", "s" },
      },
      {
        "<c-l>",
        function()
          local ls = require("luasnip")
          if ls.choice_active() then
            ls.change_choice(1)
          end
        end,
        mode = { "i" },
      },
      {
        "<leader>ec",
        function()
          require("luasnip").unlink_current()
        end,
      },
    },
    config = function()
      local ls = require("luasnip")
      local types = require("luasnip.util.types")

      ls.config.set_config({
        -- Jump back into snippet
        history = false,
        -- dynamic update
        updateevents = "TextChanged,TextChangedI",
        enable_autosnippets = true,
        -- highlight
        ext_ops = {
          [types.choiceNode] = {
            active = {
              virt_text = { { "<--", "Error" } },
            },
          },
        },
      })

      require("micmine.snippet.typescript")
      require("micmine.snippet.rust")
      require("micmine.snippet.java")
      require("micmine.snippet.html")
      require("micmine.snippet.markdown")
    end,
  },
}
