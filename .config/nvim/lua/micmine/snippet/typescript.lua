require("luasnip.session.snippet_collection").clear_snippets("typescript")

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

print("ASD")
function firstToLowerCase(args)
  local firstChar = string.lower(string.sub(args[1][1], 0, 1))
  local rest = string.sub(args[1][1], 2)

  return firstChar .. rest
end

print("ASD")
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

print("ASD")
