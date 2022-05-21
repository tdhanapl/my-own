###################shell script######3
 date --date="yesterday" | awk '{print $1}'
 date | awk '{print $1}'
  date +"%a"
  date --date="yesterday"
  date --date="yesterday" | awk '{print $1}'
#!/bin/bash
day=$(date +"%a")
touch postgres-$day.log
##################################
#!/bin/bash
#AUTH
previousday=$(date --date="yesterday" | awk '{print $1}')
day=$(date +"%a")
rm -rf postgres-$previousday.log.xz
xz -v -9 -f  postgres-$previousday.log
