# source to own .zshrc

BLACK="%{"$'\033[01;30m'"%}"
GREEN="%{"$'\033[01;32m'"%}"
RED="%{"$'\033[01;31m'"%}"
YELLOW="%{"$'\033[01;33m'"%}"
BLUE="%{"$'\033[01;34m'"%}"
BOLD="%{"$'\033[01;39m'"%}"
NORM="%{"$'\033[00m'"%}"

export KEYTIMEOUT=1

# Doesn't work that well for now.
# mount | grep "${HOME}/gdrive" || { which google-drive-ocamlfuse &> /dev/null && google-drive-ocamlfuse "${HOME}/gdrive"; }

# Setup 'https://github.com/odeke-em/drive' first:
# $ mkdir gdrive
# $ cd gdrive
# $ drive init
# $ drive pull develop/

# Reference: https://github.com/bamos/zsh-history-analysis
export HISTSIZE=1000000000
export SAVEHIST=$HISTSIZE
setopt EXTENDED_HISTORY

# Uses the really old https://github.com/olivierverdier/zsh-git-prompt (still works).
# There's a new one: https://github.com/zsh-git-prompt/zsh-git-prompt, but it seems to
# not work, specifically the check mark when git is up-to-date. So, keeping the old one.
GIT_PROMPT_EXECUTABLE="haskell"
source ~/.zsh-git-prompt/zshrc.sh
ZSH_GIT_PROMPT_SHOW_UPSTREAM=1

# \U1F7E2 - green circle
# \U1F538 - small orange diamond

# Check if running in GCP:
[ -x "$(command -v systemctl)" ] && systemctl is-active --quiet google-osconfig-agent
if [ $? -ne 0 ]; then
  if [ -z "${CUSTOM_HOST}" ]; then
    PROMPT='${GREEN}%n@%m${YELLOW}:%l${NORM}:[%1c${NORM}]$(git_super_status)'$'\U1F538'
  else
    PROMPT='${GREEN}%n@${CUSTOM_HOST}${YELLOW}:%l${NORM}:[%1c${NORM}]$(git_super_status)'$'\U1F538'
  fi
else
  # So we know that we are running in GCP (via SSH).
  PROMPT='${GREEN}%n@%m${RED}:%l${NORM}:[%1c${NORM}]$(git_super_status)'$'\U1F538'
fi

alias l='ls -lF'
alias ll='ls -laF'
alias h='htop'
alias x='exit'

if [ "$(uname 2> /dev/null)" = "Linux" ]; then
  # https://wiki.archlinux.org/title/Hardware_video_acceleration
  export LIBVA_DRIVER_NAME=nvidia
  export VDPAU_DRIVER=nvidia
  export EDITOR=vim
  alias v="${EDITOR}"
  alias e="emacs"
  # export EDITOR="emacs -nw"
  alias up='sudo apt update && apt list --upgradable; brew update -v && brew upgrade -v; flatpak update -y; sudo snap refresh;'
  alias upve='pushd ~/; $EDITOR +PluginUpdate +qall && $EDITOR +GoUpdateBinaries +qall && ~/.files/gotools.sh && rm -rfv /tmp/vim-go* && git -C ~/.emacs.d/ pull && emacs --batch -l ~/.emacs.d/init.el --eval="(configuration-layer/update-packages t)" 2>&1 | tee /tmp/emacs-update && grep -i -E "Found.*to.*update.*" /tmp/emacs-update && emacs; popd;'
  alias upv='UPV_DIR=$PWD; cd $HOME/; $EDITOR +PluginUpdate +qall && $EDITOR +GoUpdateBinaries +qall; cd $UPV_DIR'
  # alias upe='UPE_DIR=$PWD; cd $HOME/; ~/.files/gotools.sh && git -C ~/.emacs.d/ pull && emacs --batch -l ~/.emacs.d/init.el --eval="(configuration-layer/update-packages t)" 2>&1 | tee /tmp/emacs-update && grep -i -E "Found.*to.*update.*" /tmp/emacs-update && emacs; cd $UPE_DIR'
  alias tupe='UPE_DIR=$PWD; cd $HOME/; ~/.files/gotools.sh && e --batch -l ~/.emacs.d/init.el --eval="(configuration-layer/update-packages t)" 2>&1 | tee /tmp/emacs-update && grep -i -E "Found.*to.*update.*" /tmp/emacs-update && e; cd $UPE_DIR'
  if [ -x "$(command -v cmus-remote)" ]; then
    alias cr='cmus-remote'
  fi
