return {
  cmd = { 'nil' },  -- 'nil' is the Nix language server
  filetypes = { 'nix' },
  root_markers = { 'flake.nix', 'shell.nix', 'default.nix' },
  formatters = {
    ignoreComments = false,
  },
  settings = {
    ['nil'] = {
      formatting = {
        command = { "nixpkgs-fmt" }  -- You can use "nixfmt" or other formatters instead
      },
      diagnostics = {
        -- ignored = [],
        -- excludedFiles = []
      },
      nix = {
        flake = {
          autoArchive = true,
          autoEvalInputs = true;
        }
      }
    }
  }
}
