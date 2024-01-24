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

local function firstToLowerCase(args)
  local firstChar = string.lower(string.sub(args[1][1], 0, 1))
  local rest = string.sub(args[1][1], 2)

  return firstChar .. rest
end

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
})

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

ls.add_snippets("typescript", {
  -- () =>
  s("in", fmt([[({}) => {}]], { i(1), i(2) })),
  -- () => {}
  s("inb", fmt([[({}) => {{{}}}]], { i(1), i(2) })),
  -- let otherService: jasmine.SpyObj<OtherService>;
  s(
    "psd",
    fmt([[let {}: jasmine.SpyObj<{}>;]], {
      f(firstToLowerCase, 1),
      i(1, "Default"),
    })
  ),
  -- { provide: OtherService, useValue: jasmine.createSpyObj<OtherService>('OtherService', ["open"]),},
  s(
    "psc",
    fmt(
      [[
        {{
          provide: {},
          useValue: jasmine.createSpyObj<{}>('{}', ["{}"])
        }},
      ]],
      {
        i(1),
        rep(1),
        rep(1),
        i(2),
      }
    )
  ),
  -- otherService = TestBed.inject( OtherService) as jasmine.SpyObj<OtherService>;
  s(
    "psi",
    fmt([[{} = TestBed.inject({}) as jasmine.SpyObj<{}>;]], {
      f(firstToLowerCase, 1),
      i(1),
      rep(1),
    })
  ),
  -- export const formActionExecuted = createAction('[DynamicDataEffects] Form action executed');

  s("naction", {
    t("export const "),
    i(1),
    t(" = createAction('["),
    i(2),
    t("] "),
    i(3),
    t("');"),
  }),
  -- on(DynamicTreeActions.treeSelectionChanged, (state, action) => ({ ...state, tree: action.data })),

  s("non", {
    t("on("),
    i(1),
    t(", (state, action) => ({ ...state, "),
    i(2),
    t(" })),"),
  }),
  s(
    "test",
    fmt(
      [[
        {}('{}', () => {{
          {}
        }});
      ]],
      {
        c(1, {
          t("it"),
          t("describe"),
        }),
        i(2),
        i(3),
      }
    )
  ),
  -- private readonly someService: SomeService,
  s(
    "inj",
    fmt([[private readonly {}: {},]], {
      f(firstToLowerCase, 1),
      i(1),
    })
  ),
  -- private readonly someService: SomeService<Generic>,
  s(
    "injg",
    fmt([[private readonly {}: {}<{}>,]], {
      f(firstToLowerCase, 1),
      i(1),
      i(2),
    })
  ),
  -- /** * @description Here is the description */
  s(
    "doc",
    fmt(
      [[
        /**
         * @description {}
         */
      ]],
      {
        i(1),
      }
    )
  ),
  -- tap((TAP_LOG) => console.log("{}:", TAP_LOG)),
  s(
    "rlog",
    fmt([[tap((TAP_LOG) => console.log("{}:", TAP_LOG)),]], {
      i(1),
    })
  ),
})

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
