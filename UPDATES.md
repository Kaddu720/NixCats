# Config update tracker

Recommendations from a review of the config against Neovim 0.12.6 (the version
`nvim-dev` builds from the pinned `nixpkgs-unstable`) and the unreleased 0.13
release notes (master `news.txt`, 2026-11-08).

Status: `[ ]` pending · `[x]` done · `[-]` decided against

## 1. Safe cleanups (no behaviour change)

### Options that are already defaults — `lua/config/options.lua`
- [x] Removed `autoindent`, `smarttab`, `hlsearch`, `incsearch`,
      `autoread`, `timeout`, `undolevels = 1000`, `vim.cmd("syntax enable")`
- [-] Keep `mouse = "a"`: the default is `nvi`, so it is not redundant
- [x] Set `winborder` directly instead of wrapping it in `pcall`
- [x] Drop `float = { border = "rounded" }` from `vim.diagnostic.config` (covered by `winborder`)
- [x] Removed `history = 100` (default 10000)
- [-] Keep `termguicolors`: auto-detection can fail inside tmux/herdr, which would break the hex palette

### LSP keymaps — `lua/config/keymaps_registry.lua` (`M.lsp`)
- [x] Removed `gr` → references: it makes the built-in `grr`/`grn`/`gra`/`gri`/`grt`/`grx`
      wait out `timeoutlen`. Use `grr` instead
- [x] Removed `K` → hover (built-in default)
- [x] Removed `<leader>rn` → rename (built-in `grn`)
- [x] Kept `gd`

### Dead code
- [x] Deleted `lua/plugins/none-ls.lua` (returns `{}`)
- [x] Removed `disable_filetype = { "TelescopePrompt", "spectre_panel" }` from
      `lua/plugins/nvim-autopairs.lua` (neither plugin is installed)

## 2. Helm support

- [x] Added `helm` and `regex` to the `nvim-treesitter.withPlugins` list in
      `flake.nix`. Helm buffers previously had no highlighting at all; the existing
      FileType autocmd in `lua/plugins/treesitter.lua` now starts the parser
- [x] Replaced `helm_root_dir` in `lsp/helm_ls.lua` with a single equal-priority group (keeps nearest-marker behaviour):
      `root_markers = { { "Chart.yaml", "Chart.yml", "helmfile.yaml", "helmfile.yml", ".git" } }`
- [x] Same `root_markers` simplification for `yaml_root_dir` in `lsp/yamlls.lua`
- [-] Kept per-server `flags.debounce_text_changes = 300`
      (it overrides the global 500 set in `lua/config/language.lua`)
- Keep: `ftdetect/helm.lua` (pattern detection avoids attaching yamlls) and
  `after/ftplugin/helm.lua` (no `commentstring` from Neovim or the grammar)
- Helmfile is covered too (verified): `helmfile*.yaml` and `*.gotmpl` get `ft=helm`, highlighting
  and helm_ls, whose embedded yamlls applies the helmfile schema; `helmfile.d/*.yaml` stays `yaml`
  and uses yamlls directly. Minor: the `"helmfile.yaml"` pattern in the `lsp/yamlls.lua` helmfile
  schema entry is never used (yamlls does not attach to `ft=helm`); harmless

## 3. Optional plugin removals (taste calls)

- [x] **lualine.nvim** → native statusline in `lua/config/statusline.lua` (same layout; highlight
      groups in `colorscheme.lua`), built on `vim.diagnostic.status()`, `vim.ui.progress_status()`
      and `b:gitsigns_head`
- [x] **flash.nvim `S` / `R`** → built-in visual `an` / `in` / `]n` / `[n` / `]N` / `[N`
      treesitter selection (keep flash for `f`/`t`/remote `r`)
- [x] **nvim-hlslens** → native search count + plain `nzzzv` / `Nzzzv` mappings in `M.core()`
- [x] **trouble.nvim** → `<leader>tt` toggles buffer diagnostics in the loclist, `<leader>tf` opens all in quickfix
- [-] **blink.cmp** → native `'autocomplete'` / `vim.lsp.completion`: not worth it, would lose
      friendly-snippets, buffer source and ecolog

## 4. New 0.12 features to try

- [x] `:Undotree` (`packadd nvim.undotree`) and `:DiffTool`
- [x] ui2 (`require('vim._core.ui2').enable()`, experimental) — avoids "Press ENTER"
      prompts from the file-reload message
- [x] `vim.lsp.document_color.enable()`, `vim.lsp.linked_editing_range.enable()`,
      code lenses (`grx`)

## 5. Neovim 0.13 (unreleased — revisit when it ships)

Recommendation: stay on 0.12.6 for daily use. Optionally point only `nvim-dev` at a nightly
overlay in `flake.nix` to trial it.

- [ ] Trial nightly in `nvim-dev` only
- [ ] When on 0.13: replace the 1-second `checktime` timer and FocusGained/BufEnter autocmd in
      `lua/config/options.lua` — `'autoread'` uses file-system watchers
- [ ] When on 0.13: collapse repetitive maps using `vim.keymap.set` list-of-lhs support
- [ ] When on 0.13: native statusline gets item-group `%=` / `%<` and highlight scopes

Watch for on 0.13:
- `cd` diagnostic toggle: `current_line` virtual lines now update on CursorHold
  (~500ms lag with `updatetime = 500`)
- `Q` now adds a multicursor instead of replaying the last macro
- Statusline item-group `%=` / `%<` semantics change; `lua/config/statusline.lua` uses no item
  groups, so it should be unaffected — check it renders the same
- lze, blink.cmp, fzf-lua, obsidian and otter may lag behind nightly

## 6. Follow-ups outside the config

- [ ] Merge `nvim-0.12-cleanup` into `master`
- [ ] Rebuild the main `nvim` from the flake. The installed one is 0.12.5 with an older baked-in
      config whose gitsigns and nvim-lint never load for the first file opened (only the second)
- [ ] Renew the FlakeHub token (`determinate-nixd login`): the `nixpkgs` registry entry points at
      FlakeHub, so `nix shell nixpkgs#…` fails. Workaround: `nix shell --inputs-from . nixpkgs#…`
- [x] Remove the stray blank line before `end` in `M.core()` (`lua/config/keymaps_registry.lua`)
      flagged by `stylua --check` (pre-existing)

Startup benchmark (2026-11-08, TUI, 25 runs, process start → deferred plugins loaded):
0.12.5 `nvim` 148 ms / 159 ms (no file / Lua file) vs 0.12.6 `nvim-dev` 145 ms / 173 ms. The
file-open difference is gitsigns + nvim-lint actually loading on the first file; removing
`syntax enable` saved ~11 ms.
