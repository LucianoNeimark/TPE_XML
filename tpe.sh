#!/bin/bash
ID_ARTIST=$1
#VALIDAR QUE ESTE EL ID
#curl para obtener los archivos artist_info.xml y recordings_info.xml, con esto generamos el nuevo xml
EXISTANT_ID=$(xpath -q -e "boolean(//artist[@arid = '${ID_ARTIST}'])" artists_list.xml)
if [ $EXISTANT_ID == "1" ] ;
then 
curl -o artist_info.xml https://musicbrainz.org/ws/2/artist/${ID_ARTIST}?inc=works
curl -o recordings_info.xml https://musicbrainz.org/ws/2/recording?query=arid:${ID_ARTIST}&limit=1000

sleep 2 # Parche porque intenta usar el file antes de crearlo. Cambiar!!!

sed -i .bak 's> xmlns="http://musicbrainz.org/ns/mmd-2.0#">>' artist_info.xml
sed -i .bak 's> xmlns="http://musicbrainz.org/ns/mmd-2.0#">>' recordings_info.xml
java net.sf.saxon.Query extract_data.xq > pruebitash.xml  
fi
#else lanzar el error -> se tiene una crear un .adoc donde la pagina solo tiene un error