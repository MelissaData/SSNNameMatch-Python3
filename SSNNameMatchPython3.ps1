<#
.SYNOPSIS
    Runs the Melissa SSN Name Match Cloud API Python 3 sample.

.DESCRIPTION
    This script runs SSNNameMatchPython3.py with python3, passing along the license
    and (if supplied) the SSN.

    Overall flow:
      1. Resolve the license (parameter, prompt, or MD_LICENSE environment variable).
      2. Run SSNNameMatchPython3.py: with the SSN if it was supplied, otherwise with
         only the license (the Python program prompts for the SSN).

.PARAMETER ssn
    Social Security Number to test.

.PARAMETER license
    License string. Resolved in this order:
      1. This parameter.
      2. An interactive prompt, if the parameter was not supplied.
      3. The MD_LICENSE environment variable, if the prompt was left blank.
    Note that the environment variable is the last resort, not the first: running
    without -license always prompts, even when MD_LICENSE is set.

.PARAMETER quiet
    Accepted for parity with other sample scripts; not currently used to suppress output.

.EXAMPLE
    .\SSNNameMatchPython3.ps1 -license "<your_license_string>"

.EXAMPLE
    .\SSNNameMatchPython3.ps1 -ssn "111223333" -license "<your_license_string>"
#>

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
# No SSN supplied -> run with only the license (the program prompts); otherwise pass it through.
if ([string]::IsNullOrEmpty($ssn)) {
  python3 SSNNameMatchPython3.py --license $license
}
else {
  python3 SSNNameMatchPython3.py --license $license --ssn $ssn
}
