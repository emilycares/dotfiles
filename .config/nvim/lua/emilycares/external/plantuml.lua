return {
  {
    "aklt/plantuml-syntax",
    event = "BufReadPre *.puml",
  },
  {
    "weirongxu/plantuml-previewer.vim",
    cmd = "PlantumlOpen",
    dependencies = {
      "tyru/open-browser.vim",
    },
  },
}
