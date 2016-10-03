$invPath = (Get-Variable MyInvocation).Value.MyCommand.Path

$buildScripts = Get-ChildItem -File -Filter buildAndDeploy.ps1 -Recurse

#run all child scripts
ForEach ($script in $buildScripts) 
{
    if($script.FullName -ne $invPath) 
    {
        Invoke-Expression $script.FullName
    }
}

