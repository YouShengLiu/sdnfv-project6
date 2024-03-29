SHELL := /bin/bash


all:
	docker compose up -d

	sudo ovs-vsctl add-br ovs
	sudo ovs-vsctl set-controller ovs tcp:127.0.0.1:6633
	sudo ovs-vsctl set bridge ovs protocols=OpenFlow14

	sudo ovs-docker add-port ovs eth1 R1 --ipaddress=172.20.0.2
	sudo ovs-docker add-port ovs eth1 R2 --ipaddress=172.20.0.3
	sudo ovs-docker add-port ovs eth1 R3 --ipaddress=172.20.0.4
	
	docker exec R1 ip route add 172.20.0.0/16 dev eth1
	docker exec R2 ip route add 172.20.0.0/16 dev eth1
	docker exec R3 ip route add 172.20.0.0/16 dev eth1
clean:
	docker compose down
	sudo ovs-vsctl del-br ovs
