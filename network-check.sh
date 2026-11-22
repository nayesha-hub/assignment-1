#!/usr/bin/env bash

# 2. define variables
host_name=$1
port=${2:-}

# 3. set if for arguments error
if [ "$#" -lt 1 ]; then
	echo "$(date) - Error: Hostname or IP address not provided" >> logs/network-check.log 
	echo "Error: Hostname or IP address not provided"
	exit 2
fi

# 4. resolve ip
echo "=== Resolving IP address ==="
resolved_ip=$(getent hosts "$host_name" | awk '{print $1}')


if [ -z "$resolved_ip" ]; then
	echo "$(date) - Error: Host resolution failure" >> logs/network-check.log
	echo "Error: Host resolution failed"
	exit 2
else
	echo "Success: $host_name resolved to $resolved_ip"
	echo "$(date) - Hostname resolution Successful: $host_name resolved to $resolved_ip" >> logs/network-check.log 
	echo "Resolved IP: $resolved_ip"
fi

# 6. check connectivity and port
if ping -c 2 -W 3 "$resolved_ip" > /dev/null 2>&1; then
	echo "$(date) - Ping to $host_name successful" >> logs/network-check.log
	echo "Ping to $host_name successful"
else
	echo "$(date) - Error: Ping to $host_name not successful" >> logs/network-check.log
	echo "Ping to $host_name not successful"
exit 1
fi
sleep 1
echo "=== Network Interface Information ==="
ip addr
echo "$(date) - Success: Network Interface Information displayed" >> logs/network-check.log
sleep 1
if [ -n "$port" ]; then
	echo " === Checking Port ==="
	
	if ! [[ "$port" =~ ^[0-9]+$ ]]; then
		echo "Error: Port must be an integer"
		echo "$(date) - Error: Invalid port value" >> logs/network-check.log
		exit 2
	fi
	if [ "$port" -lt 1 ] || [ "$port" -gt 65535 ]; then
		echo "Port must be between 1-65535"
		echo "$(date) - Error: Invalid port range" >> logs/network-check.log
		exit 2
	fi	
	if nc -z -w 5 "$host_name" "$port"; then
	echo "$(date) - TCP connection successful" >> logs/network-check.log
	echo " TCP connection successful"
else
	echo "$(date) - Error: TCP connection not successful" >> logs/network-check.log
	echo "TCP connection error"
	exit 1
	fi
fi

echo "Network check successful"
echo "$(date) - Network check successful" >> logs/network-check.log
