#!/bin/bash
# Custom curl script for quick, live, granular human readable output

# screen start variables for live update
        HOME=$(tput cup 0 0)
        ED=$(tput ed)
        EL=$(tput el)
        ROWS=$(tput lines)
        COLS=$(tput cols)

# user specified variables
        curlurl=$1      # User specified URL to curl
        sleeptimer=$2   # User specified sleep timer (in seconds)
        outputfile=$3   # User specified file to pipe output to


        scriptstartdate=`date --u`

# set all HTTP code variables to 0
http000=0;http100=0;http101=0;http200=0;http201=0;http202=0;http203=0;http204=0;http205=0;http206=0;http300=0;http301=0;http302=0;http303=0;http304=0;http305=0;http306=0;http307=0;http400=0;http401=0;http402=0;http403=0;http404=0;http405=0;http406=0;http407=0;http408=0;http409=0;http410=0;http411=0;http412=0;http413=0;http414=0;http415=0;http416=0;http417=0;http500=0;http501=0;http502=0;http503=0;http504=0;http505=0;httpunknown=0;otherhttpcodes=0

# set all runcount variables to 1 (for average calculation)
runcount=1;dnslookupruncount=1;sslhandshakeruncount=1;tcphandshakeruncount=1;pretransferruncount=1;firstbyteruncount=1;downloadedbytesruncount=1;downloadspeedbytesruncount=1;uploadedbytesruncount=1;uploadspeedbytesruncount=1;totalrequesttimeruncount=1


### set all MIN/MAX variables to 0/9999999999
maxdnslookupseconds=0;mindnslookupseconds=9999999999;maxsslhandshakeseconds=0;minsslhandshakeseconds=9999999999;maxtcphandshakeseconds=0;mintcphandshakeseconds=9999999999;maxpretransferseconds=0;minpretransferseconds=9999999999;maxfirstbyteseconds=0;minfirstbyteseconds=9999999999;maxdownloadedbytes=0;mindownloadedbytes=9999999999;maxdownloadspeedbytes=0;mindownloadspeedbytes=9999999999;maxuploadedbytes=0;minuploadedbytes=9999999999;maxuploadspeedbytes=0;minuploadspeedbytes=9999999999;maxtotaltime=0;mintotaltime=9999999999


clear

# check for a URL parameter
if [ -z "$curlurl" ]
then
        echo "Syntax invalid: mycurl <curl_URL> <sleep_seconds> <outputfile_location>"
        exit
fi

# check for a sleep timer parameter
if [ -z "$sleeptimer" ]
then
        defaultsleeptimer="No sleep timer specified, using default value of 2 seconds - Expected Syntax: mycurl <curl_URL> <sleep_seconds> <outputfile_location>"
        sleeptimer=2
fi

# check for an output pipe file parameter
if [ -z "$outputfile" ]
then
        defaultoutputfile="No output file specified, using default value of /.mycurl_output.txt - Expected Syntax: mycurl <curl_URL> <sleep_seconds> <outputfile_location>"
        outputfile=./mycurl_output.txt
fi



while true;
do
eval $(curl -w "outputfilename=%{filename_effective};ftpentrypath=%{ftp_entry_path};httpcode=%{http_code};httpconnectcode=%{http_connect};httpversion=%{http_version};srcip=%{local_ip};srcport=%{local_port};dstip=%{remote_ip};dstport=%{remote_port};numberofnewconnects=%{num_connects};numberofredirects=%{num_redirects};redirecturl=%{redirect_url};downloadedbytes=%{size_download};downloadedbyteslist+=(%{size_download});uploadedbytes=%{size_upload};uploadedbyteslist+=(%{size_upload});headerbytes=%{size_header};requestbytessent=%{size_request};downloadspeedbytes=%{speed_download};downloadspeedbyteslist+=(%{speed_download});uploadspeedbytes=%{speed_upload};uploadspeedbyteslist+=(%{speed_upload});sslverifyresult=%{ssl_verify_result};sslhandshakeseconds=%{time_appconnect};sslhandshakesecondslist+=(%{time_appconnect});tcphandshakeseconds=%{time_connect};tcphandshakesecondslist+=(%{time_connect});dnslookupseconds=%{time_namelookup};dnslookupsecondslist+=(%{time_namelookup});pretransferseconds=%{time_pretransfer};pretransfersecondslist+=(%{time_pretransfer});redirectseconds=%{time_redirect};firstbyteseconds=%{time_starttransfer};firstbytesecondslist+=(%{time_starttransfer});totaltime=%{time_total};totaltimelist+=(%{time_total});effectiveurl=%{url_effective}" $curlurl -sko /dev/null)

