{ pkgs, config, ... }:

{
    sessionVariables = {
      QT_XCB_GL_INTEGRATION = "none";
    };

    services = {
        kdeconnect = {
            enable = true;
            indicator = true;
        };
    };

#    networking.firewall = rec { -- move to system
#        allowedTCPPortRanges = [
#          {
#            from = 1714;
#            to = 1764;
#          }
#        ];
#        allowedUDPPortRanges = allowedTCPPortRanges;
#    };
}
