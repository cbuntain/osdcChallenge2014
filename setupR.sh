# Grabs your version of Ubuntu as a BASH variable
CODENAME=`grep CODENAME /etc/lsb-release | cut -c 18-`

# Appends the correct CRAN repository to your sources.list file. 
# Feel free to modify if you desire a different cran mirror

sudo sh -c 'echo "deb http://cran.rstudio.com/bin/linux/ubuntu $CODENAME/" >> /etc/apt/sources.list'

#Install R
apt-get base-r

#Install the version of libcurl that actually works
apt-get libcurl4-gnutls-dev