fi

alias e="emacs -nw"
alias gls='gcloud compute instances list'

if [ "$(uname 2> /dev/null)" = "Darwin" ]; then
  export EDITOR="emacs -nw"
  alias v="${EDITOR}"
  alias up='brew update --verbose && brew upgrade --verbose'
  alias meld='/Applications/Meld.app/Contents/MacOS/Meld'
  export PATH=$PATH:~/Library/Python/3.7/bin:$(python3 -m site --user-base)/bin
fi

alias upe='UPE_DIR=$PWD; cd $HOME/; ~/.files/gotools.sh && git -C ~/.emacs.d/ pull && e --batch -l ~/.emacs.d/init.el --eval="(configuration-layer/update-packages t)" 2>&1 | tee /tmp/emacs-update && grep -i -E "Found.*to.*update.*" /tmp/emacs-update && emacs; cd $UPE_DIR'

export GOPRIVATE="github.com/mobingilabs/*,github.com/alphauslabs/*"
export GOPATH=$HOME/gopath
export GOPROXY=https://proxy.golang.org
export GOCACHE=$HOME/tmp/gocache
export PATH=$PATH:$GOPATH/bin:$HOME/.cargo/bin:$HOME/.npm-global/bin:$HOME/.rbenv/bin:$HOME/.rbenv/plugins/ruby-build/bin:/usr/share/bcc/tools:$HOME/data/flutter/bin:$HOME/bin

if [ "$(uname 2> /dev/null)" = "Linux" ]; then
  export PATH=$PATH:$HOME/data2/flutter/bin
  export ANDROID_HOME=$HOME/Android/Sdk
fi

if [ "$(uname 2> /dev/null)" = "Darwin" ]; then
  export PATH=$PATH:$HOME/develop/flutter/bin
fi

# Edit $PATH after Homebrew's eval (see ~/.profile) so I can use native(?) binaries first before brew.
NOHBPATH=$(echo $PATH | awk '{gsub(/:.*linuxbrew.*brew\/sbin|:.*homebrew\/bin|\/opt\/homebrew\/bin/,"");print}'); export PATH=$NOHBPATH
export PATH=$PATH:/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:/opt/homebrew/bin

if [ -x "$(command -v rustc)" ]; then
  export RUST_SRC_PATH=`rustc --print sysroot`/lib/rustlib/src/rust/src
fi

eval "$(rbenv init -)"

# for Go1.11
export GO111MODULE=on

# Change 'ls' color for directory (I don't like the default blue).
# Reference: http://askubuntu.com/questions/466198/how-do-i-change-the-color-for-directories-with-ls-in-the-console
# Change to 'underlined orange', but looks like muted yellow, really.
# When using Putty though, this is not needed as blue is somewhat okay.
LS_COLORS=$LS_COLORS:'di=1;33'
export LS_COLORS

# base directory for git-get
export GITGET_ROOT=$HOME/develop

# zsh-bd
# https://github.com/Tarrasch/zsh-bd
. $HOME/.zsh/plugins/bd/bd.zsh

# kubectl shortcuts
alias kc='kubectl config get-contexts'
alias kp='kubectl get pod -o wide'
alias kd='kubectl get deployment -o wide'
alias ks='kubectl get svc -o wide'
alias ki='kubectl get ingress'
alias kn='kubectl get node -o wide'
alias kt='kubectl top'
alias k='kubectl'
alias kx='kubectx'
alias b='bluectl'

