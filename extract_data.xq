<artist_data>
<artist>
    
    {doc('artist_info.xml')//artist/name}
    {doc('artist_info.xml')//artist/disambiguation }

    <type>{
        data(doc('artist_info.xml')//artist/@type)
    }</type>

    <area>
        {doc('artist_info.xml')//artist/area/name } 
        <origin>{data(doc('artist_info.xml')//artist/begin-area/name)}</origin>
    </area>

    {doc('artist_info.xml')//artist/life-span}

    <recordings>
        {
         for $recording in doc('recordings_info.xml')//recording-list/recording
            return <recording>
            <title>{data($recording/title)}</title>
            <length>{data($recording/length)}</length>
            <first-release-date>{data($recording/first-release-date)}</first-release-date>
            
            {
                for $release in $recording/release-list/release
                return 
                    <release>
                        <title>{data($release/title)}</title>
                        <date>{data($release/date)}</date>
                        <country>{data($release/country)}</country>
                        <type>{data($release/release-group/primary-type)}</type>
                        <track-number>{data($release/medium-list/medium/track-list/track/number)}</track-number>
                    </release>
            }
            </recording>
    
        }
    </recordings>

</artist>
</artist_data>