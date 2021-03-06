#!/bin/bash
# @Date:   22-Nov-2016
# @Project:
# @Last modified time: 09-Fev-2017


/sources/scriptRunner.bash -e /sources/montage

if [ ! -d /opt/sophos-av ]

 then 
 
cd /sources

echo -e "/opt/sophos-av\nN\ns\nf\nN" > /sources/sophos-av/Sophos-reponse.txt

chmod 777 /sources/sophos-av/Sophos-reponse.txt

cd /sources/sophos-av

/sources/sophos-av/install.sh --acceptlicence < /sources/sophos-av/Sophos-reponse.txt


fi

RAPPORT=$HOME/"RapportAntivirus.txt"
PATH=$"/media/*"
/bin/umount /media/ROOT
/bin/umount /media/usbhd-sda*
/opt/zav/bin/zavd --restart

if [ -f $RAPPORT ];

then
rm $RAPPORT
> $RAPPORT
else
> $RAPPORT
fi
/usr/bin/clear
echo "Scan de l'antivirus En cours ..."
echo " "
echo "------------------------------------------------ ">> $RAPPORT
echo "CLAMAV ">> $RAPPORT
echo "------------------------------------------------ ">> $RAPPORT
echo " ">> $RAPPORT
/usr/bin/clamscan  --infected --recursive --remove  $PATH >> $RAPPORT
/usr/bin/clear
echo  "Scan de l'antivirus 25% "
echo " ">> $RAPPORT
echo "------------------------------------------------ ">> $RAPPORT
echo "ZAVD ">> $RAPPORT
echo "------------------------------------------------ ">> $RAPPORT
echo " "
/opt/zav/bin/zavcli --remove=infected --show=infected  -s $PATH >> $RAPPORT
/usr/bin/clear
echo "Scan de l'antivirus 50% "
echo " ">> $RAPPORT
echo "------------------------------------------------ ">> $RAPPORT
echo "SOPHOS ">> $RAPPORT
echo "------------------------------------------------ ">> $RAPPORT
echo " "
/opt/sophos-av/bin/savscan -remove -ndi -nc -di  $PATH | /bin/sed "/IDE /d" >> $RAPPORT
/usr/bin/clear
echo "Scan de l'antivirus 75% "
echo " ">> $RAPPORT
echo "------------------------------------------------ ">> $RAPPORT
echo "FPROT ">> $RAPPORT
echo "------------------------------------------------ ">> $RAPPORT
echo " "
/usr/local/bin/fpscan --disinfect -y  --deleteall -v 1 $PATH >> $RAPPORT
/usr/bin/clear
/bin/cat $RAPPORT
echo " *********************************************"
echo "Scan de l'antivirus terminé !"
echo "Rapport complet disponible : /root/RapportAntivirus.txt"
/sources/RetireUSB.sh
