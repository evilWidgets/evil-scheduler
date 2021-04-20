# ref: https://resources.oreilly.com/examples/0636920024132/blob/master/Get-PrivateProfileString.ps1 
# this is a slapped together version of ScrapConfg (on my other repo) 

# command args 
[CmdletBinding()]
param ( 
    
#todo: devise a better strat than calling the same config file all of the time...
    [Parameter(Mandatory = $true)]
    [string]
    $ConfigFile,
    
    # the section we need to return
    [Parameter(Mandatory = $true)]
    [string]
    $Section, 

    # the and specific option to call 
    [Parameter(Mandatory = $true)] 
    [string]
    $Key 
)

<# for later... 
# hack!! 
. .\test-param.ps1

if ((Test-Path $ConfigFile) -eq $false) 
{ 
    Write-Host "Please Supply a Config File." 
    exit
} 

if (Test-Param($Section) -eq $false) 
{ 
    Write-Host "Please Supply a Section within $ConfigFile, output: $Section"
    exit
} 

if (Test-Param($Key) -eq $false) 
{ 
    Write-Host "Please upply a key within $Section of $ConfigFile" 
    exit
}
#>

$payload = @"
[DllImport("kernel32.dll")]
public static extern uint GetPrivateProfileString( 
string lpAppName,
string lpKeyName,
string lpDefault, 
StringBuilder lpReturndString,
uint nSize, 
string lpFileName);
"@

# alot of this details are mutable
$type = add-type -MemberDefinition $payload -Name "GetPriveProfileString" -Namespace Win32Utils -Using System.Text -PassThru
$builder = New-Object System.Text.StringBuilder 1024 
$null = $type::GetPrivateProfileString($Section, $Key, "", $builder, $builder.Capacity, $ConfigFile) 

# return our query.
$builder.ToString()


