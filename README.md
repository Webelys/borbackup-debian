# Borbackup Debian (binary mode)

Provide differents packaging to wheezy debian.
Borgbackup provide a binary to any plat-form but not debian packaging to old distribution. To help migration, this repo package official binary as deb.

# Notes

* Package is named **borgbackup-bin** as this no conflict with official debian package. 
* Version follows official version naming.
* Updated daily (each day travis retrieve last binary package and push them (386 and amd64) on bintray service


# Installation

```
apt-get install apt-transport-https
echo "deb [trusted=yes] https://dl.bintray.com/webelys/debian wheezy main"  >> /etc/apt/sources.list.d/webelys.list
apt-get update
apt-get install borgbackup-bin 
``` 