alias awsdev='echo -n "--region $AWS_REGION --key $AWS_ACCESS_KEY_ID_ASSUME --secret $AWS_SECRET_ACCESS_KEY_ASSUME --rolearn $ROLE_ARN"'
alias awsqa='echo -n "--region $AWS_REGION --key $AWS_ACCESS_KEY_ID_ASSUME_QA --secret $AWS_SECRET_ACCESS_KEY_ASSUME_QA --rolearn $ROLE_ARN_QA"'
alias awsnext='echo -n "--region $AWS_REGION --key $AWS_ACCESS_KEY_ID_ASSUME_NEXT --secret $AWS_SECRET_ACCESS_KEY_ASSUME_NEXT --rolearn $ROLE_ARN_NEXT"'
alias awsprod='echo -n "--region $AWS_REGION --key $AWS_ACCESS_KEY_ID_ASSUME_PROD --secret $AWS_SECRET_ACCESS_KEY_ASSUME_PROD --rolearn $ROLE_ARN_PROD"'
alias awsalmprod='echo -n "--region $AWS_REGION --key $AWS_ACCESS_KEY_ID_ASSUME_PROD --secret $AWS_SECRET_ACCESS_KEY_ASSUME_PROD --rolearn $ROLE_ARN_ALMPROD"'

# Switching GKE clusters.
alias kdev='gcloud config configurations activate default && gcloud container clusters get-credentials $(gcloud container clusters list | grep -i dev | cut -f 1 -d " ")'
alias knext='gcloud config configurations activate mochi-prod && gcloud container clusters get-credentials $(gcloud container clusters list | grep -i next | cut -f 1 -d " ")'
alias kprod='gcloud config configurations activate mochi-prod && gcloud container clusters get-credentials $(gcloud container clusters list | grep -i prod | cut -f 1 -d " ")'
alias kcur='gcloud config configurations activate mochi-prod && gcloud container clusters --zone asia-northeast1-b get-credentials $(gcloud container clusters list | grep -i curmx | cut -f 1 -d " ")'
alias kjuno='gcloud config configurations activate mochi-prod && gcloud container clusters --zone asia-northeast1-a get-credentials $(gcloud container clusters list | grep -i juno | cut -f 1 -d " ")'
if [ "$(uname 2> /dev/null)" = "Darwin" ]; then
  alias kue4='gcloud config configurations activate mochi-prod && gcloud container clusters --region us-east4 get-credentials $(gcloud container clusters list | grep -i us-east4 | cut -f 1 -d " ")'
else
  alias kue4="gcloud config configurations activate mochi-prod && gcloud container clusters --region us-east4 get-credentials $(gcloud container clusters list > /tmp/out && cat /tmp/out | grep -oi -E '^us-east4.*$' | awk '{ print $1 }')"
fi
# alias kcfg='gcloud config configurations activate mochi-prod && gcloud container clusters --region us-east1 get-credentials mcx-us-east1-cfg-ping'
alias kcfg='gcloud config configurations activate mochi-prod && gcloud container clusters --region us-east1 get-credentials $(gcloud container clusters list | grep -i cfg | cut -f 1 -d " ")'

# log shortcuts
# spanner.*[0-9]s$
alias tracem="stern sapphired -s 1s --max-log-requests 1000 -c sapphired | grep -i -E '\[cleanup\]|cleanup.*failed|\[summary|csv\]|cleanupall|distri|progress=.*input=.*date=[0-9]{4}-[0-9]{2}-[0-9]{2}|failed.*|ccf\]|accts=.*runid=.*|notify=true|broadcast=|leader.active.*\(me|heartbeat:.*|[0-9]*m[0-9]*\.[0-9]*s$|dbg\]|cur\.go|fees\]|invoice.*duration.*|invoice\.go|run\.go|bq.load'"
alias tcur="stern --context=gke_mobingi-main_asia-northeast1-b_curmx curmxd -c curmxd -s 1s | grep -i -E '[a-z]*\.go|process\ duration.*|sent.*|not\ updated.*|failed.*|leader.active.*|heartbeat.*|diff=[0-9]*|hedge|[1-9]{1,50}h[0-9]{1,100}m[0-9]*\.[0-9]*s$|[0-9]{1,100}m[0-9]*\.[0-9]*s$|attempt.*'"

