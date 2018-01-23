mycurl is a bash script to conitnuously run curl requests and provide live, tracked, calculated, human readable
output that is also saved for troubleshooting/investigative purposes.

Often times when investigating slow website response or intermittend website downtime it's difficult to have a quick view of what exactly is causing these issues. With curl being an amazing tool to investigate such issues it does lack the native tracking and calculation of data over time.

That said it is possible to extract this information with curl, however it is normally not easily readible and especially with intermittent issues not easily tracked and calculated over time.

Having this information readily available often assists with quickly identifying root cause whilst troubleshooting intermittent issues in webserver(s). Simply running a curl request repeatedly isn't always fruitful as the previous information is lost. Even when saving this information in a file it generally takes some time as the data isn't easily analyzed over time and lacks tracking/computation of the output across all curl requests ran.

Due to this I wrote a bash script to assist me with quickly and easily extracting the above info. Here is a rough summary of what mycurl will provide.

Live info (for each curl) included in mycurl output:
- Date/time
- Source/Destination IP/port pair
- HTTP version
- Redirect/Effective URL
- Response code
- TCP/SSL handshake time
- Time Taken Pre-File Transfer
- Time Taken Till Response First Byte
- Download Size (Payload)
- Upload Size (Payload)
- Average Download bytes/s
- Average Upload bytes/s
- Total Request Time

Latency time info tracking (for all curl requests over script runtime - runcount is also tracked and incrimented) included in mycurl output:
Average/Best/Worst tracked for all curls ran over time including:
- DNS lookup time
- TCP/SSL handshake time
- Pre-file transfer time
- Time taken till response first byte
- Download/Upload size
- Average bytes/s
- Total Request Time
And tracking of HTTP Reponse Status Codes, incrementing live as responses are received. - This is helpful should unwanted responses codes be intermittent.

When troubleshooting slow website response issues it's nice to have a live view of what is impacting the response time to be slow - especially on average as this data sometimes points to a different root cause.


Find out how to use native curl by reading [the curl.1 man
page](https://curl.haxx.se/docs/manpage.html) or [the MANUAL
document](https://curl.haxx.se/docs/manual.html). Find out how to install Curl
by reading [the INSTALL document](https://curl.haxx.se/docs/install.html).
mycurl leverages curl and simply loops it while changing the displayed output
and sending it to a local file. Therefore it is safe to say that having curl
installed is a prerequisite.

libcurl is the library curl is using to do its job. It is readily available to
be used by your software. Read [the libcurl.3 man
page](https://curl.haxx.se/libcurl/c/libcurl.html) to learn how!

## Contact

Currently there are no other contributors to the project however if you have
problems, questions, ideas or suggestions, please contact me at
eugene.wiehahn@gmail.com .

## Git

To download the very latest source off the Git server do this:

    git clone https://github.com/wiehahne/mycurl

With the script cloned you can either execute it by running './mycurl'
or configure an [alias] (http://www.linfo.org/alias.html)
or move it to your bin directory.

## mycurl usage

Syntax for use: ./mycurl (url) (sleeptimer in seconds) (outputfile)
In order to execute a quick run by simply specifying "curl <url>" there is a
default sleep timer of 2 seconds and output file of './mycurl_output.log'

## Known issues

Currently with the way mycurl updates the screen live and rewrites all text to do so it normally breaks when:
1. Adjusting the terminal window size (sometimes works)
2. Running a terminal window size smaller than the printed output.

Although irritating sometimes are easily worked around. Please refrain from adjusting your terminal window size and/or running mycurl in a terminal window too small to output all the required text. Text output has been kept to a minimum to ensure all screen sizes are supported.

I haven't had time to focus on fixing this however if you want to give it a bash feel free to hack at it and let me know.
