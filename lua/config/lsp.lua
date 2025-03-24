-- Lua
vim.lsp.config["luals"] = {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	root_markers = { ".luarc.json", ".luarc.jsonc" },
	telemetry = { enabled = false },
	formatters = {
		ignoreComments = false,
	},
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			signatureHelp = { enabled = true },
		},
	},
}
vim.lsp.enable("luals")

-- Nixos
vim.lsp.config['nil_ls'] = {
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
          autoEvalInputs = true
        }
      }
    }
  }
}
vim.lsp.enable("nil_ls")

vim.lsp.config['nixd'] = {
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
vim.lsp.enable("nixd")

-- Python
vim.lsp.config['pyright'] = {
  cmd = { 'pyright-langserver', '--stdio' },
  filetypes = { 'python' },
  root_markers = { 'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', '.git' },
  formatters = {
    ignoreComments = false,
  },
  settings = {}
}
vim.lsp.enable("pyright")

vim.lsp.config['ruff'] = {
  cmd = { 'ruff-lsp' },
  filetypes = { 'python' },
  root_markers = { 'pyproject.toml', 'ruff.toml', '.ruff.toml' },
  formatters = {
    ignoreComments = false,
  },
  settings = {}
}
vim.lsp.enable("ruff")

-- Markdown/LTeX
vim.lsp.config['ltex'] = {
  cmd = { 'ltex-ls' },
  filetypes = { 'markdown', 'text', 'latex', 'tex' },
  root_markers = {},
  formatters = {
    ignoreComments = false,
  },
  settings = {
    ltex = {
      checkFrequency = "save",
    }
  }
}
vim.lsp.enable("ltex")

-- Terraform
vim.lsp.config['terraformls'] = {
  cmd = { 'terraform-ls', 'serve' },
  filetypes = { 'terraform', 'tf', 'terraform-vars' },
  root_markers = { '.terraform', 'terraform.tf', 'terraform.tfvars' },
  formatters = {
    ignoreComments = false,
  },
  settings = {}
}
vim.lsp.enable("terraformls")

-- Yaml
vim.lsp.config['yamlls'] = {
  cmd = { 'yaml-language-server', '--stdio' },
  filetypes = { 'yaml', 'yml' },
  root_markers = { '.git' },
  formatters = {
    ignoreComments = false,
  },
  settings = {
    yaml = {
      schemas = {},
      validate = true
    }
  }
}
vim.lsp.enable("yamlls")

-- Bash
vim.lsp.config['bashls'] = {
  cmd = { 'bash-language-server', 'start' },
  filetypes = { 'sh', 'bash' },
  root_markers = { '.bashrc', '.bash_profile', '.git' },
  formatters = {
    ignoreComments = false,
  },
  settings = {}
}
vim.lsp.enable("bashls")
