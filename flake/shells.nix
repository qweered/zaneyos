{ inputs, ... }:

{
  imports = with inputs; [ agenix-rekey.flakeModule ];

  perSystem =
    { pkgs, config, ... }:
    {
      devShells.default = pkgs.mkShell {
        nativeBuildInputs = [ config.agenix-rekey.package ];
      };
    };
}
