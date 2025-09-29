return {
  cmd = { 'nixd' },  -- 'nil' is the Nix language server
  filetypes = { 'nix' },
  root_markers = { 'flake.nix', 'shell.nix', 'default.nix' },
  formatters = {
    ignoreComments = false,
  },
  settings = {
    ['nixd'] = {
      formatting = {
        command = { "alejandra" }
      },
      diagnostics = {
      },
      nix = {
        flake = {
          autoEvalInputs = true
        }
      }
    }
  }
}
