git clone https://github.com/Use-Tusk/tusk-deploy.git tusk-deploy
echo "cd tusk-deploy" >> ~/.bashrc
cd tusk-deploy
./install.sh
exec sg docker "docker compose up"
