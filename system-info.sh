# 1. shebang
#!/usr/bin/env bash

# 2. set error handling
set -euo pipefail

# 3. set error handling function
on-error(){
	echo "$(date) - Command failed: $BASH_COMMAND" >> logs/system-info.log
       	echo "$(date) - System Information Collection Unsuccessful" >> logs/system-info.log
	echo "An error occurred while collecting system information. check log files for details."
	exit 1
}

# 4. call and trap error function
trap 'on-error' ERR

# 5. log the execution time
echo "$(date) - Collecting System Information" >> logs/system-info.log

# 6. print system info to the terminal screen
echo "=== System Information ==="
echo "Host Name: $(hostname)"
echo "Current User: $USER"
echo "Date: $(date +%Y-%m-%d)"
echo "Time: $(date +%H:%M:%S)"
echo "Operating System: $(uname)"
echo "Kernel Version: $(uname -r)"
echo "Uptime: $(uptime -p)"
echo "CPU Info: $(grep 'model name' /proc/cpuinfo | head -n 1)"
echo "CPU Cores: $(nproc)"
echo "Memory Info:"
grep -E "MemTotal|MemFree|MemAvailable" /proc/meminfo
echo "Current Working Directory: $(pwd)"

# 7. check success and log
echo "$(date) - System Information Collection Successful" >> logs/system-info.log


