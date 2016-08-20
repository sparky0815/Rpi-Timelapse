#!/bin/sh

#################################
## Timelapse by Sparky0815.de  ##
## Date: 2014-02-12	       ##
## http://www.sparky0815.de    ##
################################################################################################################################
## Einstellungen:

## Speicherort für die Bilder
path="/home/pi/timelapse_pics"

## Dateiname
filename="Timelapse"

## Höhe (max. 1944)
height="1944"

## Breite des Bildes (max. 2592)
width="2592"

## Qualität (0-100)
quality="100"

## Exposure: off,auto,night,nightpreview,backlight,spotlight,sports,snow,beach,verylong,fixedfps,antishake,fireworks
exposure="auto"

## AWB: off,auto,sun,cloud,shade,tungsten,fluorescent,incandescent,flash,horizon
awb="auto"

## Anzahl der Bilder
picture_amount="1000"

## Wartezeit zwischen der Aufnahme (in ms bsp.: 15000 = 15 sekunden)
wait_time="2000"

## Bild drehen (0-359)
rotate="0"

################################################################################################################################



## Einstellungen anzeigen

show_setup() {
clear
echo "Folgende Einstellunge werden verwendet"
echo
echo "Pfad: "$path
echo "Dateiname: "$filename
echo "Hoehe: "$height
echo "Breite: "$width
echo "Qualitaet: "$quality 
echo "Exposure "$exposure
echo "Automatischer Weiss Abgleich (AWB): "$awb
echo "Bild drehen um (grad): "$rotate
echo "Wartezeit: "$wait_time
echo "Anzahl Bilder: "$picture_amount
echo
echo -n 'Soll mit diesen Einstellungen gestartet werden ? (j/n) \c' 
}


## Prüfe ob Ziehlordner vorhanden ist
## JA => Zielordner wird geleer (Alle vorhanden .jpg Dateien werden aus dem Verzeichnis ohne Nachfrage entfernt
## NEIN => Zielordner wird erstellt

check_path() {
if [ -d $path ]
	then
		echo
		echo "Zielordner" $path "ist bereits vorhanden und wurde geleert..."
		sudo rm -rf $path/*.jpg
		echo
	else
		echo
		echo "Der Zielordner" $path "wurde nun erstellt..."
		sudo mkdir $path
		echo
fi
}




## Aufnamhe ausfuehren

start_question() {
read answer
case $answer in

  j*|J*|y*|Y*) 
check_path
take_picture
show_finished
;;

  n*|N*) 
echo "Abgebrochen. Bitte ggf. Einstellungen in der timelapse.sparky0815.sh vornehmen"
;;

  *) 
echo "Abgebrochen. Bitte ggf. Einstellungen in der timelapse.sparky0815.sh vornehmen"
;;

esac
}



## Bilder aufnehmen
## Das Datum wird einmalig bei Start der Bildaufnahme abgefragt und in jeden Dateinamen der aufgenommenen Bilder eingefügt.
## Jedem Bild wird eine fortlaufende Nummer angehangen. (Reihenfolge der Bilder)

take_picture() {
number="0"
date=`date +%F`
while [ $number -lt $picture_amount ]
do 
rest=`expr $picture_amount - $number`
echo -n 'Noch' $rest 'Bilder...\r'
raspistill -o $path"/"$filename"-"$date"_"$number".jpg" -h $height -w $width -q $quality -t $wait_time -ex $exposure -awb $awb -rot $rotate
number=`expr $number + 1`
done
}



## Ende Nachricht

show_finished() {
echo
echo "Fertig."
echo "Es wurden" $number "Bilder im Ordner" $path "abgelegt."
}



## Einstellungen anzeigen und fragen ob mit diesen die Aufnahme gestartet werden soll

show_setup
start_question
