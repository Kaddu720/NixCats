local function shell_root_dir(bufnr, on_dir)
  local markers = { '.bashrc', '.bash_profile', '.git' }
  local name = vim.api.nvim_buf_get_name(bufnr)
  if name == "" then
    on_dir(vim.uv.cwd())
    return
  end

  local root = vim.fs.root(name, markers)
  on_dir(root or vim.fs.dirname(name))
end

return {
  cmd = { 'bash-language-server', 'start' },
  filetypes = { 'sh', 'bash' },
  root_dir = shell_root_dir,
  workspace_required = false,
  formatters = {
    ignoreComments = false,
  },
  flags = {
    debounce_text_changes = 300,
  },
  settings = {}
}
