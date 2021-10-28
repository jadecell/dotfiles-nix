{
    services.sanoid = {
        
        enable = true;
        datasets = {
            "rpool/root/nixos" = {
                autosnap = true;
                autoprune = true;
                monthly = 2;
                hourly = 6;
                daily = 7;
            };

            "rpool/home" = {
                autosnap = true;
                autoprune = true;
                monthly = 2;
                hourly = 6;
                daily = 7;
            };
        };

    };    
}
