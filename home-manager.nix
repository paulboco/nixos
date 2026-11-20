{ ... }:

{
    # Fetched at build time, so no nix-channel step is needed.
    # The release must match nixpkgs (26.05). To pin an exact version,
    # see "Optional: pin the version" in home-manager-setup.md.
    imports = [
        "${builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-26.05.tar.gz"}/nixos"
    ];

    home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;

        # Move any pre-existing unmanaged file aside instead of failing
        backupFileExtension = "backup";

        # paulboco imports
        users.paulboco = {
            imports = [
                ./home-manager/dolphin.nix
                ./home-manager/konsole.nix
                ./home-manager/mouse.nix
                ./home-manager/kate.nix
            ];
        };

        # Set once; never change after first activation
        sharedModules = [
            { home.stateVersion = "26.05"; }
        ];
    };
}
