{ ... }:

{
  services.logind.settings = {
    Login = {
      HandlePowerKey = "lock";
    };
  };
}
