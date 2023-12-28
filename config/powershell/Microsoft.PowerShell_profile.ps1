#region conda initialize
# !! Contents within this block are managed by 'conda init' !!
If (Test-Path "conda") {
    (& "conda" "shell.powershell" "hook") | Out-String | ?{$_} | Invoke-Expression
    &"conda" "activate" "user"
}
#endregion

function Set-Proxy {
    param (
        [string]$Proxy="http://127.0.0.1:10801"
    )
    $env:HTTPS_PROXY=$Proxy
    $env:HTTP_PROXY=$proxy
    $env:ALL_PROXY=$Proxy
}

function Reset-Proxy {
    $env:HTTPS_PROXY=""
    $env:HTTP_PROXY=""
    $env:ALL_PROXY=""
}

function Show-Proxy {
    Write-Host "HTTP_PROXY:  " $env:HTTP_PROXY
    Write-Host "HTTPS_PROXY: " $env:HTTPS_PROXY
    Write-Host "ALL_PROXY:   " $env:ALL_PROXY
}

function Get-HostPrompt() {
    $user = $Env:USER ?? $Env:UserName
    $hostname = $Env:HOSTNAME ?? $Env:ComputerName
    return "$user@$hostname "
}

function prompt {
    $now = Get-Date -Format "HH:mm:ss"
    $ESC = [char]27
    $hostprompt = Get-HostPrompt
    "PS $ESC[94m$now$ESC[0m $Env:CONDA_PROMPT_MODIFIER" + "$hostprompt$ESC[96m$(Get-Location)$ESC[0m`r`n$(" + "*(Get-Location -Stack).Count)$ESC[92m→$ESC[0m "
}

Set-PSReadLineOption -PredictionSource History
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
# Set-PSReadlineKeyHandler -Chord Tab -Function PossibleCompletions
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
