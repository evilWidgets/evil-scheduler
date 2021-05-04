# ref: https://devblogs.microsoft.com/scripting/create-a-powershell-scheduled-job/
# This is an example of creating a scheduled job. 
# the first part is just creating a stub job, that does nothing 
# known as "noop-job"

# beware!!! !
# you will get THIS: Register-ScheduledJob : An access denied error occurred when registering scheduled job definition NoOp.  Try running Windows PowerShell with elevated user rights; that is, Run As Administrator.
# if you don't run as admin... 

<# 


;; job name, job author 
[job]
jobName = "NoOp"
jobType = "useless"


;; job trigger (schedule/event)
[trigger]
Interval = "daily"
At = "2:00pm" 

;; well... options 
[option]


#>

# this is just an example.
# setup our trigger 
$dailyTrigger  =  New-JobTrigger -Daily -At "2:00pm"

# configure the Job 
$option = New-ScheduledJobOption -StartIfOnBattery -StartIfIdle 

# create a script block for the job to execute: 
$action = "add-content C:\temp\test.txt $(date)"
$jobAction = [scriptblock]::Create($action)

# Now, Register the scheduled job. 
# todo: add support for running a scheduled job as a normal user... 
# please input your admin/ elevated creds
Register-ScheduledJob -Name "NoOp" -ScriptBlock $jobAction -Trigger $dailyTrigger -ScheduledJobOption $option -Credential (Get-Credential)
