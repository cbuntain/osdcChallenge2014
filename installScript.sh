#!/bin/bash

# Set up IPython Notebook, R Studio, and Dropbox for reproducible research
# as part of the OSDC Pire 2014 Challenge
# Script written by Cody Buntain <cbuntain@coretx.net> and Nelson Auner
# Borrows Dropbox headless install from Jesse B. Hannah (http://jbhannah.net) <jesse@jbhannah.net>

###
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
###

# Install IPython base
sudo apt-get update
sudo apt-get install python-numpy python-scipy python-matplotlib ipython ipython-notebook python-pandas python-sympy python-nose 

# Grabs your version of Ubuntu as a BASH variable
CODENAME=`grep CODENAME /etc/lsb-release | cut -c 18-`

# Appends the correct CRAN repository to your sources.list file. 
# Feel free to modify if you desire a different cran mirror
sudo sh -c "echo \"deb http://cran.rstudio.com/bin/linux/ubuntu $CODENAME/\" >> /etc/apt/sources.list"

#Install R
sudo apt-get update
sudo apt-get install r-base

#Install the version of libcurl that actually works
sudo apt-get install libcurl4-gnutls-dev

echo "About to install additional R packages"
echo ""
read -p "Press any key to continue... " -n1 -s

sudo echo 'install.packages("httr", repos="http://cran.rstudio.com/")' | R --no-save
sudo echo 'install.packages("RCurl", repos="http://cran.rstudio.com/")' | R --no-save
sudo echo 'install.packages("devtools", repos="http://cran.rstudio.com/")' | R --no-save

sudo echo 'options(repos="http://cran.us.r-project.org"); devtools::install_github("rstudio/rmarkdown")' | R --no-save

echo "Setting up Dropbox client"
echo ""
read -p "Press any key to continue... " -n1 -s

# Dropbox setup on a headless Ubuntu Server
# Script written by Jesse B. Hannah (http://jbhannah.net) <jesse@jbhannah.net>
# Based on http://wiki.dropbox.com/TipsAndTricks/UbuntuServerInstall

###
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
###

# All of the following commands are run as root, or run this script as root.

# Download and extract the Dropbox daemon itself into a system location
sudo mkdir -p /usr/local/dropbox
wget -qO- http://www.dropbox.com/download/?plat=lnx.x86_64 | sudo tar xz --strip 1 -C /usr/local/dropbox

sudo useradd -r -m -d /etc/dropbox -U -s /bin/false dropbox
sudo chown dropbox /etc/dropbox
sudo chmod 700 /etc/dropbox

sudo cp dropbox.py /usr/bin/dropbox.py
