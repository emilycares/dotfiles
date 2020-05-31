set fish_greeting

cat ~/.cache/wal/sequences  &

starship init fish | source

export ANDROID_HOME="/usr/local/android/sdk/"
export ANDROID_HOME="/data/home/michael/Android/Sdk/"
export PATH="$PATH:$ANDROID_HOME/tools/:$ANDROID_HOME/platform-tools/"

export EDITOR='nvim'

export PATH="$PATH:$HOME/.config/composer/vendor/bin/"
export PATH="$PATH:/data/home/michael/tools/istio-1.5.2/bin"
export PATH="$PATH:/usr/lib/dart/bin"
export PATH="$PATH:/data/home/michael/tools/flutter/bin"

set NPM_PACKAGES "$HOME/.npm-packages"

set PATH "$NPM_PACKAGES/bin:$PATH"
set -e MANPATH
set MANPATH "$NPM_PACKAGES/share/man:$manpath"

set NODE_PATH "$NPM_PACKAGES/lib/node_modules:$NODE_PATH"

alias yt='docker run --rm -u (id -u):(id -g) -v $PWD:/data vimagick/youtube-dl'
alias music='mpv --no-video --input-ipc-server=/tmp/mpvsocket --playlist=music/soundcloud/playlist.m3u'
alias phone='~/Android/Sdk/emulator/emulator -avd Pixel_3_XL_API_29 -netdelay none -netspeed full'

set LESS_TERMCAP_mb (tput bold && tput setaf 2)
set LESS_TERMCAP_md (tput bold && tput setaf 2)
set LESS_TERMCAP_so (tput bold && tput setaf 3)
set LESS_TERMCAP_se (tput rmso && tput sgr0)
set LESS_TERMCAP_us (tput smul && tput bold && tput setaf 1)
set LESS_TERMCAP_me (tput sgr0)

set PATH "$PATH:`yarn global bin`"

set PATH "/data/home/michael/perl5/bin$PATH:+:$PATH"; export PATH;
set PERL5LIB "/data/home/michael/perl5/lib/perl5$PERL5LIB:+:$PERL5LIB"; export PERL5LIB;
set PERL_LOCAL_LIB_ROOT "/data/home/michael/perl5$PERL_LOCAL_LIB_ROOT:+:$PERL_LOCAL_LIB_ROOT"; export PERL_LOCAL_LIB_ROOT;
set PERL_MB_OPT "--install_base \"/data/home/michael/perl5\""; export PERL_MB_OPT;
set PERL_MM_OPT "INSTALL_BASE=/data/home/michael/perl5"; export PERL_MM_OPT;

