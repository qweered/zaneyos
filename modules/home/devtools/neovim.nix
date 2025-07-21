{ vars, inputs, config, ... }:

{

  imports = [ inputs.nvf.homeManagerModules.default ];

  # Neovim gui wrapper
  programs.neovide = {
    enable = true;
    settings = {
      # Use the nvim from the home-manager profile instead of hardcoded path
      neovim-bin = "${config.programs.nvf.finalPackage}/bin/nvim";
      font = {
        normal = [ ];
        size = 14.0;
      };
    };
  };

  # CONFIG: https://notashelf.github.io/nvf/options
  # Neovim config framework
  programs.nvf = {
    enable = true;
    settings = {
      vim.lsp = {
        enable = true;
      };
    };
  };
}
