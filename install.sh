green() {
        printf "\e[32m✅ %s\e[0m\n" "$1"
}

red() {
        printf "\e[31m❌ %s\e[0m\n" "$1"
}

if uname -a | grep -q Ubuntu; then
        green "You are running Ubuntu."
else
        red "Parts of this this script will not work on non-Ubuntu machines. You are currently on:"
        uname -a
fi

check() {
        local bin="$1" desc="$2"
        if command -v "$bin" &>/dev/null || $bin &>/dev/null; then
                green "$desc found"
                return 0
        else
                red "$desc missing"
                return 1
        fi
}

install_docker() {
        # source: https://docs.docker.com/engine/install/ubuntu/
        sudo apt-get update
        sudo apt-get install ca-certificates curl
        sudo install -m 0755 -d /etc/apt/keyrings
        sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
        sudo chmod a+r /etc/apt/keyrings/docker.asc
        echo \
                "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
                $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
                sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
        sudo apt-get update

        sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
}

if !(check docker "Docker engine"); then
        echo "Installing docker..."
        install_docker
fi

if !(check "docker compose version" "Docker compose"); then
        echo "Installing docker..."
        install_docker
fi

green "Docker and compose installed."

cp .env.sample .env
if [ $? -eq 0 ]; then
        green "Generated .env file."
else
        red "Failed to generate .env file!"
fi

sudo usermod -aG docker $USER
if [ $? -eq 0 ]; then
        green "Added you to the docker user group."
else
        red "Could not add you to the docker group!"
fi

read -r -s -p "You should have been provided with a Docker registry key."$'\n'"Registry key (leave empty to skip): " key

if [[ -n $key ]]; then
        if printf '%s\n' "$key" | docker login ghcr.io -u jxd-tusk --password-stdin; then
                green "Docker registry login succeeded."
        else
                red "Docker registry login failed."
        fi
else
        echo
fi


echo "Done"
