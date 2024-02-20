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

ls.add_snippets("html", {
  -- class=""
  s("class", fmt([[class="{}"]], { i(1) })),
  -- arl
  s("cls", fmt([[class="{}"]], { i(1) })),
  -- {#include select$select target=target /}
  s("qinclude", fmt([[{{#include {}${} {}={} /}}]], { i(1), rep(1), i(2), rep(2) })),
  --{#fragment id=title }
  --<p>Content</p>
  --{/fragment}
  s(
    "qfragment",
    fmt(
      [[
  {{#fragment id={} }}
    {}
  {{/fragment}}
  ]],
      { i(1), i(2) }
    )
  ),
  --{#for item in list}
  --  {item.name}
  --{/for}
  s(
    "qfor",
    fmt(
      [[
  {{#for {} in {}}}
    {{{}}}
  {{/for}}
  ]],
      { i(1, "item"), i(2, "list"), i(3, "item.name") }
    )
  ),
  --{#if condition}
  -- <p>Content</p>
  --{/if}
  s(
    "qif",
    fmt(
      [[
  {{#if {}}}
   {}
  {{/if}}
  ]],
      { i(1, "condition"), i(2, "<p>Here</p>") }
    )
  ),
})
