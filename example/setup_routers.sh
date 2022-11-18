#!/bin/bash
# prog R1_INT1 R2_INT1 R[1|2]_INT2

R1_INT1="${1:-18}"
R2_INT1="${2:-19}"
R1_INT2="${3:-20}"
R2_INT2=$R1_INT2

echo "R1 interface 1: 172.$R1_INT1.0.0/16"
echo "R1 interface 2: 172.$R1_INT2.0.0/16"
echo "R2 interface 1: 172.$R2_INT1.0.0/16"
echo "R2 interface 2: 172.$R2_INT2.0.0/16"

echo "Enable IPv4 packet forwarding"
docker exec R1 sed -i "s/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/" /etc/sysctl.conf
docker exec R1 sysctl -p
docker exec R2 sed -i "s/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/" /etc/sysctl.conf
docker exec R2 sysctl -p

echo "Setup zebra.conf"
docker exec R1 mkdir /etc/quagga
docker exec R1 bash -c "cat > /etc/quagga/zebra.conf << EOF
hostname R1zebra
password vRouter
log stdout
EOF"

docker exec R2 mkdir /etc/quagga
docker exec R2 bash -c "cat > /etc/quagga/zebra.conf << EOF
hostname R2zebra
password vRouter
log stdout
EOF"

echo "Setup bgpd.conf"
docker exec R1 bash -c "cat > /etc/quagga/bgpd.conf << EOF
! BGP configuration for R1
!
hostname R1bgp
password vRouter
!
router bgp 65000
bgp router-id 172.$R1_INT2.0.2
timers bgp 3 9
neighbor 172.$R1_INT2.0.3 remote-as 65001
neighbor 172.$R1_INT2.0.3 ebgp-multihop
neighbor 172.$R1_INT2.0.3 timers connect 5 
neighbor 172.$R1_INT2.0.3 advertisement-interval 5
network 172.$R1_INT1.0.0/16
!
log stdout
EOF"

docker exec R2 bash -c "cat > /etc/quagga/bgpd.conf << EOF
! BGP configuration for R2
!
hostname R2bgp
password vRouter
!
router bgp 65000
bgp router-id 172.$R2_INT2.0.3
timers bgp 3 9
neighbor 172.$R1_INT2.0.2 remote-as 65000
neighbor 172.$R1_INT2.0.2 ebgp-multihop
neighbor 172.$R1_INT2.0.2 timers connect 5 
neighbor 172.$R1_INT2.0.2 advertisement-interval 5
network 172.$R2_INT1.0.0/16
!
log stdout
EOF"

