osdcChallenge2014
=================

Source code for the OSDC Challenge

Usage
=================
This software contains three pieces to support installation, configuration, and usage.

Installation
-----------
Running installScript.sh will use apt-get to pull down a series of packages supporting software compilation, Dropbox download, IPython installation, and R installation.

Configuration
-----------
Dropbox needs to be linked to your account, so after installation, you need to run firstRun.sh, which will provide you a URL to connect your account to this computer.

Usage
----------
Once setup is complete, you need only run dropboxPublisher to push your IPython notebook or R file to the web for public access.



R
==

Requirements
----------

The setup script should install all requirements EXCEPT for the pandoc version 1.12 required by Rmarkdown.
I've installed pandoc on the mayfly_v1 image on osdc 


Usage for R
------------

`knit.sh IrisExample.Rmd` produces an md file

- need to convert to html
- push to dropbox
