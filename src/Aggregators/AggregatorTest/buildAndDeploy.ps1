$invPath = (Get-Variable MyInvocation).Value.MyCommand.Path

$folder = Split-Path $invPath -Parent
#get folder name
$name = Split-Path $folder -Leaf

#build
echo "--------------"
echo "building $name"
Invoke-Expression "& 'C:\Program Files (x86)\MSBuild\14.0\Bin\MSBuild.exe' '$folder/$name.csproj' /p:Configuration=Release"

#create deploy revision
echo "creating deployment revision"
Copy-Item -Path "$folder/appspec.yml" -Destination "$folder/bin/Release"
Invoke-Expression "& aws deploy push --application-name $name --s3-location s3://mfdeploytest/$name.zip --source '$folder/bin/Release'"

echo "deploying $name"
Invoke-Expression "& aws deploy create-deployment --application-name $name --s3-location bucket=mfdeploytest,key=AggregatorTest.zip,bundleType=zip --deployment-group-name $name"