# getting tokens
alias rtokenrootdev='ccf token --login-url logindev.mobingi.com/ripple --username $MOBINGI_RIPPLE_ROOT_USERNAME --password $MOBINGI_RIPPLE_ROOT_PASSWORD --client-id $MOBINGI_RIPPLE_OPENID_WEB_CLIENT_ID --client-secret $MOBINGI_RIPPLE_OPENID_WEB_CLIENT_SECRET'
alias rtokenrootprod='ccf token --login-url login.mobingi.com/ripple --username $MOBINGI_RIPPLE_ROOT_USERNAME_PROD --password $MOBINGI_RIPPLE_ROOT_PASSWORD_PROD --client-id $MOBINGI_RIPPLE_OPENID_WEB_CLIENT_ID_PROD --client-secret $MOBINGI_RIPPLE_OPENID_WEB_CLIENT_SECRET_PROD'
alias rtokendev='ccf token --login-url logindev.mobingi.com/ripple --username $MOBINGI_RIPPLE_USERNAME --password $MOBINGI_RIPPLE_PASSWORD --client-id $MOBINGI_RIPPLE_OPENID_WEB_CLIENT_ID --client-secret $MOBINGI_RIPPLE_OPENID_WEB_CLIENT_SECRET'
alias rtokenprod='ccf token --login-url login.mobingi.com/ripple --username $MOBINGI_RIPPLE_USERNAME_PROD --password $MOBINGI_RIPPLE_PASSWORD_PROD --client-id $MOBINGI_RIPPLE_OPENID_WEB_CLIENT_ID_PROD --client-secret $MOBINGI_RIPPLE_OPENID_WEB_CLIENT_SECRET_PROD'

alias tokenrootdev='ccf token --login-url logindev.mobingi.com --username $MOBINGI_ROOT_USERNAME --password $MOBINGI_ROOT_PASSWORD --client-id $MOBINGI_OPENID_WEB_CLIENT_ID --client-secret $MOBINGI_OPENID_WEB_CLIENT_SECRET'
alias tokenrootprod='ccf token --login-url login.mobingi.com --username $MOBINGI_ROOT_USERNAME_PROD --password $MOBINGI_ROOT_PASSWORD_PROD --client-id $MOBINGI_OPENID_WEB_CLIENT_ID_PROD --client-secret $MOBINGI_OPENID_WEB_CLIENT_SECRET_PROD'
alias tokendev='ccf token --login-url logindev.mobingi.com --username $MOBINGI_USERNAME --password $MOBINGI_PASSWORD --client-id $MOBINGI_OPENID_WEB_CLIENT_ID --client-secret $MOBINGI_OPENID_WEB_CLIENT_SECRET'
alias tokenprod='ccf token --login-url login.mobingi.com --username $MOBINGI_USERNAME_PROD --password $MOBINGI_PASSWORD_PROD --client-id $MOBINGI_OPENID_WEB_CLIENT_ID_PROD --client-secret $MOBINGI_OPENID_WEB_CLIENT_SECRET_PROD'

alias rkeydev='ccf token --login-url logindev.mobingi.com/ripple --client-id $OPENAPI_ID_DEV --client-secret $OPENAPI_SECRET_DEV --grant-type client_credentials'
alias rkeyqa='ccf token --login-url loginqa.mobingi.com/ripple --client-id $OPENAPI_ID_QA --client-secret $OPENAPI_SECRET_QA --grant-type client_credentials'
alias rkeynext='ccf token --login-url loginnext.alphaus.cloud/ripple --client-id $OPENAPI_ID_NEXT --client-secret $OPENAPI_SECRET_NEXT --grant-type client_credentials'
alias rkeyprod='ccf token --login-url login.alphaus.cloud/ripple --client-id $OPENAPI_ID_PROD --client-secret $OPENAPI_SECRET_PROD --grant-type client_credentials'

