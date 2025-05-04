# Commands useful to monitor network
- `sudo netstat -caput | grep $PID`
- `strace -p $PID -f -e trace=network -s 10000` Try to also use the options `-e %network,read,write`
- `sudo tcpdump -i any host $IP -w $file_to_write`
- `sudo tcpdump -i any host $IP -w trace.pcap`