# Evaluate HTTP code and increment applicable variable
case $httpcode in
     000) ((++http000)) ;;
     100) ((++http100)) ;;
     101) ((++http101)) ;;
     200) ((++http200)) ;;
     201) ((++http201)) ;;
     202) ((++http202)) ;;
     203) ((++http203)) ;;
     204) ((++http204)) ;;
     205) ((++http205)) ;;
     206) ((++http206)) ;;
     300) ((++http300)) ;;
     301) ((++http301)) ;;
     302) ((++http302)) ;;
     303) ((++http303)) ;;
     304) ((++http304)) ;;
     305) ((++http305)) ;;
     306) ((++http306)) ;;
     307) ((++http307)) ;;
     400) ((++http400)) ;;
     401) ((++http401)) ;;
     402) ((++http402)) ;;
     403) ((++http403)) ;;
     404) ((++http404)) ;;
     405) ((++http405)) ;;
     406) ((++http406)) ;;
     407) ((++http407)) ;;
     408) ((++http408)) ;;
     409) ((++http409)) ;;
     410) ((++http410)) ;;
     411) ((++http411)) ;;
     412) ((++http412)) ;;
     413) ((++http413)) ;;
     414) ((++http414)) ;;
     415) ((++http415)) ;;
     416) ((++http416)) ;;
     417) ((++http417)) ;;
     500) ((++http500)) ;;
     501) ((++http501)) ;;
     502) ((++http502)) ;;
     503) ((++http503)) ;;
     504) ((++http504)) ;;
     505) ((++http505)) ;;
     *) ((++httpunknown)) ;
esac

# Sum other known HTTP codes
otherhttpcodes=`echo "$http000+$http100+$http101+$http201+$http202+$http203+$http204+$http205+$http206+$http300+$http305+$http306+$http307+$http400+$http402+$http405+$http406+$http407+$http408+$http409+$http410+$http411+$http412+$http413+$http414+$http415+$http416+$http417+$http505+$httpunknown"|bc -l`

###Calculation of Averages###
# Average DNS lookup ($dnslookupsecondsaverage)
        # if $dnslookupseconds registers a non-zero value, increase $dnsruncount
        if [ $dnslookupseconds != "0.000" ]
         then
                dnslookupruncount=$((++dnslookupruncount))
        fi
        # Calculate the total of the $dnslookupsecondslist and add it to $totaldnsseconds
        totaldnsseconds=`eval echo ${dnslookupsecondslist[@]} | sed 's/ /+/g' | bc`
        # Record DNS average
        dnslookupsecondsaverage=`echo "scale=3; $totaldnsseconds/$dnslookupruncount"|bc -l`
# Average SSL handshake ($sslhandshakesecondsaverage)
        # if $sslhandshakeseconds registers a non-zero value, increase $sslhandshakeruncount
        if [ $sslhandshakeseconds != "0.000" ]
         then
                sslhandshakeruncount=$((++sslhandshakeruncount))
        fi
        # Calculate the total of the $sslhandshakesecondslist and add it to $totalsslseconds
        totalsslseconds=`eval echo ${sslhandshakesecondslist[@]} | sed 's/ /+/g' | bc`
        # Record SSL average
        sslhandshakesecondsaverage=`echo "scale=3; $totalsslseconds/$sslhandshakeruncount"|bc -l`
