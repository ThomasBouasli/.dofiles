#!/bin/bash

function link_config_files(){
    ln -sr .icons $HOME
    ln -sr alacritty.toml $HOME/.config/alacritty/alacritty.toml
    ln -sr Alacritty.desktop $HOME/.local/share/applications/Alacritty.desktop
    ln -sr .zshrc $HOME/.zshrc
    ln -sr ./nvim $HOME/.config
}

function install_rust(){
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
}

function install_alacritty(){
    sudo apt-get install cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3
    cargo install alacritty
}

function install_zsh(){
    sudo apt-get install zsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    rm -f $HOME/.zshrc
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
}

function install_nerd_fonts(){
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip
    unzip JetBrainsMono.zip -d $HOME/.local/share/fonts/
    rm -rf JetBrainsMono.zip
    fc-cache $HOME/.local/share/fonts/
}

function install_nvim(){
    # Get unstable PPA
    sudo add-apt-repository ppa:neovim-ppa/unstable
    sudo apt-get update

    # Install neovim
    sudo apt-get install neovim
}

function install_tmux(){
    sudo apt-get install tmux
}

function install_node(){
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

    nvm install 20
    nvm alias default 20
    nvm use default
    npm install -g pnpm
}

function install_docker(){
    # Add Docker's official GPG key:
    sudo apt-get update
    sudo apt-get install ca-certificates curl
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc

    # Add the repository to Apt sources:
    echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update

    # Install Docker
    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

    # Post installation
    sudo groupadd docker
    sudo usermod -aG docker $USER
    newgrp docker
    sudo systemctl enable docker.service
    sudo systemctl enable containerd.service
}

function gh_cli(){
    sudo mkdir -p -m 755 /etc/apt/keyrings && wget -qO- https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
    && sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
    && sudo apt update \
    && sudo apt install gh -y

    gh auth login
    gh extension install github/gh-copilot
}

function aws_cli(){
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip awscliv2.zip
    sudo ./aws/install

    rm -rf awscliv2.zip
    rm -rf aws
}

function install_flatpak(){
    sudo apt install flatpak
    flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

    function spotify(){
        flatpak install flathub com.spotify.Client
    }

    function code(){
        flatpak install flathub com.visualstudio.code
    }

    function steam(){
        flatpak install flathub com.valvesoftware.Steam
    }

    function discord(){
        flatpak install flathub com.discordapp.Discord
    }

    should_install "Spotify" $(flatpak list | grep com.spotify.Client) spotify
    should_install "VS Code" $(flatpak list | grep com.visualstudio.code) code
    should_install "Steam" $(flatpak list | grep com.valvesoftware.Steam) steam
    should_install "Discord" $(flatpak list | grep com.discordapp.Discord) discord
}

function costumize_gnome(){
    sudo apt-get install gnome-tweaks

    git clone https://github.com/vinceliuice/WhiteSur-gtk-theme
    mkdir ~/.themes

    cd ./WhiteSur-gtk-theme
    ./install.sh -m -l -i popos -b default
    ./tweaks.sh -i popos -F -d
    sudo ./tweaks.sh -g 

    sudo flatpak override --filesystem=xdg-config/gtk-4.0

    cd ../

    rm -rf ./WhiteSur-gtk-theme
}

function should_install(){
    clear
    echo "Do you want to install $1? (y/n)"

    read response

    if [ "$response" == "y" ]; then
        $2
    fi
}

link_config_files
should_install "Rust" install_rust
should_install "Alacritty" install_alacritty
should_install "Zsh" install_zsh
should_install "Tmux" install_tmux
should_install "Nerd Fonts" install_nerd_fonts
should_install "Neovim" install_nvim
should_install "Node" install_node
should_install "Docker" install_docker
should_install "GitHub CLI" gh_cli
should_install "AWS CLI" aws_cli
should_install "Flatpak" install_flatpak
should_install "Gnome Customizations" costumize_gnome