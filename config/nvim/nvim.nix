# This is my configuration file for neovim.
# I've written it in nix for ease of use with home-manager, 
# but there are several vimscript and lua files imported as well.
# If you want more help understanding or modifying these configurations, 
# please submit an issue on Github or contact me on Discord 'notusknot#5622'
{ pkgs, config, ... }:

let

    surround-nvim = pkgs.vimUtils.buildVimPlugin {
        name = "surround-nvim";
        src = pkgs.fetchFromGitHub {
            owner = "blackCauldron7";
            repo = "surround.nvim";
            rev = "0aca06a4ac9068e932c7e5ddd5ec035ea592a265";
            sha256 = "wsX5+p8x6tNO7viZJoh3a0AqBhRldSIganvhWGxP5iE=";
        };
    };

in
{
    enable = true;
    plugins = with pkgs.vimPlugins; [
	
	gitsigns-nvim
	colorizer
        trouble-nvim
        markdown-preview-nvim
        luasnip
        surround-nvim
        cmp_luasnip
	nvim-web-devicons
        feline-nvim
	vim-commentary
	nvim-cmp
	cmp-nvim-lsp
	nvim-lspconfig
	nvim-treesitter
	cmp-treesitter
	telescope-nvim
	lsp_signature-nvim
	nvim-autopairs
	nvim-compe
	vim-nix

	# Colorscheme
	tokyonight-nvim
    ];
    extraConfig = ''
        luafile /home/jackson/.config/nixos/config/nvim/lua/init.lua
    '';
}
