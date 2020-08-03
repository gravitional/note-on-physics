#!/bin/bash

dev_addr="2: enp0s31f6: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 8c:ec:4b:91:d6:5b brd ff:ff:ff:ff:ff:ff
    inet 192.168.218.191/24 brd 192.168.218.255 scope global enp0s31f6
       valid_lft forever preferred_lft forever
    inet6 2401:de00:1:2218:8eec:4bff:fe91:d65b/64 scope global dynamic mngtmpaddr noprefixroute 
       valid_lft 2591800sec preferred_lft 604600sec
    inet6 fe80::8eec:4bff:fe91:d65b/64 scope link 
       valid_lft forever preferred_lft forever"
echo $dev_addr |\
grep -Po "${dev_name}[ ]+inet[ ]+[ \w\d\./]+brd" | `#用grep 提取出address一行`\
sed "s/${dev_name} \{1,\}inet//g" | sed "s/brd//g"
