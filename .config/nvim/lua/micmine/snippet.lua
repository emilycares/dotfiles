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

-- jump to next snippet slot
vim.keymap.set({ "i", "s" }, "<c-k>", function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, { silent = true })

-- jump to previous snippet slot
vim.keymap.set({ "i", "s" }, "<c-j>", function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, { silent = true })

vim.keymap.set("i", "<c-l>", function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end, { silent = true })

vim.keymap.set("n", "<leader>ec", function()
  ls.unlink_current()
end, { silent = true })
-- reload snippets
vim.keymap.set("n", "<leader>se", "<cmd>edit C:\\Users\\micmeier\\AppData\\Local\\nvim\\lua\\micmine\\snippet.lua<CR>")
vim.keymap.set(
  "n",
  "<leader>sr",
  "<cmd>source C:\\Users\\micmeier\\AppData\\Local\\nvim\\lua\\micmine\\snippet.lua<CR>"
)

require("luasnip.loaders.from_vscode").lazy_load({
  paths = { "C:\\Users\\micmeier\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\friendly-snippets" },
})

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

ls.add_snippets("rust", { -- #[wasm_bindgen] pub fn greet(name: &str) { alert(&format!("Hello, {}!", name)); }
  s(
    "wfn",
    fmt(
      [[
                    #[wasm_bindgen]
                    pub fn {}({}) {{
                      {}
                    }}
                ]],
      {
        i(1),
        i(2),
        i(3),
      }
    )
  ),
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
  s(
    "yewfn",
    fmt(
      [[
                   #[function_component({})]
                   pub fn {}() -> Html {{

                     html! {{
                       <>
                         <p>{{ "The component {} works!" }}</p>
                       </>
                     }}
                   }}
                ]],
      {
        i(1),
        f(firstToLowerCase, 1),
        rep(1),
      }
    )
  ),
  s(
    "yewcom",
    fmt(
      [[
                  use yew::prelude::*;

                  #[derive(Debug)]
                  pub struct {};

                  #[derive(Debug)]
                  pub enum Msg {{
                  }}

                  impl Component for {} {{
                      type Message = Msg;
                      type Properties = ();

                      fn create(_ctx: &Context<Self>) -> Self {{
                          Self
                      }}

                      fn view(&self, _ctx: &Context<Self>) -> Html {{
                          html! {{
                            <>
                              <p>{{ "The component {} works!" }}</p>
                            </>
                          }}
                      }}
                  }}
                ]],
      {
        i(1),
        rep(1),
        rep(1),
      }
    )
  ),
  s("str", fmt([[String::from("{}")]], { i(1) })),
  -- #[tokio:test] async fn name() { unimplemented!(); }
  s("atest", {
    t("#[tokio:test] async fn "),
    i(1),
    t("_should_"),
    i(2),
    t("() { "),
    i(3, "unimplemented!();"),
    t(" }"),
    t(" }"),
  }),
})

ls.add_snippets("java", {
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
})