# Average TCP handshake ($tcphandshakesecondsaverage)
        # if $tcphandshakeseconds registers a non-zero value, increase $tcphandshakeruncount
        if [ $tcphandshakeseconds != "0.000" ]
         then
                tcphandshakeruncount=$((++tcphandshakeruncount))
        fi
        # Calculate the total of the $sslhandshakesecondslist and add it to $totalsslseconds
        totaltcpseconds=`eval echo ${tcphandshakesecondslist[@]} | sed 's/ /+/g' | bc`
        # Record TCP average
        tcphandshakesecondsaverage=`echo "scale=3; $totaltcpseconds/$tcphandshakeruncount"|bc -l`
# Average Total Time Taken Pre-File Transfer ($pretransfersecondsaverage)
        # if $pretransferseconds registers a non-zero value, increase $pretransferruncount
        if [ $pretransferseconds != "0.000" ]
         then
                pretransferruncount=$((++pretransferruncount))
        fi
        # Calculate the total of the $pretransfersecondslist and add it to $totalpretransferseconds
        totalpretransferseconds=`eval echo ${pretransfersecondslist[@]} | sed 's/ /+/g' | bc`
        # Record Pre Transfer Seconds average
        pretransfersecondsaverage=`echo "scale=3; $totalpretransferseconds/$pretransferruncount"|bc -l`
# Average Total Time Taken Till Response First Byte ($firstbytesecondsaverage)
        # if $firstbyteseconds registers a non-zero value, increase $firstbyteruncount
        if [ $firstbyteseconds != "0.000" ]
         then
                firstbyteruncount=$((++firstbyteruncount))
        fi
        # Calculate the total of the $firstbytesecondslist and add it to $totalfirstbyteseconds
        totalfirstbyteseconds=`eval echo ${firstbytesecondslist[@]} | sed 's/ /+/g' | bc`
        # Record First Byte Seconds average
        firstbytesecondsaverage=`echo "scale=3; $totalfirstbyteseconds/$firstbyteruncount"|bc -l`
# Average Total Download Size ($downloadedbytesaverage)
        # if $downloadedbytes registers a non-zero value, increase $downloadedbytesruncount
        if [ $downloadedbytes != "0" ]
         then
                downloadedbytesruncount=$((++downloadedbytesruncount))
        fi
        # Calculate the total of the $downloadedbyteslist and add it to $totaldownloadedbytes
        totaldownloadedbytes=`eval echo ${downloadedbyteslist[@]} | sed 's/ /+/g' | bc`
        # Record Download Size average
        downloadedbytesaverage=`echo "scale=0; $totaldownloadedbytes/$downloadedbytesruncount"|bc -l`
# Average Download Speed ($downloadspeedbytesaverage)
        # if $downloadspeedbytes registers a non-zero value, increase $downloadspeedbytesruncount
        if [ $downloadspeedbytes != "0.000" ]
         then
                downloadspeedbytesruncount=$((++downloadspeedbytesruncount))
        fi
        # Calculate the total of the $downloadspeedbyteslist and add it to $totaldownloadspeedbytes
        totaldownloadspeedbytes=`eval echo ${downloadspeedbyteslist[@]} | sed 's/ /+/g' | bc`
        # Record Download Speed average
        downloadspeedbytesaverage=`echo "scale=3; $totaldownloadspeedbytes/$downloadspeedbytesruncount"|bc -l`
# Average Total Upload Size ($uploadedbytesaverage)
        # if $uploadedbytes registers a non-zero value, increase $uploadedbytesruncount
        if [ $uploadedbytes != "0" ]
         then
                uploadedbytesruncount=$((++uploadedbytesruncount))
        fi
        # Calculate the total of the $uploadedbyteslist and add it to $totaluploadedbytes
        totaluploadedbytes=`eval echo ${uploadedbyteslist[@]} | sed 's/ /+/g' | bc`
        # Record Upload Size average
        uploadedbytesaverage=`echo "scale=0; $totaluploadedbytes/$uploadedbytesruncount"|bc -l`
