pkgs:
{
  enable = true;
  autoReload = true;

  extraConfig = "
bind-key j down
bind-key k up
bind-key j next articlelist
bind-key k prev articlelist
bind-key J next-feed articlelist
bind-key K prev-feed articlelist
bind-key G end
bind-key g home
bind-key d pagedown
bind-key u pageup
bind-key l open
bind-key h quit
bind-key a toggle-article-read
bind-key n next-unread
bind-key N prev-unread
bind-key D pb-download
bind-key U show-urls
bind-key x pb-delete

color listnormal green default
color listfocus yellow default bold
color listnormal_unread blue default
color listfocus_unread magenta default bold
color info red default bold
color article white default bold

browser linkhandler
macro , open-in-browser
macro w set browser \"brave\" ; open-in-browser ; set browser linkhandler
macro v set browser \"mpv\" ; open-in-browser ; set browser linkhandler
macro c set browser \"echo %u | xclip -r -sel c\" ; open-in-browser ; set browser linkhandler

highlight all \"---.*---\" red
highlight feedlist \".*(0/0))\" black
highlight article \"(^Feed:.*|^Title:.*|^Author:.*)\" cyan default bold
highlight article \"(^Link:.*|^Date:.*)\" default default
highlight article \"https?://[^ ]+\" green default
highlight article \"^(Title):.*$\" blue default
highlight article \"\\\\[[0-9][0-9]*\\\\]\" magenta default bold
highlight article \"\\\\[image\\\\ [0-9]+\\\\]\" green default bold
highlight article \"\\\\[embedded flash: [0-9][0-9]*\\\\]\" green default bold
highlight article \":.*\\\\(link\\\\)$\" cyan default
highlight article \":.*\\\\(image\\\\)$\" blue default
highlight article \":.*\\\\(embedded flash\\\\)$\" magenta default
  ";

  urls = [
    { url = "https://www.reddit.com/r/linux.rss "; title = "r/linux"; }  
    { url = "https://www.reddit.com/r/archlinux.rss "; title = "r/archlinux"; }  
    { url = "https://www.reddit.com/r/gentoo.rss "; title = "r/gentoo"; }  
    { url = "https://www.reddit.com/r/linuxmasterrace.rss "; title = "r/linuxmasterrace"; }  
    { url = "https://www.gentoo.org/feeds/news.xml "; title = "Gentoo Linux News"; }  
    { url = "https://www.archlinux.org/feeds/news/"; title = "Arch Linux News"; }  
    { url = "https://distrowatch.com/news/dwd.xml"; title = "DistroWatch"; }  
    { url = "https://www.kernel.org/feeds/kdist.xml "; title = "Linux Kernel"; }  
    { url = "https://itsfoss.com/feed/"; title = "It's Foss"; }  
    { url = "https://techrepublic.com/rssfeeds/topic/open-source/"; title = "Tech Republic"; }  
    { url = "http://feeds.feedburner.com/d0od"; title = "OMG Ubuntu"; }  
    { url = "https://opensource.com/feed"; title = "Opensource"; }  
    { url = "https://www.zdnet.com/topic/linux/rss.xml"; title = "ZDNet"; }  
    { url = "https://lukesmith.xyz/rss.xml"; title = "Luke's Website"; }  
    { url = "https://notrelated.libsyn.com/rss"; title = "Not Related"; }  
  ];
}
