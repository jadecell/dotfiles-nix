pkgs:
{
    enable = true;
    extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        decentraleyes
        startpage-private-search
        bitwarden
        ublock-origin
        clearurls
        sponsorblock
        darkreader
        h264ify
        df-youtube
    ];
    profiles.jackson = {
        settings = {
            "media.peerconnection.enabled" = false;
            "media.peerconnection.turn.disable" = true;
            "media.peerconnection.use_document_iceservers" = false;
            "media.peerconnection.video.enabled" = false;
            "media.peerconnection.identity.timeout" = 1;
            "privacy.firstparty.isolate" = true;
            "privacy.resistFingerprinting" = true;
            "privacy.trackingprotection.fingerprinting.enabled" = true;
            "privacy.trackingprotection.cryptomining.enabled" = true;
            "privacy.trackingprotection.enabled" = true;
            "privacy.donottrackheader.enabled" = true;
            "browser.send_pings" = false;
            "browser.aboutConfig.showWarning" = false;
            "browser.tabs.warnOnClose" = false;
            "browser.urlbar.speculativeConnect.enabled" = false;
            "dom.event.clipboardevents.enabled" = false;
            "dom.forms.autocomplete.formautofill" = false;
            "media.navigator.enabled" = false;
            "network.cookie.cookieBehavior" = 1;
            "network.http.referer.XOriginPolicy" = 2;
            "network.http.referer.XOriginTrimmingPolicy" = 2;
            "beacon.enabled" = false;
            "browser.safebrowsing.downloads.remote.enabled" = false;
            "network.dns.disablePrefetch" = true;
            "network.dns.disablePrefetchFromHTTPS" = true;
            "network.predictor.enabled" = false;
            "network.predictor.enable-prefetch" = false;
            "network.prefetch-next" = false;
            "network.IDN_show_punycode" = true;
            "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
            "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
            "browser.newtabpage.activity-stream.feeds.topsites" = false;
            "app.shield.optoutstudies.enabled" = false;
            "dom.security.https_only_mode_ever_enabled" = true;
            "dom.security.https_only_mode" = true;
            "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
            "browser.toolbars.bookmarks.visibility" = "never";
            "browser.search.suggest.enabled" = false;
            "browser.urlbar.shortcuts.bookmarks" = false;
            "browser.urlbar.shortcuts.history" = false;
            "browser.urlbar.shortcuts.tabs" = false;
            "browser.urlbar.suggest.bookmark" = false;
            "browser.urlbar.suggest.engines" = false;
            "browser.urlbar.suggest.history" = false;
            "browser.urlbar.suggest.openpage" = false;
            "browser.urlbar.suggest.topsites" = false;
            "browser.uidensity" = 1;
            "media.autoplay.enabled" = false;
            "media.eme.enabled" = true;
            "extensions.pocket.enabled" = false;
            "identity.fxaccounts.enabled" = false;
            "toolkit.zoomManager.zoomValues" = ".8,.95,1,1.1,1.2";
            "toolkit.telemetry.reportingpolicy.firstRun" = false;
            "toolkit.telemetry.pioneer-new-studies-available" = false;
            "signon.autofillForms" = false;
            "signon.generation.enabled" = false;
            "toolkit.telemetry.cachedClientID" = "c0ffeec0-ffee-c0ff-eec0-ffeec0ffeec0";
            "toolkit.telemetry.firstShutdownPing.enabled" = false;
            "toolkit.telemetry.newProfilePing.enabled" = false;
            "browser.safebrowsing.downloads.remote.block_dangerous" = false;
            "browser.safebrowsing.downloads.remote.block_dangerous_host" = false;
            "browser.safebrowsing.downloads.remote.block_potentially_unwanted" = false;
            "browser.safebrowsing.downloads.remote.block_uncommon" = false;
        };
        userChrome = "
            * { 
                box-shadow: none !important;
                border: 0px solid !important;
            }
        ";
        bookmarks = {
            "Plex" = {
                url = "https://server1355.seedhost.eu:30422/web";
            };
            "Deluge" = {
                url = "https://server1355.seedhost.eu/jadecell/deluge/";
            };
            "Torrent Galaxy" = { 
                url = "https://torrentgalaxy.to";
            };
            "YTS" = { 
                url = "https://yts.rs/"; 
            };
            "EZTV" = { 
                url = "https://eztv.re";
            };
        };
    };
}
