return {
  cmd = { 'nil' },
  filetypes = { 'nix' },
  root_markers = { 'flake.nix', 'shell.nix', 'default.nix' },
  formatters = {
    ignoreComments = false,
  },
  settings = {
    ['nil'] = {
      formatting = {
        command = { "nixpkgs-fmt" }
      },
      diagnostics = {
        -- Exclude specific files or inputs that cause issues
        excludedFiles = { ".*nvim-config.*", ".*nix-homebrew.*" }
      },
      nix = {
        flake = {
          autoArchive = true,
          -- Completely disable auto-evaluation of inputs
          autoEvalInputs = true
        }
      }
    }
  }
}
