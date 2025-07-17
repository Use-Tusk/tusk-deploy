git clone https://github.com/Use-Tusk/tusk-deploy.git tusk-deploy
if ! grep -q "cd tusk-deploy" ~/.bashrc; then
        echo "cd tusk-deploy" >> ~/.bashrc
fi
cd tusk-deploy
./install.sh

echo
echo "To complete the installation, please first log out and log back in."
echo "Next, populate the generated .env file."
echo "Finally, run docker compose up to bring Tusk up!"
