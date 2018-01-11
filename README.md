mycurl is a bash script to conitnuously run curl and provide live human readable
output.

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
