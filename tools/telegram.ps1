param(
    [string]$Action = "send",
    [string]$Message = "",
    [int]$TimeoutSeconds = 300
)

$configPath = "C:\Users\super\.agents\config\telegram.json"
if (-not (Test-Path $configPath)) {
    Write-Error "Telegram configuration not found at $configPath"
    exit 1
}

$config = Get-Content $configPath -Raw | ConvertFrom-Json
$token = $config.bot_token
$chatId = $config.chat_id

function Send-TelegramMessage {
    param([string]$Text)
    $body = @{
        chat_id = $chatId
        text = $Text
    } | ConvertTo-Json -Compress
    
    $tempFile = [System.IO.Path]::GetTempFileName()
    [System.IO.File]::WriteAllText($tempFile, $body, [System.Text.Encoding]::UTF8)
    
    $res = & curl.exe -s -X POST "https://api.telegram.org/bot$token/sendMessage" `
        -H "Content-Type: application/json" `
        --data-binary "@$tempFile"
    
    Remove-Item $tempFile -Force -ErrorAction SilentlyContinue
    return $res
}

function Get-TelegramAnswer {
    param([string]$PromptText, [int]$Timeout)
    if ($PromptText) {
        Send-TelegramMessage -Text $PromptText | Out-Null
    }
    
    $initJson = & curl.exe -s --max-time 5 "https://api.telegram.org/bot$token/getUpdates?offset=-1"
    $init = $initJson | ConvertFrom-Json
    $lastUpdateId = 0
    if ($init.result -and $init.result.Count -gt 0) {
        $lastUpdateId = $init.result[-1].update_id
    }
    
    $startTime = Get-Date
    Write-Host "Waiting for user response via Telegram (Timeout: $Timeout s)..."
    
    while (((Get-Date) - $startTime).TotalSeconds -lt $Timeout) {
        Start-Sleep -Seconds 3
        $offset = $lastUpdateId + 1
        $resJson = & curl.exe -s --max-time 10 "https://api.telegram.org/bot$token/getUpdates?offset=$offset&timeout=5"
        $res = $resJson | ConvertFrom-Json
        
        if ($res.result -and $res.result.Count -gt 0) {
            foreach ($u in $res.result) {
                if ($u.message -and "$($u.message.chat.id)" -eq "$chatId" -and $u.message.text) {
                    Write-Host "Received: $($u.message.text)"
                    return $u.message.text
                }
            }
        }
    }
    
    Write-Warning "Timed out waiting for Telegram response."
    return $null
}

if ($Action -eq "send") {
    Send-TelegramMessage -Text $Message
} elseif ($Action -eq "ask") {
    Get-TelegramAnswer -PromptText $Message -Timeout $TimeoutSeconds
}
