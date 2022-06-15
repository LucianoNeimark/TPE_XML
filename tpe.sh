ID_ARTIST=$1
#VALIDAR QUE ESTE EL ID
#curl para obtener los archivos artist_info.xml y recordings_info.xml, con esto generamos el nuevo xml
EXISTANT_ID=$(xpath -q -e "boolean(//artist[@arid = '${ID_ARTIST}'])" artists_list.xml)
if [ $EXISTANT_ID == "1" ] ;
then 
curl -o artist_info.xml https://musicbrainz.org/ws/2/artist/${ID_ARTIST}?inc=works
curl -o recordings_info.xml https://musicbrainz.org/ws/2/recording?query=arid:${ID_ARTIST}&limit=1000
fi

xquery wtf artist_data.xml artist_info recordings_info