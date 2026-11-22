# Assignment 1 - Linux, Bash and Networking
A set of bash scripts that shows system information, check disk usage, and test network connectivity.

## Setup

Clone the repository and make the script executable
    git clone <>
    cd assignment-1
    chmod +x *.sh

Requires a Linux environment (tested on WSL Ubuntu).

## Usage
    ./system-info.sh
    ./disk-check.sh 80
    ./network-check.sh localhost
    ./network-check.sh google.com 443

disk-check.sh takes a threshold (1-100) and an optional path.
network-check.sh takes a host and an optional port (1-65535)

## Testing

Run the provided grader: 
    ./grade.sh
Exit codes used by scripts:
- 0 means success
- 1 means a runtime failure
- 2 means invalid input or a missing arguments

Logs are written to logs/ folder

## Assumptions
- scripts are run on Linux (Tested on WSL Ubuntu)
- The tools ping, nc, getent and ip are installed
- Some networks block ping, so network-check.sh may exit 1 on those networks.
