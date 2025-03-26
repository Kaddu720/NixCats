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
        command = { "nixpkgs-fmt" }  -- You can use "nixfmt" or other formatters instead
      },
      diagnostics = {
        -- ignored = [],
        -- excludedFiles = []
      },
      nix = {
        flake = {
          autoEvalInputs = true
        }
      }
    }
  }
}
