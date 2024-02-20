require("luasnip.session.snippet_collection").clear_snippets("html")

local ls = require("luasnip")

-- Snippet creator
local s = ls.s

-- format node
local fmt = require("luasnip.extras.fmt").fmt

-- repeat node
local rep = require("luasnip.extras").rep

local i = ls.insert_node
local t = ls.text_node
local f = ls.function_node
local c = ls.choice_node

ls.add_snippets("markdown", {

  -- ``` ts
  -- code
  -- ```
  s(
    "code",
    fmt(
      [[
 ``` {}
 {}
 ```
  ]],
      { i(1, "command"), i(2) }
    )
  ),
})
