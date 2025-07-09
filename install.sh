
if uname -a | grep -q Ubuntu; then
    echo "✅ You are running Ubuntu"
else
    echo "⚠️ Please run this script on an Ubuntu machine image. You are currently on:"
    uname -a
    exit 1;
fi


echo "⌛️ Installing docker and docker compose"

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

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "✅ Installation complete"

echo "You should have been provided with a docker registry key. Enter it below:"
echo -n Registry key: 
read key
echo $key | docker login ghcr.io -u jxd-tusk --password-stdin

echo "✅ Done."
echo "⌛️ Starting docker compose now..."
docker-compose up
