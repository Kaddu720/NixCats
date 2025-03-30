{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixCats.url = "github:BirdeeHub/nixCats-nvim";

    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
    };

    # "plugins-snacks" = {
    #   url = "github:folke/snacks.nvim?ref=v2.11.0";
    #   flake = false;
    # };

    "plugins-ecolog" = {
      url = "github:philosofonusus/ecolog.nvim";
      flake = false;
    };
  };

  # see :help nixCats.flake.outputs
  outputs = {
    nixpkgs,
    nixCats,
    ...
  } @ inputs: let
    inherit (nixCats) utils;
    luaPath = "${./.}";
    forEachSystem = utils.eachSystem nixpkgs.lib.platforms.all;
    extra_pkg_config = {
      # allowUnfree = true;
    };
    dependencyOverlays = [
      (utils.standardPluginOverlay inputs)
    ];

    categoryDefinitions = {pkgs, ...} @ packageDef: {
      lspsAndRuntimeDeps.general = with pkgs; [
        # Fzf-lua dependencies
        bat
        fd
        ripgrep

        # Lua
        lua-language-server
        stylua
        selene

        # Python
        pyright
        ruff-lsp
        isort
        mypy

        #Nix
        nixd
        nil
        alejandra
        deadnix

        # Markdown
        ltex-ls

        # Terraform
        terraform-ls

        # Yaml
        yaml-language-server
        yamllint

        # Bash
        bash-language-server
        shfmt
        dotenv-linter
      ];

      # This is for plugins that will load at startup without using packadd:
      startupPlugins = {
        general = with pkgs.vimPlugins; [
          lze
          rose-pine
          dressing-nvim
          plenary-nvim
          nui-nvim
        ];
      };

      # not loaded automatically at startup.
      # use with packadd and an autocommand in config to achieve lazy loading
      optionalPlugins = {
        general = with pkgs.vimPlugins; [
          friendly-snippets
          avante-nvim
          blink-cmp
          fzf-lua
          git-blame-nvim
          ltex_extra-nvim
          none-ls-nvim
          nvim-autopairs
          nvim-web-devicons
          nvim-treesitter
          nvim-treesitter-textobjects
          nvim-treesitter-context
          obsidian-nvim
          oil-nvim
          otter-nvim
          snacks-nvim
          trouble-nvim
          tmux-navigator
          which-key-nvim
          # pkgs.neovimPlugins.snacks
          pkgs.neovimPlugins.ecolog
        ];
      };

      # shared libraries to be added to LD_LIBRARY_PATH
      # variable available to nvim runtime
      sharedLibraries = {
        general = with pkgs; [
          # libgit2
        ];
      };
    };

    # And then build a package with specific categories from above here:
    # All categories you wish to include must be marked true,
    # but false may be omitted.
    # This entire set is also passed to nixCats for querying within the lua.

    # see :help nixCats.flake.outputs.packageDefinitions
    packageDefinitions = {
      # These are the names of your packages
      # you can include as many as you wish.
      nvim = {pkgs, ...}: {
        # they contain a settings set defined above
        # see :help nixCats.flake.outputs.settings
        settings = {
          wrapRc = true;
          # IMPORTANT:
          # your alias may not conflict with your other packages.
          aliases = ["vim"];
          neovim-unwrapped = inputs.neovim-nightly-overlay.packages.${pkgs.system}.neovim;
        };
        # and a set of categories that you want
        # (and other information to pass to lua)
        categories = {
          general = true;
        };
      };
    };
    # In this section, the main thing you will need to do is change the default package name
    # to the name of the packageDefinitions entry you wish to use as the default.
    defaultPackageName = "nvim";
  in
    # see :help nixCats.flake.outputs.exports
    forEachSystem (system: let
      nixCatsBuilder =
        utils.baseBuilder luaPath {
          inherit nixpkgs system dependencyOverlays extra_pkg_config;
        }
        categoryDefinitions
        packageDefinitions;
      defaultPackage = nixCatsBuilder defaultPackageName;
      # this is just for using utils such as pkgs.mkShell
      # The one used to build neovim is resolved inside the builder
      # and is passed to our categoryDefinitions and packageDefinitions
      pkgs = import nixpkgs {inherit system;};
    in {
      # these outputs will be wrapped with ${system} by utils.eachSystem

      # this will make a package out of each of the packageDefinitions defined above
      # and set the default package to the one passed in here.
      packages = utils.mkAllWithDefault defaultPackage;

      # choose your package for devShell
      # and add whatever else you want in it.
      devShells = {
        default = pkgs.mkShell {
          name = defaultPackageName;
          packages = [defaultPackage];
          inputsFrom = [];
          shellHook = ''
          '';
        };
      };
    })
    // (let
      # we also export a nixos module to allow reconfiguration from configuration.nix
      nixosModule = utils.mkNixosModules {
        inherit
          defaultPackageName
          dependencyOverlays
          luaPath
          categoryDefinitions
          packageDefinitions
          extra_pkg_config
          nixpkgs
          ;
      };
      # and the same for home manager
      homeModule = utils.mkHomeModules {
        inherit
          defaultPackageName
          dependencyOverlays
          luaPath
          categoryDefinitions
          packageDefinitions
          extra_pkg_config
          nixpkgs
          ;
      };
    in {
      # these outputs will be NOT wrapped with ${system}

      # this will make an overlay out of each of the packageDefinitions defined above
      # and set the default overlay to the one named here.
      overlays =
        utils.makeOverlays luaPath {
          inherit nixpkgs dependencyOverlays extra_pkg_config;
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