alias rbluetokendev='ccf token --login-url logindev.alphaus.cloud/ripple --client-id $CCOE_ID_DEV --client-secret $CCOE_SECRET_DEV --grant-type client_credentials'
alias rbluetokensubdev='ccf token --login-url logindev.alphaus.cloud/ripple --client-id $RIPPLE_TESTER_CLIENT_ID_DEV --client-secret $RIPPLE_TESTER_CLIENT_SECRET_DEV --grant-type client_credentials'
alias rbluetokennext='bluectl access-token --client-id $CCOE_ID_NEXT --client-secret $CCOE_SECRET_NEXT --beta'
alias rbluetokensubnext='bluectl access-token --client-id $RIPPLE_TESTER_CLIENT_ID_NEXT --client-secret $RIPPLE_TESTER_CLIENT_SECRET_NEXT --beta'
alias rbluetoken='bluectl access-token --client-id $CCOE_ID_PROD --client-secret $CCOE_SECRET_PROD'
alias rbluetokensub='bluectl access-token --client-id $RIPPLE_TESTER_CLIENT_ID_PROD --client-secret $RIPPLE_TESTER_CLIENT_SECRET_PROD'

alias bluetokensubdev='ccf token --login-url logindev.alphaus.cloud --client-id $WAVE_TESTER_CLIENT_ID_DEV --client-secret $WAVE_TESTER_CLIENT_SECRET_DEV --grant-type client_credentials'

# alias orgs='lsdy WAVE_MSP $(awsprod) --maxlen 50 --attr msp_id,company_name,status,email --nosort'
alias orgs='iam orgs list'
alias supers='lsdy OPENID_CLIENT $(awsprod) --attr client_id,client_secret,name,user_id --nosort'

export USE_GKE_GCLOUD_AUTH_PLUGIN=True

# alias sl='ssh lisbeth'
# alias sy='ssh yavanna'

if [[ "$OSTYPE" == "linux-gnu" ]]; then
  alias open='xdg-open'
  # Set if vim colorscheme is solarized-light or flattened-light
  # export FZF_DEFAULT_OPTS='
  #   --color fg:240,bg:230,hl:33,fg+:241,bg+:221,hl+:33
  #   --color info:33,prompt:33,pointer:166,marker:166,spinner:33
  # '
fi

if [ -x "$(command -v wine)" ]; then
  alias word='wine "/home/f14t/.wine/drive_c/Program Files (x86)/Microsoft Office/Office12/WINWORD.EXE"'
  alias excel='wine "/home/f14t/.wine/drive_c/Program Files (x86)/Microsoft Office/Office12/EXCEL.EXE"'
  alias ppt='wine "/home/f14t/.wine/drive_c/Program Files (x86)/Microsoft Office/Office12/POWERPNT.EXE"'
fi

# kops/kubectl completion for zsh
# source <(kops completion zsh)

# kubectl completion for zsh
if [ -x "$(command -v kubectl)" ]; then
  source <(kubectl completion zsh)
fi

# stern completion for zsh
if [ -x "$(command -v stern)" ]; then
  source <(stern --completion=zsh)
fi

# helm completion for zsh
if [ -x "$(command -v helm)" ]; then
  source <(helm completion zsh)
fi

# completion for hub (GitHub)
if [ -f "$HOME/.zsh/completions/_hub" ]; then
  fpath=(~/.zsh/completions $fpath)
  autoload -U compinit && compinit
fi

# https://thorsten-hans.com/autocompletion-for-kubectl-and-aliases-using-oh-my-zsh-6b5295dc6dfb
plugins=(git git-flow brew history node npm kubectl)

# termbin.com
alias tb='nc termbin.com 9999'

# ZVM - https://github.com/tristanisham/zvm
export ZVM_INSTALL="$HOME/.zvm/self"
export PATH="$PATH:$HOME/.zvm/bin"
export PATH="$PATH:$ZVM_INSTALL/"

# shortcuts for Zig
alias zf='zig fmt src/*.zig'
alias zb='zig build --summary all'
alias zbt='zig build test --verbose'

# shortcuts for Rust
alias cb='cargo build'
alias ct='cargo test -- --nocapture'
