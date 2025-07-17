git clone https://github.com/Use-Tusk/tusk-deploy.git tusk-deploy
echo "cd tusk-deploy" >> ~/.bashrc
cd tusk-deploy
./install.sh

echo
echo "Please update the generated .env file to complete installation!"
echo "Also you need to log out and back in before you can run docker without sudo."
