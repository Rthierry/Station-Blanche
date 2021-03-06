﻿#!/bin/bash
# @Date:   22-Nov-2016
# @Project:
# @Last modified time: 09-Fev-2017


if [ ! -d /opt/sophos-av ]

 then 
 
cd /sources

echo -e "/opt/sophos-av\nN\ns\nf\nN" > /sources/sophos-av/Sophos-reponse.txt

/bin/chmod 777 /sources/sophos-av/Sophos-reponse.txt

cd /sources/sophos-av

/sources/sophos-av/install.sh --acceptlicence < /sources/sophos-av/Sophos-reponse.txt

fi

/usr/bin/clear

RAPPORT=$HOME/"RapportMajAv.txt"

if [ -f $RAPPORT ];
then
rm $RAPPORT
> $RAPPORT
else
> $RAPPORT
fi
echo "-----------------------------------" > $RAPPORT
echo "Mise à jour des antivirus ..."  >> $RAPPORT
echo "-----------------------------------" >> $RAPPORT
echo "Etat des mises à jours" >> $RAPPORT
echo " " >> $RAPPORT
echo "-----------------------------------" >> $RAPPORT
echo "CLAMAV : " >> $RAPPORT
echo "-----------------------------------" >> $RAPPORT
echo " " >> $RAPPORT
echo "Mise à jour des antivirus ..."
/usr/bin/freshclam >> $RAPPORT
/usr/bin/clear
/usr/bin/freshclam -V >> $RAPPORT
/usr/bin/clear 
echo " " >> $RAPPORT
echo "Mise à jour des antivirus ... 25%"
echo "-----------------------------------" >> $RAPPORT
echo "FPUPDATE : " >> $RAPPORT
echo "-----------------------------------" >> $RAPPORT
echo " " >> $RAPPORT
/opt/f-prot/fpupdate >> /dev/null
/usr/bin/clear 
/opt/f-prot/fpupdate --version >> $RAPPORT
/usr/bin/clear 
echo "Mise à jour des antivirus ... 50%"
echo " " >> $RAPPORT
echo "-----------------------------------" >> $RAPPORT
echo "SOPHOS : " >> $RAPPORT
echo "-----------------------------------" >> $RAPPORT
echo " " >> $RAPPORT
/opt/sophos-av/bin/savupdate  >> $RAPPORT
/opt/sophos-av/bin/savscan -v | /usr/bin/head -n 12 >> $RAPPORT
/usr/bin/clear 
echo "Mise à jour des antivirus ... 75%"
echo " " >> $RAPPORT
echo "-----------------------------------" >> $RAPPORT
echo "ZAVD : " >> $RAPPORT
echo "-----------------------------------" >> $RAPPORT
echo " " >> $RAPPORT
/opt/zav/bin/zavd --restart
/opt/zav/bin/zavd --update  >> $RAPPORT
/opt/zav/bin/zavd --version >> $RAPPORT
echo "-----------------------------------" >> $RAPPORT

/usr/bin/clear
/bin/cat $RAPPORT
echo " *********************************************"
echo "Mise à jour des antivirus ... 100%"
echo "Rapport complet disponible : /root/RapportMajAv.txt"

