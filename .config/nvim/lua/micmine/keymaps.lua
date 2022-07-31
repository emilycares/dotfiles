local common = require("micmine.util.common")
local bacon = require("micmine.util.bacon")

common.map(
  "ä",
  function()
    bacon.set_bacon_qfl()
  end
)
