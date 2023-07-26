#!/bin/bash

# Name:    SSNNameMatchCloudAPI
# Purpose: Execute the SSNNameMatchCloudAPI program

######################### Constants ##########################

RED='\033[0;31m' #RED
NC='\033[0m' # No Color

######################### Parameters ##########################

ssn=""
license=""

while [ $# -gt 0 ] ; do
  case $1 in
    --ssn) 
        if [ -z "$2" ] || [[ $2 == -* ]];
        then
            printf "${RED}Error: Missing an argument for parameter \'SSN\'.${NC}\n"  
            exit 1
        fi 

        ssn="$2"
        shift
        ;;
    --license) 
        if [ -z "$2" ] || [[ $2 == -* ]];
        then
            printf "${RED}Error: Missing an argument for parameter \'license\'.${NC}\n"  
            exit 1
        fi 

        license="$2"
        shift 
        ;;
  esac
  shift
done

########################## Main ############################
printf "\n===================== Melissa SSN Name Match Cloud API =====================\n"

# Get license (either from parameters or user input)
if [ -z "$license" ];
then
  printf "Please enter your license string: "
  read license
fi

# Check for License from Environment Variables 
if [ -z "$license" ];
then
  license=`echo $MD_LICENSE` 
fi

if [ -z "$license" ];
then
  printf "\nLicense String is invalid!\n"
  exit 1
fi

# Run project
if [ -z "$ssn" ];
then
    python3 SSNNameMatchPython3.py --license $license 
else
    python3 SSNNameMatchPython3.py --license $license --ssn "$ssn" 
fi

