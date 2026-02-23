# Neovim Config

The role of this file is to descrive common mistakes and confusion points that agents might encounter as they work in this proejct. If you ever encounter something in ths project that surprises you, please alert the developer working with you and indidcate that this is the case in the AgentMd file to help prevent future agents from having the same issue.

## Build / lint / format

- `nix build` — build the flake
- `nix develop` — enter dev shell (or use `direnv allow`)
- `selene lua/` — lint Lua
- `stylua lua/ lsp/ init.lua` — format Lua
- `alejandra flake.nix` — format Nix

## Design philosophy

Editing and navigation only. No tool-wrapper plugins (no fugitive, lazygit,
kubectl wrappers, etc.) — external tools run in the terminal directly.

## Ergonomics

Split keyboard layout. Prefer left-hand keys (1-5) for numbered mappings.
comfy-line-numbers uses bijective base-5 (digits 1-5 only).

## Gotchas

- LSP keymaps are buffer-local and created on LspAttach; avoid adding global LSP maps elsewhere.
- Search result navigation (n/N) is handled by hlslens; avoid duplicating those mappings in core keymaps.
- Use `lua/utils/keymap.lua` for mappings; it defaults `silent=true` and warns if `desc` is missing.
