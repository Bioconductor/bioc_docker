#!/bin/bash

# cheat here:
apt-get install unzip

vepVer=`echo "cat(unname(unlist(ensemblVEP::currentVEP())))"|R --slave`
cd /tmp
curl -LO https://codeload.github.com/Ensembl/ensembl-tools/zip/release/`echo $vepVer`
rm -rf ensembl-tools-release-`echo $vepVer`
unzip $vepVer
rm $vepVer
cd ensembl-tools-release-`echo $vepVer`/scripts
mv variant_effect_predictor /usr/local
echo 'export PATH=$PATH:/usr/local/variant_effect_predictor' >> /etc/profile
echo 'PATH=${PATH}:/usr/local/variant_effect_predictor' > /usr/local/lib/R/etc/Renviron.site
cd /usr/local/variant_effect_predictor
perl INSTALL.pl -a a 