# Average Upload Speed ($uploadspeedbytesaverage)
        # if $uploadspeedbytes registers a non-zero value, increase $uploadspeedbytesruncount
        if [ $uploadspeedbytes != "0.000" ]
         then
                uploadspeedbytesruncount=$((++uploadspeedbytesruncount))
        fi
        # Calculate the total of the $uploadspeedbyteslist and add it to $totaluploadspeedbytes
        totaluploadspeedbytes=`eval echo ${uploadspeedbyteslist[@]} | sed 's/ /+/g' | bc`
        # Record Upload Speed average
        uploadspeedbytesaverage=`echo "scale=3; $totaluploadspeedbytes/$uploadspeedbytesruncount"|bc -l`
# Average Total Time Taken ($totaltimeaverage)
        # if $totaltime registers a non-zero value, increase $totaltimeruncount
        if [ $totaltime != "0.000" ]
         then
                totaltimeruncount=$((++totaltimeruncount))
        fi
        # Calculate the total of the $totaltimelist and add it to $totaltime
        totaltotaltime=`eval echo ${totaltimelist[@]} | sed 's/ /+/g' | bc`
        # Record Total Time average
        totaltimeaverage=`echo "scale=3; $totaltotaltime/$totaltimeruncount"|bc -l`




###Calculation of MIN/MAX values
## DNS Lookup
        if (( $(echo "$dnslookupseconds > $maxdnslookupseconds" | bc -l) )); then
                maxdnslookupseconds=$dnslookupseconds
        fi
        if
        (( $(echo "$dnslookupseconds < $mindnslookupseconds" | bc -l) )); then
                mindnslookupseconds=$dnslookupseconds
        fi

## SSL Handshake
        if (( $(echo "$sslhandshakeseconds > $maxsslhandshakeseconds" | bc -l) )); then
                maxsslhandshakeseconds=$sslhandshakeseconds
        fi
        if
        (( $(echo "$sslhandshakeseconds < $minsslhandshakeseconds" | bc -l) )); then
                minsslhandshakeseconds=$sslhandshakeseconds
        fi
## TCP Handshake
        if (( $(echo "$tcphandshakeseconds > $maxtcphandshakeseconds" | bc -l) )); then
                maxtcphandshakeseconds=$tcphandshakeseconds
        fi
        if
        (( $(echo "$tcphandshakeseconds < $mintcphandshakeseconds" | bc -l) )); then
                mintcphandshakeseconds=$tcphandshakeseconds
        fi

## Pre-File Transfer
        if (( $(echo "$pretransferseconds > $maxpretransferseconds" | bc -l) )); then
                maxpretransferseconds=$pretransferseconds
        fi
        if
        (( $(echo "$pretransferseconds < $minpretransferseconds" | bc -l) )); then
                minpretransferseconds=$pretransferseconds
        fi

## First Response Byte
        if (( $(echo "$firstbyteseconds > $maxfirstbyteseconds" | bc -l) )); then
                maxfirstbyteseconds=$firstbyteseconds
        fi
        if
        (( $(echo "$firstbyteseconds < $minfirstbyteseconds" | bc -l) )); then
                minfirstbyteseconds=$firstbyteseconds
        fi

## Download Size
        if (( $(echo "$downloadedbytes > $maxdownloadedbytes" | bc -l) )); then
                maxdownloadedbytes=$downloadedbytes
        fi
        if
        (( $(echo "$downloadedbytes < $mindownloadedbytes" | bc -l) )); then
                mindownloadedbytes=$downloadedbytes
        fi

