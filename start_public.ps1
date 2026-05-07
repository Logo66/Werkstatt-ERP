#Requires -Version 5.1
# Svencycles ERP — Public Test-Server via Cloudflare Tunnel
# Startet lokalen Python-Webserver UND Cloudflare Tunnel in einem Schritt.
# Gibt eine oeffentliche https://xxx.trycloudflare.com URL aus.

$ErrorActionPreference = 'Stop'
$here = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $here

# Pfade
$cloudflared = Get-ChildItem -Path "$env:LOCALAPPDATA\Microsoft\WinGet\Packages" -Filter "cloudflared.exe" -Recurse -ErrorAction SilentlyContinue | Select-Object -First 1 -ExpandProperty FullName
if (-not $cloudflared) {
    Write-Host "FEHLER: cloudflared.exe nicht gefunden. Installiere mit: winget install Cloudflare.cloudflared" -ForegroundColor Red
    Read-Host "Enter zum Beenden"; exit 1
}

$python = Get-Command python -ErrorAction SilentlyContinue
if (-not $python) { $python = Get-Command py -ErrorAction SilentlyContinue }
if (-not $python) {
    Write-Host "FEHLER: Python nicht gefunden." -ForegroundColor Red
    Read-Host "Enter zum Beenden"; exit 1
}

Write-Host ""
Write-Host "================================================" -ForegroundColor Yellow
Write-Host "  SVENCYCLES ERP - Public Test-Server" -ForegroundColor Yellow
Write-Host "================================================" -ForegroundColor Yellow
Write-Host ""
Write-Host "Schritt 1/2: Lokaler Webserver auf Port 8080..." -ForegroundColor Cyan

# Python Server im Hintergrund starten
$pyJob = Start-Job -ScriptBlock {
    param($p, $dir)
    Set-Location $dir
    & $p -m http.server 8080
} -ArgumentList $python.Source, $here

Start-Sleep -Seconds 2

# Pruefen ob Server laeuft
try {
    $null = Invoke-WebRequest -Uri "http://localhost:8080/index.html" -UseBasicParsing -TimeoutSec 5
    Write-Host "  OK - Server laeuft auf http://localhost:8080" -ForegroundColor Green
} catch {
    Write-Host "  FEHLER - Server gestartet nicht: $_" -ForegroundColor Red
    Stop-Job $pyJob -ErrorAction SilentlyContinue
    Read-Host "Enter zum Beenden"; exit 1
}

Write-Host ""
Write-Host "Schritt 2/2: Cloudflare Tunnel..." -ForegroundColor Cyan
Write-Host "  Gleich erscheint deine oeffentliche URL." -ForegroundColor Gray
Write-Host "  Diese URL bekommt Cornel/Sven zum Testen." -ForegroundColor Gray
Write-Host ""
Write-Host "  WICHTIG:" -ForegroundColor Yellow
Write-Host "  - URL ist temporaer (neu bei jedem Neustart)" -ForegroundColor Yellow
Write-Host "  - Funktioniert nur solange dieser PC laeuft + Script offen ist" -ForegroundColor Yellow
Write-Host "  - HTTPS aktiv = Kamera/Mikro funktionieren auf Handy" -ForegroundColor Yellow
Write-Host ""
Write-Host "  Stoppen: Strg+C" -ForegroundColor Yellow
Write-Host "================================================" -ForegroundColor Yellow
Write-Host ""

# Tunnel starten und Output anzeigen
try {
    & $cloudflared tunnel --url http://localhost:8080
} finally {
    Write-Host ""
    Write-Host "Tunnel beendet. Stoppe lokalen Server..." -ForegroundColor Yellow
    Stop-Job $pyJob -ErrorAction SilentlyContinue
    Remove-Job $pyJob -ErrorAction SilentlyContinue
}
