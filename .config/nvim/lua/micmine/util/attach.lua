local M = {}
M.on_attach = function(client, bufnr)
  require("lsp_signature").on_attach({}, bufnr)
  vim.api.nvim_create_augroup("lsp_augroup", { clear = true })
  local ops = { buffer = bufnr, remap = false }

  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, ops)
  vim.keymap.set("n", "gd", function()
    vim.lsp.buf.definition()
  end, ops)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, ops)
  vim.keymap.set("n", "<leader>K", vim.lsp.buf.hover, ops)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, ops)

  -- modify
  vim.keymap.set("n", "<leader>q", vim.lsp.buf.code_action, ops)
  vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, ops)

  -- diagnostic
  vim.keymap.set("n", "ü", function()
    vim.diagnostic.open_float()
  end, ops)
  vim.keymap.set("n", "[", function()
    vim.diagnostic.open_float()
  end, ops)
  vim.keymap.set("n", "ö", vim.diagnostic.goto_next, ops)
  vim.keymap.set("n", "]", vim.diagnostic.goto_next, ops)
  vim.keymap.set("n", "<leader>q", vim.lsp.buf.code_action, ops)
  vim.keymap.set("v", "<leader>q", vim.lsp.buf.code_action, ops)

  -- codelense
  vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    pattern = { "*.rs", "*.java" },
    callback = function()
      vim.lsp.codelens.refresh()
    end,
  })
  vim.keymap.set("n", "<leader>xl", vim.lsp.codelens.refresh, ops)
  vim.keymap.set("n", "<leader>xr", vim.lsp.codelens.run, ops)

  -- inlay_hints
  vim.keymap.set("n", "<leader>i", function()
    --vim.api.nvim_set_hl(bufnr, "LspInlayHint", { bg = "#000000", fg = "#00ff55" })
    vim.lsp.inlay_hint(bufnr, nil)
  end, ops)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
M.capabilities = capabilities;

return M;
