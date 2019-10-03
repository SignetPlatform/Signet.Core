$upstream_repo = "git@github.com:SignetPlatform/Signet.Core.git"
$submodule_name = "Signet.FullNode"
$temp_branch_name = "submodule-update"
$branch = "signet.core_1.0"
$temp_folder = 'submodule-update-temp-branch'
$branch_submodule_to_update = "cleanup"

Write-Host "Cloning..." -foregroundcolor "magenta"
git clone -b $branch $upstream_repo $temp_folder
cd $temp_folder

Write-Host "Creating new branch called $temp_branch_name" -foregroundcolor "magenta"
git checkout -b $temp_branch_name

git push -u origin $temp_branch_name
git status

Write-Host "Updating the submodule '$submodule_name'" -foregroundcolor "magenta"
git submodule update --init --recursive
git status

cd $submodule_name
git branch -a
git reset --hard origin/$branch_submodule_to_update
git status
cd ..
git status
git add --all
git status

Write-Host "Committing and pushing to the new branch..." -foregroundcolor "magenta"
git commit -m "updated $submodule_name submodule"
git push -u origin $temp_branch_name
cd ..

Write-Host "Trying to remove folder $temp_folder..." -foregroundcolor "magenta"
Remove-Item -Path $temp_folder -Force -Recurse

Write-Host "Done. Don't forget to delete your branch once it's merged into master." -foregroundcolor "magenta"
Read-Host "Press ENTER"