## Download Speed
        if (( $(echo "$downloadspeedbytes > $maxdownloadspeedbytes" | bc -l) )); then
                maxdownloadspeedbytes=$downloadspeedbytes
        fi
        if
        (( $(echo "$downloadspeedbytes < $mindownloadspeedbytes" | bc -l) )); then
                mindownloadspeedbytes=$downloadspeedbytes
        fi

## Upload Size
        if (( $(echo "$uploadedbytes > $maxuploadedbytes" | bc -l) )); then
                maxuploadedbytes=$uploadedbytes
        fi
        if
        (( $(echo "$uploadedbytes < $minuploadedbytes" | bc -l) )); then
                minuploadedbytes=$uploadedbytes
        fi


## Upload Speed
        if (( $(echo "$uploadspeedbytes > $maxuploadspeedbytes" | bc -l) )); then
                maxuploadspeedbytes=$uploadspeedbytes
        fi
        if
        (( $(echo "$uploadspeedbytes < $minuploadspeedbytes" | bc -l) )); then
                minuploadspeedbytes=$uploadspeedbytes
        fi


## Total Time
        if (( $(echo "$totaltime > $maxtotaltime" | bc -l) )); then
                maxtotaltime=$totaltime
        fi
        if
        (( $(echo "$totaltime < $mintotaltime" | bc -l) )); then
                mintotaltime=$totaltime
        fi



### Display info ###
echo -ne "

...................................................................................................................................
                                    Running mycurl with the following parameters
Initiated time: $scriptstartdate | CURL URL = $curlurl | Outputfile = $outputfile | Sleeptimer = $sleeptimer
...................................................................................................................................
Date                                                         `date --u`
Source IP                                                    $srcip          
Source Port                                                  $srcport          
Destnation IP                                                $dstip          
Destination Port                                             $dstport          
HTTP Version                                                 $httpversion          
Redirect URL                                                 $redirecturl          
Effective URL                                                $effectiveurl          
HTTP Response Code                                           $httpcode          
DNS Lookup Time                                              $dnslookupseconds    seconds
SSL Success                                                  $sslverifyresult   (0 = Success)
SSL Handshake Time                                           $sslhandshakeseconds     seconds
TCP Handshake Time                                           $tcphandshakeseconds     seconds
Time Taken Pre-File Transfer                                 $pretransferseconds     seconds (Commands, negotiations & protocol times)
Time Taken Till Response First Byte                          $firstbyteseconds     seconds (Pre-File Tranfer & Server Processing Times)
Download Size (Payload)                                      $downloadedbytes     bytes @ Average $downloadspeedbytes bytes/s
Upload Size (Payload)                                        $uploadedbytes     bytes @ Average $uploadspeedbytes bytes/s
Total Request Time                                           $totaltime     seconds
...Above Output appended to file \"$outputfile\"..." | tee -a $outputfile;




