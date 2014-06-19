#!/bin/bash

# Set up IPython Notebook, R Studio, and Dropbox for reproducible research
# as part of the OSDC Pire 2014 Challenge. This script runs dropbox and allows
# users to join the computer to his/her Dropbox account
# 
# Script written by Cody Buntain <cbuntain@coretx.net> and Nelson Auner
# Borrows Dropbox headless install from Jesse B. Hannah (http://jbhannah.net) <jesse@jbhannah.net>

echo "In a moment, you will be given a URL to use for linking your Dropbox account to this computer."
echo "Copy and paste this URL into a browser, and login with your Dropbox credentials."
echo "After success, press CTRL+C to exit and continue with installation."
echo ""
read -p "Press any key to continue... " -n1 -s

sudo -u dropbox HOME=/etc/dropbox/ -s /bin/bash /usr/local/dropbox/dropboxd
# If you're OCD, you can remove everything from /etc/dropbox except .dropbox and Dropbox now

sudo cat <<EOF | sed -e "s,%,$,g" >/tmp/dropbox.conf
# Dropbox upstart script

description "Dropbox"
author      "Jesse B. Hannah <jesse@jbhannah.net>"

start on runlevel [2345]
stop on runlevel [!2345]

respawn

env HOME=/etc/dropbox
umask 0027

pre-start script
    [ ! -e "$HOME/.dropbox/command_socket" ] || rm $HOME/.dropbox/command_socket
    [ ! -e "$HOME/.dropbox/iface_socket" ]   || rm $HOME/.dropbox/iface_socket
    [ ! -e "$HOME/.dropbox/unlink.db" ]      || rm $HOME/.dropbox/unlink.db
end script

script
    export LANG=en_US.UTF-8
    exec su -s /bin/sh -c /usr/local/dropbox/dropbox dropbox
end script
EOF
sudo mv /tmp/dropbox.conf /etc/init/dropbox.conf

sudo start dropbox

sudo chmod -R g+rwx /etc/dropbox