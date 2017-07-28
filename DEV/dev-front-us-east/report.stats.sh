#!/bin/bash

show_stats() {
#echo -ne "$1 "
#grep "$1" $2 | grep ' /runfile' | grep 'ssp=4' | grep -v '" 404\|" 200 '
#grep "$1" $2 | grep ' /r/\| /runfile' | grep 'ssp=4' | wc -l
#return

grep "$1" $2 | grep ' /r/\| /runfile' | grep '" 200' | wc -l && \
return
grep "$1" $2 | grep ' /r/\| /runfile' | grep '" 200' | wc -l && \
grep "$1" $2 | grep ' /r/'| grep '" 404' | wc -l && \
grep "$1" $2 | grep ' /r/'| grep -v '" 404\|" 200 ' | wc -l && \
grep "$1" $2 | grep ' /runfile_noscript'| grep '" 200' | wc -l && \
grep "$1" $2 | grep ' /runfile_noscript'| grep -v '" 200' | wc -l

}



show_stats "22/Nov/2016" "access_2016-11-21.log* access_2016-11-22.log*"
show_stats "23/Nov/2016" "access_2016-11-22.log* access_2016-11-23.log*"
show_stats "24/Nov/2016" "access_2016-11-23.log* access_2016-11-24.log*"
show_stats "25/Nov/2016" "access_2016-11-24.log* access_2016-11-25.log*"
show_stats "26/Nov/2016" "access_2016-11-25.log* access_2016-11-26.log*"
show_stats "27/Nov/2016" "access_2016-11-26.log* access_2016-11-27.log*"
show_stats "28/Nov/2016" "access_2016-11-27.log* access_2016-11-28.log*"
show_stats "29/Nov/2016" "access_2016-11-28.log* access_2016-11-29.log*"
show_stats "30/Nov/2016" "access_2016-11-29.log* access_2016-11-30.log*"
exit 0

#show_stats "24/Nov/2016:10" "access.log*"
#show_stats "24/Nov/2016:11" "access.log*"
show_stats "24/Nov/2016:13" "access_2016-11-24.log*"
show_stats "24/Nov/2016:14" "access_2016-11-24.log*"
show_stats "24/Nov/2016:15" "access_2016-11-24.log*"
show_stats "24/Nov/2016:16" "access_2016-11-24.log*"
show_stats "24/Nov/2016:17" "access_2016-11-24.log*"
show_stats "24/Nov/2016:18" "access_2016-11-24.log*"
show_stats "24/Nov/2016:19" "access_2016-11-24.log*"
show_stats "24/Nov/2016:20" "access_2016-11-24.log*"
show_stats "24/Nov/2016:21" "access_2016-11-24.log*"
show_stats "24/Nov/2016:22" "access_2016-11-24.log*"
show_stats "24/Nov/2016:23" "access_2016-11-24.log*"


exit 0

show_stats "23/Nov/2016:10" "access.log*"
show_stats "23/Nov/2016:11" "access.log*"
show_stats "23/Nov/2016:12" "access.log*"
#----------------------------------------
show_stats "23/Nov/2016:13" "access.log*"
show_stats "23/Nov/2016:14" "access.log*"