local common = require("micmine.util.common")
local error_handeling = require("micmine.util.error_handeling")

common.map(
  "ä",
  function()
    error_handeling.set_qfl()
  end
)
