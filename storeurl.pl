#!/usr/bin/perl
#
# Facebook Group https://www.facebook.com/groups/Mikrotik.Squid.Indonesia
# Forum ubuntu indonesia http://ubuntu-indonesia.com/
#
# Mohon maaf jika saya tidak menyertakan credit pembuat pertama storurl.pl ini
# Saya rasa tidak perlu di cantumkan semua sudah tau ini credit dari siapa
# Thank to all
# My Facebook : https://facebook.com/bintang.bersayap06
#
# NOTE: tambahkan folder youtube di /var/log/squid/
#######################################################################################
$|=1;
while (<>) {
    @X = split;
       $x = $X[0] . " ";
       $_ = $X[1];
       $u = $X[1];

        # Poto Pesbuk
if ($X[1] =~ m/^http\:\/\/[a-zA-Z0-9\-\_\.\%]*fbcdn[a-zA-Z0-9\-\_\.\%]*net\/safe\_image\.php\?(.*)/) {
        print $x . "storeurl://fbcdn.SQUIDINTERNAL/" . $1  . "\n";

} elsif ($X[1] =~ m/^http\:\/\/[a-zA-Z0-9\-\_\.\%]*fbcdn[a-zA-Z0-9\-\_\.\%]*net\/rsrc\.php\/(.*)/) {
        print $x . "storeurl://fbcdn.SQUIDINTERNAL/" . $1  . "\n";

} elsif ($X[1] =~ m/^http\:\/\/[a-zA-Z0-9\-\_\.\%]*fbcdn[a-zA-Z0-9\-\_\.\%]*net\/[a-zA-Z0-9\-\_\.\%]*\/(.*)/) {
        print $x . "storeurl://fbcdn.SQUIDINTERNAL/" . $1  . "\n";

        # Survey Google Menggelitik 
} elsif ($X[1] =~ m/^http:\/\/www\.google-analytics\.com\/__utm.gif\?.*/) {
                print $x . "storeurl://analytic.SQUIDINTERNAL/utm.gif\n";

        # Gambar Video
} elsif ($X[1] =~ m/^http:\/\/video.google.com\/ThumbnailServer.*/) {
        @id = m/[&?](contentid=[a-zA-Z0-9\-\_\.\%]*)/;
                @itag = m/[&?](itag=[a-zA-Z0-9\-\_\.\%]*)/;
        @set = m/[&?](offsetms=[^\&\s]*)/;
                print $x . "storeurl://Thumbnail.SQUIDINTERNAL/@id&@itag&@set\n";
                
        # Video Youtube
} elsif ($X[1] =~ m/^http(|s)\:\/\/.*youtube.*(ptracking|stream_204|player_204|gen_204).*(video_id|docid|v)\=([^\&\s]*).*/){
        $vid = $4 ;
        @cpn = m/[&?]cpn\=([^\&\s]*)/;
        if (defined($vid )) {
                $fn = "/tmp/@cpn";
                unless (-e $fn) {
                        open FH,">".$fn ;
                        print FH "$vid\n";
                        close FH;
                }
        }
        print $x . $X[1] . "\n";
 
} elsif ($X[1] =~ m/^http\:\/\/.*(youtube|google).*videoplayback.*/){
        @itag = m/[&?](itag=[0-9]*)/;
        @ids = m/[&?]id\=([^\&\s]*)/;
        @mime = m/[&?](mime\=[^\&\s]*)/;
        @cpn = m/[&?]cpn\=([^\&\s]*)/;
        if (defined($cpn[0])) {
            $fn = "/tmp/@cpn";
            if (-e $fn) {
                open FH,"<".$fn ;
                $id  = <FH>;
                chomp $id ;
                close FH ;
                  } else {
                $id = $ids[0] ;
            }
        } else {
          $id = $ids[0] ;
        }
        @range = m/[&?](range=[^\&\s]*)/;
        print $x . "http://video-srv.youtube.com.SQUIDINTERNAL/id=" . $id . "&@itag@range@mime\n";

        # Aplikasi Android
} elsif ($X[1] =~ m/^http:\/\/.*\.c\.android\.clients\.google\.com\/market\/GetBinary\/([a-zA-Z0-9\-\_\.\%]*)\/([0-9]*)\/.*/){
                print $x . "storeurl://android-apps.SQUIDINTERNAL/$1/$2\n";
} elsif ($X[1] =~ m/^http:\/\/.*\.c\.android\.clients\.google\.com\/market\/GetBinary\/([a-zA-Z0-9\-\_\.\%]*)\/([0-9]*)\?.*/){
                print $x . "storeurl://android-apps.SQUIDINTERNAL/$1/$2\n";

        # APPS APPLE
} elsif ($X[1] =~ m/^http:\/\/[a-zA-Z0-9\-\_\.\%]*phobos\.apple\.com\/.*\/([a-zA-Z0-9\-\_\.\%]*\.ipa)/) {
                print $x . "storeurl://apple-apps.SQUIDINTERNAL/$1\n";

        #Speedtest
} elsif ($X[1] =~ m/^http\:\/\/.*\/speedtest\/([a-zA-Z0-9\-\_\.\%]*\.(jpg|txt|png|swf))\?.*/) {
        print $x . "storeurl://testspeed.SQUIDINTERNAL/" . $1 . "\n";

        ##################################################################################
        
        ## PORN Movies 
} elsif ($X[1] =~ m/^http:\/\/.*\.xvideos\.com\/.*\/([a-zA-Z0-9\-\_\.\%]*\.(3gp|mpg|flv|mp4))\?.*/){
                print $x . "storeurl://xvideos.SQUIDINTERNAL/$1\n";

} elsif ($X[1] =~ m/^http:\/\/[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+\/.*\/xh.*\/([a-zA-Z0-9\-\_\.\%]*\.flv)/){
                print $x . "storeurl://Xhamster.SQUIDINTERNAL/$1\n";

} elsif ($X[1] =~ m/^http:\/\/[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+.*\/([a-zA-Z0-9\-\_\.\%]*\.flv)\?start=0/){
                print $x . "storeurl://Xhamster2.SQUIDINTERNAL/$1\n";
        
} elsif ($X[1] =~ m/^http:\/\/.*\.youjizz\.com.*\/([a-zA-Z0-9\-\_\.\%]*\.(mp4|flv|3gp))\?.*/){
                print $x . "storeurl://YouJizz.SQUIDINTERNAL/$1\n";

} elsif ($X[1] =~ m/^http:\/\/[a-zA-Z0-9\-\_\.\%]*\.keezmovies[a-zA-Z0-9\-\_\.\%]*\.com.*\/([a-zA-Z0-9\-\_\.\%]*\.(mp4|flv|3gp|mpg|wmv))\?.*/){
                print $x . "storeurl://KeezMovies.SQUIDINTERNAL/$1\n";

} elsif ($X[1] =~ m/^http:\/\/[a-zA-Z0-9\-\_\.\%]*\.tube8[a-zA-Z0-9\-\_\.\%]*\.com.*\/([a-zA-Z0-9\-\_\.\%]*\.(mp4|flv|3gp|mpg|wmv))\?.*/) {
                print $x . "storeurl://Tube8.SQUIDINTERNAL/$1\n";

} elsif ($X[1] =~ m/^http:\/\/[a-zA-Z0-9\-\_\.\%]*\.youporn[a-zA-Z0-9\-\_\.\%]*\.com.*\/([a-zA-Z0-9\-\_\.\%]*\.(mp4|flv|3gp|mpg|wmv))\?.*/){
                print $x . "storeurl://YouPorn.SQUIDINTERNAL/$1\n";

} elsif ($X[1] =~ m/^http:\/\/[a-zA-Z0-9\-\_\.\%]*\.spankwire[a-zA-Z0-9\-\_\.\%]*\.com.*\/([a-zA-Z0-9\-\_\.\%]*\.(mp4|flv|3gp|mpg|wmv))\?.*/) {
                print $x . "storeurl://SpankWire.SQUIDINTERNAL/$1\n";

} elsif ($X[1] =~ m/^http:\/\/[a-zA-Z0-9\-\_\.\%]*\.pornhub[a-zA-Z0-9\-\_\.\%]*\.com.*\/([[a-zA-Z0-9\-\_\.\%]*\.(mp4|flv|3gp|mpg|wmv))\?.*/){
                print $x . "storeurl://PornHub.SQUIDINTERNAL/$1\n";

} elsif ($X[1] =~ m/^http:\/\/[a-zA-Z0-9\-\_\.\%\/]*.*\/([a-zA-Z0-9\-\_\.]+\.(flv|mp3|mp4|3gp|wmv))\?.*cdn\_hash.*/){
                print $x . "storeurl://media.SQUIDINTERNAL/$1\n";

        ###################################################################################

        ## FileHippo
} elsif ($X[1] =~ m/^http:\/\/.*filehippo\.com\/.*\/([0-9a-zA-Z\%\.\_\-]+\.(exe|zip|cab|msi|mru|mri|bz2|gzip|tgz|rar|pdf))/){
                $y=$1;
                for ($y) {
                        s/%20//g;
                }
                print $x . "storeurl://FileHippo.SQUIDINTERNAL/$y\n";

                #BLOGSPOT
} elsif ($X[1] =~ m/^http:\/\/[1-4]\.bp\.blogspot\.com\/(.*)/) {
				print $x . "storeurl://blogspot.SQUIDINTERNAL/" . $1  . "\n";

                #ytimg
} elsif ($X[1] =~ m/^http:\/\/i[1-4]\.ytimg\.com(.*)/) {
                print $x . "storeurl://ytimg.SQUIDINTERNAL" . $1  . "\n";

                #AVAST
} elsif ($X[1] =~ m/^http:\/\/download[0-9]{3}\.avast\.com\/(.*)/) {
                print $x . "storeurl://avast.SQUIDINTERNAL/" . $1  .  "\n";

                #KAV
} elsif ($X[1] =~ m/^http:\/\/dnl-[0-9]{2}\.geo\.kaspersky\.com\/(.*)/) {
                print $x . "storeurl://kaspersky.SQUIDINTERNAL/" . $1  .  "\n";

                #maps.google.com
} elsif ($X[1] =~ m/^http:\/\/(cbk|mt|khm|mlt|tbn|mw)[0-9]?\.google\.co(m|\.uk|\.id)\/(.*)/) {
				print $x . "storeurl://google.SQUIDINTERNAL/" . $3 . "\n";

                #gstatic and/or wikimapia
} elsif ($X[1] =~ m/^http:\/\/([a-z])[0-9]?(\.gstatic\.com.*|\.wikimapia\.org)\/(.*)/) {
				print $x . "storeurl://wikimapia.SQUIDINTERNAL/" . $3 . "\n";


                #Cache High Latency Ads
} elsif ($X[1] =~ m/^http:\/\/([a-z0-9.]*)(\.doubleclick\.net|\.quantserve\.com|\.googlesyndication\.com|yieldmanager|cpxinteractive)(.*)/) {
        $y = $3;$z = $2;
        for ($y) {
        s/pixel;.*/pixel/;
        s/activity;.*/activity/;
        s/(imgad[^&]*).*/\1/;
        s/;ord=[?0-9]*//;
        s/;&timestamp=[0-9]*//;
        s/[&?]correlator=[0-9]*//;
        s/&cookie=[^&]*//;
        s/&ga_hid=[^&]*//;
        s/&ga_vid=[^&]*//;
        s/&ga_sid=[^&]*//;
        # s/&prev_slotnames=[^&]*//
        # s/&u_his=[^&]*//;
        s/&dt=[^&]*//;
        s/&dtd=[^&]*//;
        s/&lmt=[^&]*//;
        s/(&alternate_ad_url=http%3A%2F%2F[^(%2F)]*)[^&]*/\1/;
        s/(&url=http%3A%2F%2F[^(%2F)]*)[^&]*/\1/;
        s/(&ref=http%3A%2F%2F[^(%2F)]*)[^&]*/\1/;
        s/(&cookie=http%3A%2F%2F[^(%2F)]*)[^&]*/\1/;
        s/[;&?]ord=[?0-9]*//;
        s/[;&]mpvid=[^&;]*//;
        s/&xpc=[^&]*//;
        # yieldmanager
        s/\?clickTag=[^&]*//;
        s/&u=[^&]*//;
        s/&slotname=[^&]*//;
        s/&page_slots=[^&]*//;
        }
        print $x . "storeurl://" . $1 . $2 . $y . "\n";

                #cache high latency ads
} elsif ($X[1] =~ m/^http:\/\/(.*?)\/(ads)\?(.*?)/) {
        print $x . "storeurl://" . $1 . "/" . $2  . "\n";

} elsif ($X[1] =~ m/^http:\/\/(www\.ziddu\.com.*\.[^\/]{3,4})\/(.*?)/) {
        print $x . "storeurl://" . $1 . "\n";

                #cdn, varialble 1st path
} elsif (($X[1] =~ /filehippo/) && ($X[1] =~ m/^http:\/\/(.*?)\.(.*?)\/(.*?)\/(.*)\.([a-z0-9]{3,4})(\?.*)?/)) {
        @y = ($1,$2,$4,$5);
        $y[0] =~ s/[a-z0-9]{2,5}/cdn./;
        print $x . "storeurl://" . $y[0] . $y[1] . "/" . $y[2] . "." . $y[3] . "\n";

                #rapidshare
} elsif (($X[1] =~ /rapidshare/) && ($X[1] =~ m/^http:\/\/(([A-Za-z]+[0-9-.]+)*?)([a-z]*\.[^\/]{3}\/[a-z]*\/[0-9]*)\/(.*?)\/([^\/\?\&]{4,})$/)) {
        print $x . "storeurl://cdn." . $3 . "/SQUIDINTERNAL/" . $5 . "\n";

} elsif (($X[1] =~ /maxporn/) && ($X[1] =~ m/^http:\/\/([^\/]*?)\/(.*?)\/([^\/]*?)(\?.*)?$/)) {
        print $x . "storeurl://" . $1 . "/SQUIDINTERNAL/" . $3 . "\n";
        
                #domain/path/.*/path/filename
} elsif (($X[1] =~ /fucktube/) && ($X[1] =~ m/^http:\/\/(.*?)(\.[^\.\-]*?[^\/]*\/[^\/]*)\/(.*)\/([^\/]*)\/([^\/\?\&]*)\.([^\/\?\&]{3,4})(\?.*?)$/)) {
        @y = ($1,$2,$4,$5,$6);
        $y[0] =~ s/(([a-zA-A]+[0-9]+(-[a-zA-Z])?$)|([^\.]*cdn[^\.]*)|([^\.]*cache[^\.]*))/cdn/;
        print $x . "storeurl://" . $y[0] . $y[1] . "/" . $y[2] . "/" . $y[3] . "." . $y[4] . "\n";

                #like porn hub variables url and center part of the path, filename etention 3 or 4 with or without ? at the end
} elsif (($X[1] =~ /tube8|pornhub|xvideos/) && ($X[1] =~ m/^http:\/\/(([A-Za-z]+[0-9-.]+)*?(\.[a-z]*)?)\.([a-z]*[0-9]?\.[^\/]{3}\/[a-z]*)(.*?)((\/[a-z]*)?(\/[^\/]*){4}\.[^\/\?]{3,4})(\?.*)?$/)) {
        print $x . "storeurl://cdn." . $4 . $6 . "\n";

                #general purpose for cdn servers. add above your specific servers.
} elsif ($X[1] =~ m/^http:\/\/([0-9.]*?)\/\/(.*?)\.(.*)\?(.*?)/) {
        print $x . "storeurl://squid-cdn-url/" . $2  . "." . $3 . "\n";

} elsif ($X[1] =~ m/^http:\/\/(.*?)(\.[^\.\-]*?\..*?)\/([^\?\&\=]*)\.([\w\d]{2,4})\??.*$/) {
        @y = ($1,$2,$3,$4);
        $y[0] =~ s/([a-z][0-9][a-z]dlod[\d]{3})|((cache|cdn)[-\d]*)|([a-zA-A]+-?[0-9]+(-[a-zA-Z]*)?)/cdn/;
        print $x . "storeurl://" . $y[0] . $y[1] . "/" . $y[2] . "." . $y[3] . "\n";

                        # all that ends with ;
} elsif ($X[1] =~ m/^http:\/\/(.*?)\/(.*?)\;(.*)/) {
        print $x . "storeurl://" . $1 . "/" . $2  . "\n";
                
} else {
                print $x . $X[1] . "\n";
}
# end
}