{ pkgs, ... }:
{
  # Use a specific nodejs version for better reproducibility
  # Users can override this by setting home.packages with their preferred version
  home.packages = [ pkgs.nodejs_22 ];
  
  # Set nodejs environment variables for better package management
  home.sessionVariables = {
    # Prevent npm from using global packages and encourage local installs
    NPM_CONFIG_PREFIX = "$HOME/.npm-global";
  };
}
