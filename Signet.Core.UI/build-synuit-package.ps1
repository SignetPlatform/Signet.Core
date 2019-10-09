$SignetCoreDir = Resolve-Path "./../"
$Arg = "electron-builder build --macos --x64 --config ./electron-sidechain-builder.json"
if ( Test-Path -Path $SignetCoreDir\Signet.Core.UI\app-builds )
{
  Remove-Item $SignetCoreDir\Signet.Core.UI\app-builds -Force -Recurse
}
if ( Test-Path -Path $SignetCoreDir\Signet.Core.UI\daemon )
{
  Remove-Item $SignetCoreDir\Signet.Core.UI\daemon -Force -Recurse
}
Set-Location $SignetCoreDir\Signet.FullNode\src
Start-Process dotnet -ArgumentList "clean" -Wait
Set-Location .\Signet.SynuitD
Start-Process dotnet -ArgumentList "publish -r osx-x64 -o $SignetCoreDir\Signet.Core.UI\daemon" -Wait
Set-Location $SignetCoreDir\Signet.Core.UI
(Get-Content .\main.ts).Replace("const buildForSidechain = false;","const buildForSidechain = true;") | Set-Content .\main.ts
Start-Process npm -ArgumentList "install" -Wait
Start-Process npm -ArgumentList "install npx" -Wait
Start-Process npm -ArgumentList "run build:prod" -Wait
Start-Process "npx" -ArgumentList $Arg -Wait
