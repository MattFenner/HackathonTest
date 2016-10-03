$invPath = (Get-Variable MyInvocation).Value.MyCommand.Path

$folder = Split-Path $invPath -Parent
#get folder name
$name = Split-Path $folder -Leaf

#build
echo "--------------"
echo "building $name"
Invoke-Expression "& 'C:\Program Files (x86)\MSBuild\14.0\Bin\MSBuild.exe' '$folder/$name.csproj' /p:Configuration=Release"

#deploy
Invoke-Expression "& aws deploy push --application-name $name --s3-location s3://mfdeploytest/$name.zip --source bin/Release"