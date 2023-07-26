# Name:    SSNNameMatchCloudAPI
# Purpose: Execute the SSNNameMatchCloudAPI program

######################### Parameters ##########################
param(
    $ssn = '', 
    $license = '', 
    [switch]$quiet = $false
    )

########################## Main ############################
Write-Host "`n======================= Melissa SSN Name Match Cloud API =======================`n"

# Get license (either from parameters or user input)
if ([string]::IsNullOrEmpty($license) ) {
  $license = Read-Host "Please enter your license string"
}

# Check for License from Environment Variables 
if ([string]::IsNullOrEmpty($license) ) {
  $license = $env:MD_LICENSE 
}

if ([string]::IsNullOrEmpty($license)) {
  Write-Host "`nLicense String is invalid!"
  Exit
}

# Run project
if ([string]::IsNullOrEmpty($ssn)) {
  python3 SSNNameMatchPython3.py --license $license 
}
else {
  python3 SSNNameMatchPython3.py --license $license --ssn $ssn
}
