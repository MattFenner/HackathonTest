$ErrorActionPreference = "Stop"

$invPath = (Get-Variable MyInvocation).Value.MyCommand.Path

cd (Split-Path $invPath -Parent)
$buildScripts = Get-ChildItem -File -Filter buildAndDeploy.ps1 -Recurse -ErrorAction SilentlyContinue

#run all child scripts
ForEach ($script in $buildScripts) 
{
    if($script.FullName -ne $invPath) 
    {
        Invoke-Expression $script.FullName
    }
}