printf "\n\n---Runcount: $runcount - Totals and Averages:---"
# Time averages
printf "\n%-36s %-15s %-15s %-15s" "" "Average" "Best" "Worst"
printf "\n%-36s %-15s %-15s %-15s" "DNS Lookup Seconds" "$dnslookupsecondsaverage" "$mindnslookupseconds" "$maxdnslookupseconds"
printf "\n%-36s %-15s %-15s %-15s" "SSL Handshake Seconds" "$sslhandshakesecondsaverage" "$minsslhandshakeseconds" "$maxsslhandshakeseconds"
printf "\n%-36s %-15s %-15s %-15s" "TCP Handshake Seconds" "$tcphandshakesecondsaverage" "$mintcphandshakeseconds" "$maxtcphandshakeseconds"
printf "\n%-36s %-15s %-15s %-15s" "Pre-File Transfer Seconds" "$pretransfersecondsaverage" "$minpretransferseconds" "$maxpretransferseconds"
printf "\n%-36s %-15s %-15s %-15s" "First Response Byte Seconds" "$firstbytesecondsaverage" "$minfirstbyteseconds" "$maxfirstbyteseconds"
printf "\n%-36s %-15s %-15s %-15s" "Download Size bytes" "$downloadedbytesaverage" "$maxdownloadedbytes" "$mindownloadedbytes"
printf "\n%-36s %-15s %-15s %-15s" "Download Speed bytes/s" "$downloadspeedbytesaverage" "$maxdownloadspeedbytes" "$mindownloadspeedbytes"
printf "\n%-36s %-15s %-15s %-15s" "Upload Size bytes" "$uploadedbytesaverage" "$maxuploadedbytes" "$minuploadedbytes"
printf "\n%-36s %-15s %-15s %-15s" "Upload Speed bytes/s" "$uploadspeedbytesaverage" "$maxuploadspeedbytes" "$minuploadspeedbytes"
printf "\n%-36s %-15s %-15s %-15s" "Total Time Seconds" "$totaltimeaverage" "$mintotaltime" "$maxtotaltime"
# HTTP response code info
printf "\n"
echo -ne "-==HTTP Status Codes==-"
printf "\n%-10s %-10s %-10s" "200s $http200" "301s $http301 " "302s $http302" "303s $http303" "304s $http304" "401s $http401" "403s $http403" "404s $http404" "500s $http500" "501s $http501" "502s $http502" "503s $http503" "504s $http504"
printf "\n%-10s %-90s" "OTHR $otherhttpcodes" "Other known HTTP codes not listed here. View output file \"$outputfile\" for output log"
printf "\n%-10s %-90s" "UNKN $httpunknown" "Unknown HTTP response code received. View output file \"$outputfile\" for output log"

# Long status code version - currently disabled due to support for smaller screen sizes.
# printf "HTTP Status code totals"
# printf "\n%-25s %-10s %-90s" "200 Response code Count:" "$http200" "Successful: OK within timeout seconds"
# printf "\n%-25s %-10s %-90s" "301 Response code Count:" "$http301" "Redirection: Moved Permanently"
# printf "\n%-25s %-10s %-90s" "302 Response code Count:" "$http302" "Redirection: Found residing temporarily under different URI"
# printf "\n%-25s %-10s %-90s" "303 Response code Count:" "$http303" "Redirection: See Other"
# printf "\n%-25s %-10s %-90s" "304 Response code Count:" "$http304" "Redirection: Not Modified"
# printf "\n%-25s %-10s %-90s" "401 Response code Count:" "$http401" "Client Error: Unauthorized"
# printf "\n%-25s %-10s %-90s" "403 Response code Count:" "$http403" "Client Error: Forbidden"
# printf "\n%-25s %-10s %-90s" "404 Response code Count:" "$http404" "Client Error: Not Found"
# printf "\n%-25s %-10s %-90s" "500 Response code Count:" "$http500" "Server Error: Internal Server Error"
# printf "\n%-25s %-10s %-90s" "501 Response code Count:" "$http501" "Server Error: Not Implemented"
# printf "\n%-25s %-10s %-90s" "502 Response code Count:" "$http502" "Server Error: Bad Gateway"
# printf "\n%-25s %-10s %-90s" "503 Response code Count:" "$http503" "Server Error: Service Unavailable"
# printf "\n%-25s %-10s %-90s" "504 Response code Count:" "$http504" "Server Error: Gateway Timeout within timeout seconds"
# printf "\n%-25s %-10s %-90s" "OTH Response code Count:" "$otherhttpcodes" "Other known HTTP codes not listed here. View output file \"$outputfile\" for output log"
# printf "\n%-25s %-10s %-90s" "UNK Response code Count:" "$httpunknown" "Unknown HTTP response code received. View output file \"$outputfile\" for output log"



# keep track of script run count
runcount=$((runcount+1))

#return to top
printf '%s%s' "$ED" "$HOME"

#sleep
sleep $sleeptimer;     # Wait between requests - default is 2 seconds

done;
