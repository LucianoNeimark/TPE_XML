ID_ARTIST=$1
xpath -q -e "boolean(//artist[@arid = '${ID_ARTIST}'])" artists_list.xml