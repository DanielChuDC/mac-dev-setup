#!/bin/bash

# locale for ventura
export LANG=en_US.UTF-8

# Create a folder who contains downloaded things for the setup
INSTALL_FOLDER=~/.macsetup
mkdir -p $INSTALL_FOLDER
MAC_SETUP_PROFILE=$INSTALL_FOLDER/macsetup_profile

# install brew
if ! hash brew
then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  brew update
else
  printf "\e[93m%s\e[m\n" "You already have brew installed."
fi

# CURL / WGET
brew install curl
brew install wget

{
  # shellcheck disable=SC2016
  echo 'export PATH="/usr/local/opt/curl/bin:$PATH"'
  # shellcheck disable=SC2016
  echo 'export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"'
  # shellcheck disable=SC2016
  echo 'export PATH="/usr/local/opt/sqlite/bin:$PATH"'
}>>$MAC_SETUP_PROFILE

# git
brew install git                                                                                      # https://formulae.brew.sh/formula/git
# Adding git aliases (https://github.com/thomaspoignant/gitalias)
git clone https://github.com/thomaspoignant/gitalias.git $INSTALL_FOLDER/gitalias && echo -e "[include]\n    path = $INSTALL_FOLDER/gitalias/.gitalias\n$(cat ~/.gitconfig)" > ~/.gitconfig

brew install git-secrets                                                                              # git hook to check if you are pushing aws secret (https://github.com/awslabs/git-secrets)
git secrets --register-aws --global
git secrets --install ~/.git-templates/git-secrets
git config --global init.templateDir ~/.git-templates/git-secrets


# Terminal replacement https://www.iterm2.com
brew install --cask  iterm2
# Pimp command line
brew install micro                                                                                    # replacement for nano/vi
brew install lsd                                                                                      # replacement for ls
{
  echo "alias ls='lsd'"
  echo "alias l='ls -l'"
  echo "alias la='ls -a'"
  echo "alias lla='ls -la'"
  echo "alias lt='ls --tree'"
} >>$MAC_SETUP_PROFILE

brew install tree
brew install ack
brew install bash-completion
brew install jq
brew install htop
brew install tldr
brew install coreutils
brew install watch

brew install ctop

# fonts (https://github.com/tonsky/FiraCode/wiki/Intellij-products-instructions)
# set font family in vscode
# "editor.fontFamily": "JetBrains Mono",
# "editor.fontLigatures": true,
brew tap homebrew/cask-fonts
brew install  --cask  font-jetbrains-mono
brew install  --cask  font-hack-nerd-font

# not in use
### Need to set the visual studio code font 
### For the DejaVu, use "DejaVuSansMono Nerd Font"
###  "terminal.integrated.fontFamily": "DejaVuSansMono Nerd Font"
### Download from https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/DejaVuSansMono/Regular/complete/DejaVu%20Sans%20Mono%20Nerd%20Font%20Complete.ttf


## Browser please download from the official side
# brew install --cask google-chrome
# brew install --cask brave-browser
# brew install --cask microsoft-edge
# brew install --cask firefox

# Music / Video
brew install  --cask  spotify
brew install  --cask  vlc

# Communication
# brew install  --cask  whatsapp
brew install --cask   telegram

# IDE
brew install --cask  visual-studio-code
{
  echo 'export PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin:$PATH"'
}>>$MAC_SETUP_PROFILE



## Java
curl -s "https://get.sdkman.io" | bash                                                               # sdkman is a tool to manage multiple version of java
source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk install java

# brew install maven # do not want to use maven
brew install gradle 
brew install gradle-completion 


## python
echo "export PATH=\"/usr/local/opt/python/libexec/bin:\$PATH\"" >> $MAC_SETUP_PROFILE
brew install python
pip install --user pipenv
pip install --upgrade setuptools
pip install --upgrade pip
brew install pyenv
# shellcheck disable=SC2016
echo 'eval "$(pyenv init -)"' >> $MAC_SETUP_PROFILE

# Python virtualenv
brew install pyenv-virtualenv
echo 'if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi'  >> $MAC_SETUP_PROFILE


# SFTP
brew install  --cask cyberduck

# reload profile files.
{
  echo "source $MAC_SETUP_PROFILE # alias and things added by mac_setup script"
}>>"$HOME/.zsh_profile"

{
  echo "source $MAC_SETUP_PROFILE # alias and things added by mac_setup script"
}>>"$HOME/.zshrc"
# shellcheck disable=SC1090
source "$HOME/.zsh_profile"
source "$HOME/.zshrc"

{
  echo "source $MAC_SETUP_PROFILE # alias and things added by mac_setup script"
}>>~/.bash_profile
# shellcheck disable=SC1090
source ~/.bash_profile


## Development folder setup
mkdir -p ~/Documents/development


# Install video conference, webex, microsoft team,zoom
# #brew install --cask webex-meetings
# brew  install --cask microsoft-teams
# brew install --cask zoom

## install vmfusion and virtual box
## Follow from https://gist.github.com/tomysmile/0618f1aa16341706940ed36b423b431c
brew install --cask vmware-fusion
# brew install --cask virtualbox
# brew install --cask vagrant
# brew install --cask vagrant-manager



### Add patches for pyenv when using oh my zsh
### Add pyenv executable to PATH and
### enable shims by adding the following
{
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init --path)"
}>>"$HOME/.zprofile"

{
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init --path)"
}>>"$HOME/.profile"

{
  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
}>>"$HOME/.zshrc"




# for drawio , software engineering diagram
brew install --cask drawio


# note taking
brew install --cask notion
brew install --cask obsidian

# # logitech
# brew install homebrew/cask-drivers/logitech-options

# Cloudfare
brew install --cask cloudflare-warp

# for dmg file 
brew install --cask osirix-quicklook

# for network analysis
brew install nmap

# for security analysis
brew install --cask burp-suite

# for analysis
brew install smartmontools


brew install ffmpeg

# ZSH
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"# Install oh-my-zsh on top of zsh to getting additional functionality
