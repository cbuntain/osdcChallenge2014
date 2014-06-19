#!/bin/bash

apt-get install python-numpy python-scipy python-matplotlib ipython ipython-notebook python-pandas python-sympy python-nose 

apt-get install libcurl4-gnutls-dev

echo 'install.packages("httr", repos="http://cran.rstudio.com/")' | R --no-save
echo 'install.packages("RCurl", repos="http://cran.rstudio.com/")' | R --no-save
echo 'install.packages("devtools", repos="http://cran.rstudio.com/")' | R --no-save

echo 'options(repos="http://cran.us.r-project.org"); devtools::install_github("rstudio/rmarkdown")' | R --no-save
