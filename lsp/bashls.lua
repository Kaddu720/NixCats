return {
  cmd = { 'bash-language-server', 'start' },
  filetypes = { 'sh', 'bash' },
  root_markers = { '.bashrc', '.bash_profile', '.git' },
  formatters = {
    ignoreComments = false,
  },
  settings = {}
}
