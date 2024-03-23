require("luasnip.session.snippet_collection").clear_snippets("rust")

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

ls.add_snippets("rust", {
  -- ||
  s("in", fmt([[|{}| {}]], { i(1), i(2) })),
  -- || {}
  s("inb", fmt([[|{}| {{{}}}]], { i(1), i(2) })),
  s(
    "atest",
    fmt(
      [[
        #[tokio::test]
        async fn {}() {{
          {}
        }}
      ]],
      {
        i(1),
        i(2, "unimplemented!();"),
      }
    )
  ),
  s(
    "test",
    fmt(
      [[
        #[test]
        fn {}() {{
          {}
        }}
      ]],
      {
        i(1),
        i(2, "unimplemented!();"),
      }
    )
  ),
  s(
    "testmod",
    fmt(
      [[
        #[cfg(test)]
        mod tests {{
          {}
        }}
      ]],
      {
        i(1),
      }
    )
  ),
  s("str", fmt([[String::from("{}")]], { i(1) })),
  -- .filter(|value| )
  s(
    "f",
    fmt([[.filter(|{}| {})]], {
      i(1),
      i(2),
    })
  ),
  -- .filter(|value| {})
  s(
    "fb",
    fmt([[.filter(|{}| {{{}}})]], {
      i(1),
      i(2),
    })
  ),
  -- .map(|value| ))
  s(
    "m",
    fmt([[.map(|{}| {})]], {
      i(1),
      i(2),
    })
  ),
  -- .map((value) {})
  s(
    "mb",
    fmt([[.map(|{}| {{{}}})]], {
      i(1),
      i(2),
    })
  ),
  -- .customOpterator(|value| ))
  s(
    "c",
    fmt([[.{}(|{}| {})]], {
      i(1),
      i(2),
      i(3),
    })
  ),
  -- .customOpterator(|value| {}))
  s(
    "cb",
    fmt([[.{}(|{}| {{{}}})]], {
      i(1),
      i(2),
      i(3),
    })
  ),
})
