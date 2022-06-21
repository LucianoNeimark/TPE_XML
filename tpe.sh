#!/bin/bash
ID_ARTIST=$1
#VALIDAR QUE ESTE EL ID
#curl para obtener los archivos artist_info.xml y recordings_info.xml, con esto generamos el nuevo xml
EXISTANT_ID=$(xpath -q -e "boolean(//artist[@arid = '${ID_ARTIST}'])" artists_list.xml)
if [ $EXISTANT_ID == "1" ] ;
then 
curl -o artist_info.xml https://musicbrainz.org/ws/2/artist/${ID_ARTIST}?inc=works && curl -o recordings_info.xml https://musicbrainz.org/ws/2/recording?query=arid:${ID_ARTIST}&limit=1000 && sleep 7
sed -i .bak 's>xmlns="http://musicbrainz.org/ns/mmd-2.0#">>' artist_info.xml
sed -i .bak 's>xmlns="http://musicbrainz.org/ns/mmd-2.0#">>' recordings_info.xml
java net.sf.saxon.Query extract_data.xq > artist_data.xml  
java net.sf.saxon.Transform -s:artist_data.xml -xsl:generate_doc.xsl > artist_page.adoc
sed -i .bak 's#<?xml version="1.0" encoding="UTF-8"?>##'  artist_page.adoc
else
    # Codigo de crear el adoc de error
    touch artist_data.xml
    echo '<artist_data><error>ID not found in Artist List</error></artist_data>' > artist_data.xml
    java net.sf.saxon.Transform -s:artist_data.xml -xsl:generate_doc.xsl > artist_page.adoc
sed -i .bak 's#<?xml version="1.0" encoding="UTF-8"?>##'  artist_page.adoc
fi