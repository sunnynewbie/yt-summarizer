$ErrorActionPreference = 'Stop'

$projectRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$apiScript = "Set-Location '$projectRoot'; npm run dev"
$frontendScript = "Set-Location '$projectRoot'; npm run dev:fe"
$workerScript = "Set-Location '$projectRoot'; npm run dev:worker"

Write-Host "Starting frontend, API, and mock worker from $projectRoot"
Write-Host "Prerequisites:"
Write-Host "  1. PostgreSQL is running"
Write-Host "  2. .env is configured"
Write-Host "  3. SQL migrations are applied"

Start-Process powershell -ArgumentList @(
    '-NoExit',
    '-Command',
    $frontendScript
)

Start-Process powershell -ArgumentList @(
    '-NoExit',
    '-Command',
    $apiScript
)

Start-Sleep -Seconds 2

Start-Process powershell -ArgumentList @(
    '-NoExit',
    '-Command',
    $workerScript
)

Write-Host "Frontend started in a new PowerShell window."
Write-Host "API started in a new PowerShell window."
Write-Host "Mock worker started in a new PowerShell window."
Write-Host "Frontend: http://localhost:3000"
Write-Host "API health: http://localhost:5000/health"
Write-Host "Worker health: http://localhost:8000/health"
