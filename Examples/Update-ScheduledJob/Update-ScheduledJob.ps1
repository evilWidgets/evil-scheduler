# This is an example of updating a scheduled job. 
# the first part is just updating a stub job, that does nothing 
# known as "noop-job"


$jobName = "NoOp"

if (Get-ScheduledJob -Name $jobAction -eq $true) { 
    Unregister-ScheduledJob -Name $jobName -Force
} else { 
    Write-Host "Job does not Exist."
    Exit
}

# Once Job is removed, you can then setup a new job, using new parameters (presumably)

# setup our trigger 
$dailyTrigger  =  New-JobTrigger -Daily -At "1:00pm"

# configure the Job 
$option = New-ScheduledJobOption -StartIfOnBattery -StartIfIdle 

# create a script block for the job to execute: 
$action = "Write-Host NoOp"
$jobAction = [scriptblock]::Create($action)

# Now, Register the scheduled job. 
# todo: add support for running a scheduled job as a normal user... 
# please input your admin/ elevated creds
Register-ScheduledJob -Name "NoOp" -ScriptBlock $jobAction -Trigger $dailyTrigger -ScheduledJobOption $option -Credential (Get-Credential)
