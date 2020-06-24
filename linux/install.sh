echo Welcome to LuaCon Installer
echo
echo Installing Love2D
sudo apt-get install love
sudo mkdir /usr/bin/luacon-f
sudo cp luacon.lua luacon_config luacon_utils /usr/bin/luacon-f
sudo cp luacon.sh /usr/bin; sudo mv /usr/bin/luacon.sh /usr/bin/luacon
sudo chmod 777 -R /usr/bin/luacon /usr/bin/luacon-f
echo
echo LuaCon succesfully installed on the system, run the luacon command to use it