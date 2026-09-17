# 1. shebang
#!/usr/bin/env bash

# 2. name the variables
if [ "$#" -lt 1 ]; then
	echo "$(date) - Error: Missing threshold argument" >> logs/disk-check.log
	echo "Error: threshold is required"
	exit 2
fi
threshold=$1
path=${2:-/}

# 3. set the conditions
if ! [[ "$threshold" =~ ^[0-9]+$ ]]; then
	echo "$(date) - Error: theshold is not an integer" >> logs/disk-check.log
	echo "Error: threshold is not an integer"
	exit 2
fi
if [ "$threshold" -lt 1 ] || [ "$threshold" -gt 100 ]; then
	echo "$(date) - Error: threshold value must be between 1-100" >> logs/disk-check.log
	echo "Error: Invalid input, check log file for details"
	exit 2
fi
# 4. set and print disk usage
d_usage=$(df -h "$path" | awk 'NR==2 {print $5}')
echo "Disk Usage: $d_usage"

# 5. remove % and reset variable for readability ad comparability
d_usage=${d_usage%\%}

# 6. if to compare disk usage to threshold
if [ "$d_usage" -lt "$threshold" ]; then
	echo "$(date) - Disk usage is below threshold" >> logs/disk-check.log
	echo "Disk usage is below threshold" 
	exit 0
else
	echo "$(date) - Error: Disk usage has exceeded threshold" >> logs/disk-check.log
	echo "Error: Disk usage has exceeded or reached threshold"
exit 1
fi

