#!/usr/bin/expect -f  
set appName [lindex $argv 0 ]     
set ip [lindex $argv 1 ]  
set user [lindex $argv 2 ]  
set password [lindex $argv 3 ]  
#remote login
spawn ssh ${user}@$ip      
expect {  
"*yes/no" { send "yes\r"; exp_continue}  
"*assword:" { send "$password\r" }  
}  
#set timeout 1
#expect "Last login"  
expect "$*"  
set tomcat_home "/u01/deploy/project/tomcat_${appName}"
send "cd ${tomcat_home}\r"
#send "ls\r"
puts ${tomcat_home}
#stop
send "sh tomcat.sh stop\r"
send "sleep 5s\r"
send "ps aux | grep  ${tomcat_home} | grep -v grep | awk '{print \$2 }' | xargs kill -9 \r"
#send "sleep 1s\r"
puts "${appName} stop finished!"
#send "sleep 3s\r"
send "exit 0\r"
expect eof
