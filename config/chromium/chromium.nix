pkgs:
{
  enable = true;
  package = pkgs.ungoogled-chromium;
  extensions = [

    { id = "nngceckbapebfimnlniiiahkandclblb"; } # Bitwarden 
    { id = "eimadpbcbfnmbkopoojfekhnkhdbieeh"; } # Dark Reader 
    { id = "ldpochfccmkkmhdbclfhpagapcfdljkj"; } # Decentraleyes
    { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # uBlock Origin 
    { id = "mjdepdfccjgcndkmemponafgioodelna"; } # Distraction Free YouTube
    { id = "mnjggcdmjocbbbhaepdhchncahnbgone"; } # SponsorBlock for YouTube 
    { id = "fgmjlmbojbkmdpofahffgcpkhkngfpef"; } # Startpage - Private Search Engine 
    { id = "phdgkjdkmiilimbjbofcnoikhanohflg"; } # Black Theme

  ];
}
