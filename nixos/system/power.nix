{ ... }:

{
  services.logind.settings = {
    Login = {
      HandlePowerKey = "lock";

      # Keep the machine up with the lid closed so SSH stays reachable.
      HandleLidSwitch = "ignore";
      HandleLidSwitchDocked = "ignore";
      HandleLidSwitchExternalPower = "ignore";
    };
  };
}
