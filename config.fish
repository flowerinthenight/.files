set fish_color_command yellow
set fish_color_user green
set fish_color_host green

if test -e ~/drive/develop/envvars
    for line in (cat ~/drive/develop/envvars)
        set -x (string split '=' $line)[1] (string split '=' $line)[2]
    end
end

# Set if vim colorscheme is solarized-light or flattened-light
set -x FZF_DEFAULT_OPTS '--color=light'

alias up='sudo apt update && apt list --upgradable && sudo apt upgrade -y'
alias v='vim'
alias l='ls -lF'
alias ll='ls -laF'
alias x='exit'

set -x GOPATH $HOME/gopath
set -x GOPROXY https://proxy.golang.org
set -x PATH (string replace ':' ' ' $PATH) /usr/local/go/bin $GOPATH/bin $HOME/google-cloud-sdk/bin $HOME/.npm-global/bin $HOME/.cargo/bin $HOME/.rbenv/bin $HOME/.rbenv/plugins/ruby-build/bin $HOME/.local/bin /snap/bin $HOME/istio-1.1.6/bin /home/linuxbrew/.linuxbrew/bin

# for Go1.11
set -x GO111MODULE on

# Change 'ls' color for directory (I don't like the default blue).
# Reference: http://askubuntu.com/questions/466198/how-do-i-change-the-color-for-directories-with-ls-in-the-console
# Change to 'underlined orange', but looks like muted yellow, really.
# When using Putty though, this is not needed as blue is somewhat okay.
# set LS_COLORS $LS_COLORS:'di=04;33'
set LS_COLORS 'di=04;33'
set -x LS_COLORS $LS_COLORS
set -x LSCOLORS $LS_COLORS

# kubectl shortcuts
alias kc='kubectl config get-contexts'
alias kp='kubectl get pod -o wide'
alias kd='kubectl get deployment -o wide'
alias ks='kubectl get svc -o wide'
alias ki='kubectl get ingress'
alias kn='kubectl get node -o wide'
alias kt='kubectl top'
alias k='kubectl'

# switching gke clusters
alias kdev='gcloud config configurations activate default && gcloud container clusters get-credentials (gcloud container clusters list | grep -i dev | cut -f 1 -d " ") && kubectl config current-context'
alias kqa='gcloud config configurations activate mochi-prod && gcloud container clusters get-credentials (gcloud container clusters list | grep -i qa | cut -f 1 -d " ") && kubectl config current-context'
alias knext='gcloud config configurations activate mochi-prod && gcloud container clusters get-credentials (gcloud container clusters list | grep -i next | cut -f 1 -d " ") && kubectl config current-context'
alias kprod='gcloud config configurations activate mochi-prod && gcloud container clusters get-credentials (gcloud container clusters list | grep -i prod | cut -f 1 -d " ") && kubectl config current-context'

alias sl='ssh lisbeth'
alias sy='ssh yavanna'
alias open='xdg-open'
