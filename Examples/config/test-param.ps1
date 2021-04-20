function Test-Param {
    param (
        [string]$inputParam
    )

    if ($inputParam) { 
        return $true
    } else { 
        return $false 
    }
}
    
