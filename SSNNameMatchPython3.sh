#!/bin/bash

# Runs the Melissa SSN Name Match Cloud API Python 3 sample.
#
# This script runs SSNNameMatchPython3.py with python3, passing along the license
# and (if supplied) the SSN.
#
# Overall flow:
#   1. Parse the command-line options below.
#   2. Resolve the license (--license, then a prompt, then the MD_LICENSE environment variable).
#   3. Run SSNNameMatchPython3.py: with the SSN if it was supplied, otherwise with only
#      the license (the Python program prompts for it).
#
# Options (each takes a value):
#   --ssn       Social Security Number to test.
#   --license   License string. If omitted, the script prompts for it; if the prompt
#               is left blank, it falls back to MD_LICENSE. Running without --license
#               always prompts, even when MD_LICENSE is set.
#
# SSNNameMatchPython3.py is found relative to the current directory, so run the script from its own folder.
#
# Examples:
#   ./SSNNameMatchPython3.sh --license "your-license"
#   ./SSNNameMatchPython3.sh --ssn "111223333" --license "your-license"

######################### Constants ##########################

RED='\033[0;31m' #RED
NC='\033[0m' # No Color

######################### Parameters ##########################

ssn=""
license=""

# Read each --flag and its value. A flag with no value, or whose value starts with
# "-", is an error. Unrecognized options are ignored.
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
# No SSN supplied -> run with only the license (the program prompts); otherwise pass it through.
if [ -z "$ssn" ];
then
    python3 SSNNameMatchPython3.py --license "$license"
else
    python3 SSNNameMatchPython3.py --license "$license" --ssn "$ssn"
fi

