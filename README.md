Rpi-Timelapse
=============

Shell script um mit dem Raspberry Pi und dem dazugehörigen Kameramodul ein Set von Fotos für eine Zeitrafferaufnahme zu erstellen.

Die Einstellungen für die Bildaufnahme können in dem Script direkt angepasst werden

## Settings

path="/home/pi/timelapse_pics" ## Speicherort für die Bilder
filename="Timelapse-201401"    ## Dateiname für die Fotos (während der Aufnahme bekommt jedes Foto noch eine Nummer
height="2592"                  ## Höhe in Pixel
width="1944"                   ## Breite in Pixel
quality="75"                   ## Qualität (0-100)
picture_amount="5"             ## Anzahl der Bilder die erstellt werden soll
wait_time="2000"               ## Wartezeit zwischen der Aufnahme eines Bildes
