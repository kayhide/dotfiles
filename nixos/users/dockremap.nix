{ config, pkgs, ... }:

{
  config.users = {
    users = {
      dockremap = {
        isSystemUser = true;
        uid = 114;
        group = "dockremap";
        subUidRanges = [
          { startUid = 1000; count = 1; }
          { startUid = 100000; count = 65536; }
        ];
        subGidRanges = [
          { startGid = 100; count = 1; }
          { startGid = 100000; count = 65536; }
        ];
      };
    };

    groups = {
      dockremap = {
        gid = 114;
      };
    };
  };
}

