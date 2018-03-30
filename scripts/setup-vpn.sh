#!/bin/bash

sudo ip rule add table 128 from 172.104.88.81
sudo ip route add table 128 to 172.104.88.0/24 dev eth0
sudo ip route add table 128 default via 172.104.88.1
