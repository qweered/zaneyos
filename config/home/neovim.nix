{ config, pkgs, ... }:

let
  plugins = pkgs.vimPlugins;
#  theme = config.colorScheme.palette;
in {
  programs.nixvim = {
    enable = true;

    globals.mapleader = " "; # Sets the leader key to space
    
    opts = {
      clipboard="unnamedplus";
      number = true;         # Show line numbers
      relativenumber = true; # Show relative line numbers
      shiftwidth = 2;        # Tab width should be 2
      softtabstop = 2;
      smartindent = true;
      wrap = false;
      swapfile = false;
      backup = false;
      hlsearch = false;
      incsearch = true;
      termguicolors = true;
      scrolloff = 8;
      updatetime = 50;
    };
#
#    colorschemes.base16.enable = true;
#    colorschemes.base16.colorscheme = {
#      base00 = "#${theme.base00}";
#      base01 = "#${theme.base01}";
#      base02 = "#${theme.base02}";
#      base03 = "#${theme.base03}";
#      base04 = "#${theme.base04}";
#      base05 = "#${theme.base05}";
#      base06 = "#${theme.base06}";
#      base07 = "#${theme.base07}";
#      base08 = "#${theme.base08}";
#      base09 = "#${theme.base09}";
#      base0A = "#${theme.base0A}";
#      base0B = "#${theme.base0B}";
#      base0C = "#${theme.base0C}";
#      base0D = "#${theme.base0D}";
#      base0E = "#${theme.base0E}";
#      base0F = "#${theme.base0F}";
#    };
#
    plugins = {
      barbecue.enable = true;
      gitsigns.enable = true;
      telescope = {
	enable = true;
	keymaps = {
	  "<leader>ff" = "find_files";
	  "<leader>lg" = "live_grep";
	};
      };
      indent-blankline.enable = true;
      nvim-colorizer.enable = true;
      nvim-autopairs.enable = true;
      nix.enable = true;
      comment.enable = true;
      lualine = {
        enable = true;
      };
      startup = { 
	enable = true;
	theme = "dashboard";
      };
      lsp = {
	enable = true;
	servers = {
	  tsserver.enable = true;
	  lua-ls.enable = true;
	  bashls.enable = true;
	  rust-analyzer = {
	    enable = true;
	    installRustc = true;
	    installCargo = true;
	  };
	  nixd.enable = true;
	  html.enable = true;
	  ccls.enable = true;
	  cmake.enable = true;
	  csharp-ls.enable = true;
	  cssls.enable = true;
	  gopls.enable = true;
	  jsonls.enable = true;
	  pyright.enable = true;
	  tailwindcss.enable = true;
	};
      };
      lsp-lines.enable = true;
      treesitter = {
	enable = true;
	nixGrammars = true;
      };
      cmp.settings = {
	enable = true;
	autoEnableSources = true;
	sources = [
	  { name = "nvim_lsp"; }
	  { name = "path"; }
	  { name = "buffer"; }
	];
	mapping = {
	  "<CR>" = "cmp.mapping.confirm({ select = true })";
	  "<Tab>" = {
	    action = ''cmp.mapping.select_next_item()'';
	    modes = [ "i" "s" ];
	  };
	};
      };
    };

    extraPlugins = [ plugins.telescope-file-browser-nvim ];

    # FOR NEOVIDE
    extraConfigLua = '' 
      vim.opt.guifont = "JetBrainsMono\\ NFM,Noto_Color_Emoji:h14"
      vim.g.neovide_cursor_animation_length = 0.05


      require('lualine').setup {
        options = {
          theme = bubbles_theme,
          component_separators = '|',
          section_separators = { left = '', right = '' },
        },
        sections = {
          lualine_a = {
            { 'mode', separator = { left = '' }, right_padding = 2 },
          },
          lualine_b = { 'filename', 'branch' },
          lualine_c = { 'fileformat' },
          lualine_x = {},
          lualine_y = { 'filetype', 'progress' },
          lualine_z = {
            { 'location', separator = { right = '' }, left_padding = 2 },
          },
        },
        inactive_sections = {
          lualine_a = { 'filename' },
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = { 'location' },
        },
        tabline = {},
        extensions = {},
      }
    '';

    extraConfigVim = ''
      set noshowmode
      inoremap hh <ESC>
    '';

    keymaps = [
      {
        mode = "n";
        key = "<space>fb";
        action = ":Telescope file_browser<CR>";
        options.noremap = true;
      }
      {
        key = "<Tab>";
        action = ":bnext<CR>";
        options.silent = false;
      }
      {
        key = "<S-Tab>";
        action = ":bprev<CR>";
        options.silent = false;
      }
    ];
  };
 } 
