{ ... }:

{
    imports = [ <home-manager/nixos> ];

    home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        # Move any pre-existing unmanaged file aside instead of failing
        backupFileExtension = "backup";
        # Set once; never change after first activation
        sharedModules = [
            { home.stateVersion = "26.05"; }
        ];
        users.youruser = {
            imports = [
                ./home-manager/mouse.nix
            ];
        };
    };
}
