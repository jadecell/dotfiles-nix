# This is my configuration file for neovim.
# I've written it in nix for ease of use with home-manager, 
# but there are several vimscript and lua files imported as well.
# If you want more help understanding or modifying these configurations, 
# please submit an issue on Github or contact me on Discord 'notusknot#5622'
{ pkgs, config, ... }:

let
    tokyonight-nvim = pkgs.vimUtils.buildVimPlugin {
        name = "tokyonight-nvim";
        src = pkgs.fetchFromGitHub {
            owner = "folke";
            repo = "tokyonight.nvim";
            rev = "2981e4bd0919305675d8d665f9a20281bb33ed06";
            sha256 = "ARvX6a/btRP9uTWGEW0yWL0lqE6G9OF89krjrMMre5Y=";
        };
    };
in
{
environment.systemPackages = with pkgs; [
    (neovim.override {
        configure = {
            packages.myPlugins = with pkgs.vimPlugins; {
                start = [
                # File tree
                popup-nvim plenary-nvim nvim-compe neorg 
                nvim-web-devicons 
                nvim-tree-lua

                # LSP
                nvim-lspconfig

                # Languages
                vim-nix

                # Eyecandy 
                lualine-nvim
                galaxyline-nvim
                bufferline-nvim
                nvim-colorizer-lua
                tokyonight-nvim
                pears-nvim
                nvim-treesitter

                # Telescope
                telescope-nvim

                # Indent lines
                indent-blankline-nvim

            ];
        };
        customRC = ''
              syntax on
              filetype on
              filetype plugin indent on
              packadd nvim-treesitter
              
              packadd tokyonight-nvim
              packadd plenary-nvim
              packadd nvim-web-devicons
              packadd nvim-tree-lua
              packadd nvim-lspconfig
              packadd nvim-compe
              packadd vim-nix
              packadd nvim-treesitter
              packadd bufferline-nvim	
              packadd galaxyline-nvim
              packadd nvim-colorizer-lua
              packadd telescope-nvim
              packadd indent-blankline-nvim
              packadd pears-nvim
              packadd neorg

              doautocmd BufRead

              lua << EOF
		    vim.defer_fn(function() 
			dofile(os.getenv("NIXOS_CONFIG_DIR") .. "config/nvim/lua/settings.lua")
		    end, 1)
              EOF
        '';
        };
    }
)];
}
