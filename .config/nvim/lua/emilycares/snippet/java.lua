require("luasnip.session.snippet_collection").clear_snippets("java")

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

function firstToLowerCase(args)
  local firstChar = string.lower(string.sub(args[1][1], 0, 1))
  local rest = string.sub(args[1][1], 2)

  return firstChar .. rest
end

ls.add_snippets("java", {
  -- () ->
  s("in", fmt([[({}) -> {}]], { i(1), i(2) })),
  -- () -> {}
  s("inb", fmt([[({}) -> {{{}}}]], { i(1), i(2) })),
  -- @Test public void should_Test() { assertEquals(true, true); }
  s("test", {
    t("@Test public void "),
    i(1),
    t("() { "),
    i(2),
    t("}"),
  }),
  -- @BeforeEach public void setup() { }
  s(
    "beforeEach",
    fmt(
      [[
        @BeforeEach
        public void beforeEach() {{
          {}
        }}
      ]],
      {
        i(1),
      }
    )
  ),
  -- private FileDeploymentStorageImpl fileDeploymentStorageImpl;
  s("var", {
    c(1, {
      t("private"),
      t("protected"),
      t("public"),
    }),
    t(" "),
    i(2),
    t(" "),
    f(firstToLowerCase, 2),
    t(";"),
  }),
})
