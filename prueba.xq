



<a>{
for $p in doc('prueba.xml')//person
return 
    
        for $recording in $p/recordings/recording
        return $recording
    
}
<a>