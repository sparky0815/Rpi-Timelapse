#!/bin/sh

#################################
## Timelapse by Sparky0815.de  ##
## Version: 0.3		       ##
## Date: 2014-01-22	       ##
##			       ##
################################################################################################################################
## Einstellungen:

## Speicherort für die Bilder
path="/home/pi/timelapse_pics"

## Dateiname
filename="Timelapse"

## Höhe (max. 2593)
height="2592"

## Breite des Bildes (max. 1944)
width="1944"

## Qualität (0-100)
quality="100"

## Exposure: off,auto,night,nightpreview,backlight,spotlight,sports,snow,beach,verylong,fixedfps,antishake,fireworks
exposure="auto"

## AWB: off,auto,sun,cloud,shade,tungsten,fluorescent,incandescent,flash,horizon
awb="auto"

## Anzahl der Bilder
picture_amount="5"

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
echo "Automaticher Weiss Abgleich (AWB): "$awb
echo "Bild drehen um (grad): "$rotate
echo "Wartezeit: "$wait_time
echo "Anzahl Bilder: "$picture_amount
echo
echo "Soll mit diesen Einstellungen gestartet werden ? (j/n)"
echo 
}



## Speicherort für Bilder leeren bevor die Aufnahme startet

sudo rm -rf $path"/*.jpg"



## Aufnamhe ausfuehren

start_question() {
read answer
case $answer in

  j*|J*|y*|Y*) 
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

take_picture() {
number="0"
date=`date +%F`
while [ $number -lt $picture_amount ]
do 
rest=`expr $picture_amount - $number`
echo "Es muessen noch " $rest " Bilder gemacht werden..."
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


