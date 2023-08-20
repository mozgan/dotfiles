local diagnostic = vim.diagnostic

diagnostic.config({
  float = {
    border = "single",
    source = "always",
  },
  signs = {
    severity = { min = vim.diagnostic.severity.WARN },
  },
  severity_sort = true,
  underline = false,
  update_in_insert = true,
  virtual_text = false,
  virtual_lines = {
    severity = { min = vim.diagnostic.severity.WARN }
  },
})
