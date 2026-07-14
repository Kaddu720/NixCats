{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixCats.url = "github:BirdeeHub/nixCats-nvim";
    plugins-ecolog = {
      url = "github:philosofonusus/ecolog.nvim";
      flake = false;
    };
    plugins-obsidian = {
      url = "github:obsidian-nvim/obsidian.nvim";
      flake = false;
    };
    plugins-comfy-line-numbers = {
      url = "github:mluders/comfy-line-numbers.nvim";
      flake = false;
    };
  };
  outputs = {
    nixpkgs,
    nixCats,
    ...
  } @ inputs: let
    inherit (nixCats) utils;
    luaPath = "${./.}";
    dependencyOverlays = [(utils.standardPluginOverlay inputs)];
    categoryDefinitions = {pkgs, ...}: {
      lspsAndRuntimeDeps = {
        core = with pkgs; [bat fd ripgrep];
        devops = with pkgs; [lua-language-server stylua selene pyright ruff ty nil nixd alejandra deadnix terraform-ls yaml-language-server yamllint bash-language-server shellcheck shfmt dotenv-linter dockerfile-language-server helm-ls];
        writing = with pkgs; [ltex-ls-plus vale];
      };
      startupPlugins.core = with pkgs.vimPlugins; [lze];
      optionalPlugins = {
        core = with pkgs.vimPlugins; [blink-cmp friendly-snippets conform-nvim nvim-lint plenary-nvim fzf-lua nvim-web-devicons (nvim-treesitter.withPlugins (plugins: with plugins; [bash comment dockerfile hcl json lua markdown markdown_inline nix nu python query terraform toml vim vimdoc yaml])) nvim-treesitter-textobjects nvim-treesitter-context oil-nvim flash-nvim gitsigns-nvim lualine-nvim nvim-autopairs nvim-hlslens otter-nvim indent-blankline-nvim trouble-nvim pkgs.neovimPlugins.ecolog pkgs.neovimPlugins.comfy-line-numbers];
        devops = with pkgs.vimPlugins; [];
        writing = with pkgs.vimPlugins; [pkgs.neovimPlugins.obsidian ltex_extra-nvim];
      };
    };
    packageDefinitions = {
      nvim = {pkgs, ...}: {
        settings = {
          wrapRc = true;
          aliases = ["vim"];
          neovim-unwrapped = pkgs.neovim-unwrapped;
        };
        categories = {
          core = true;
          devops = true;
        };
      };
      nvim-full = {pkgs, ...}: {
        settings = {
          wrapRc = true;
          aliases = ["vim"];
          neovim-unwrapped = pkgs.neovim-unwrapped;
        };
        categories = {
          core = true;
          devops = true;
          writing = true;
        };
      };
      nvim-dev = {pkgs, ...}: {
        settings = {
          wrapRc = false;
          aliases = ["vim"];
          neovim-unwrapped = pkgs.neovim-unwrapped;
        };
        categories = {
          core = true;
          devops = true;
          writing = true;
        };
      };
    };
    defaultPackageName = "nvim";
    systems = ["x86_64-linux" "aarch64-linux" "aarch64-darwin"];
  in
    utils.eachSystem systems (system: let
      builder =
        utils.baseBuilder luaPath {
          inherit nixpkgs system dependencyOverlays;
          extra_pkg_config = {};
        }
        categoryDefinitions
        packageDefinitions;
      pkgs = import nixpkgs {inherit system;};
    in {
      packages = utils.mkAllWithDefault (builder defaultPackageName);
      devShells.default = pkgs.mkShell {
        name = "nvim-dev";
        packages = with pkgs; [(builder "nvim-dev") alejandra selene stylua];
      };
    })
    // (let
      nixosModule = utils.mkNixosModules {
        inherit defaultPackageName dependencyOverlays luaPath categoryDefinitions packageDefinitions nixpkgs;
        extra_pkg_config = {};
      };
      homeModule = utils.mkHomeModules {
        inherit defaultPackageName dependencyOverlays luaPath categoryDefinitions packageDefinitions nixpkgs;
        extra_pkg_config = {};
      };
    in {
      overlays =
        utils.makeOverlays luaPath {
          inherit nixpkgs dependencyOverlays;
          extra_pkg_config = {};
        }
        categoryDefinitions
        packageDefinitions
        defaultPackageName;
      nixosModules.default = nixosModule;
      homeModules.default = homeModule;
      inherit utils nixosModule homeModule;
      inherit (utils) templates;
    });
}
