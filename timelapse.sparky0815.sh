#!/bin/sh

#################################
## Timelapse by Sparky0815.de
## Version: 0.2
## Date: 2014-01-21
##

## possible resolutions

## Settings

path="/home/pi/timelapse_pics"
filename="Timelapse-201401"
height="2592"
width="1944"
quality="75" 
picture_amount="5"
wait_time="2000"


## Show settings on console

show_setup() {
clear
echo "Folgende Einstellunge werden verwendet"
echo
echo "Pfad: "$path
echo "Dateiname: "$filename
echo "Hoehe: "$height
echo "Breite: "$width
echo "Qualitaet: "$quality 
echo "Wartezeit:"$wait_time
echo "Anzahl Bilder:" $picture_amount
echo
echo "Soll mit diesen Einstellungen gestartet werden ? (j/n)"
echo 
}



## Start timelapse

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

## Take pictures

take_picture() {
number="0"
while [ $number -lt $picture_amount ]
do 
rest=`expr $picture_amount - $number`
echo "Es muessen noch " $rest " Bilder gemacht werden..."
raspistill -o $path"/"$filename"_"$number".jpg" -h $height -w $width -q $quality -t $wait_time
number=`expr $number + 1`
done
}



## Finish message

show_finished() {
echo
echo "Fertig."
echo "Es wurden" $number "Bilder im Ordner" $path "abgelegt."
}


show_setup
start_question


