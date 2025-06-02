{ vars, inputs, ... }:

{

  imports = [ inputs.nvf.homeManagerModules.default ];

  # Neovim gui wrapper
  programs.neovide = {
    enable = true;
    settings = {
      # TODO: Is this true for all home-manager configurations?
      neovim-bin = "/etc/profiles/per-user/${vars.username}/bin/nvim";
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
