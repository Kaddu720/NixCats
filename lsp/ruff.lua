return {
  cmd = { 'ruff-lsp' },
  filetypes = { 'python' },
  root_markers = { 'pyproject.toml', 'ruff.toml', '.ruff.toml' },
  formatters = {
    ignoreComments = false,
  },
  settings = {}
}
