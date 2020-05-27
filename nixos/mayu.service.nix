{ mayu }:

{
  description = "Melancholy of Window Master";
  after = [ "basic.target" ];
  wantedBy = [ "multi-user.target" ];

  serviceConfig = {
    Type = "simple";
    RemainAfterExit = true;
    User = "root";
    ExecStart = "${mayu}/bin/mayu";
    Restart = "always";
  };
}

