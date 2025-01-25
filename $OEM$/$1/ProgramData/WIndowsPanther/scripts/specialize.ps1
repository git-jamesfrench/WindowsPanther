Set-ExecutionPolicy -Scope 'LocalMachine' -ExecutionPolicy 'RemoteSigned' -Force;

$ParentPath = "C:\ProgramData\WindowsPanther\scripts"
$FilesToExecute = @(
    "setup.ps1",
    "packages-remover.ps1"
)

$TotalFiles = $FilesToExecute.Count
$Counter = 0
foreach ($File in $FilesToExecute) {
    $FullPath = Join-Path -Path $ParentPath -ChildPath $File

    if (Test-Path $FullPath) {
        try {
            $Counter++
            $PercentComplete = ($Counter / $TotalFiles) * 100
            Write-Progress -Activity "Windows Panther is configuring your installation, do not close this window." -PercentComplete $PercentComplete -Status "Progress:"

            & $FullPath
        } catch {
            Write-Warning "Failed to execute ${File}: $_"
        }
    } else {
        Write-Warning "File not found: $FullPath"
    }
}

Write-Host "Execution completed!" -ForegroundColor Green