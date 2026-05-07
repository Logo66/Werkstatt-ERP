#Requires -Version 5.1
# Svencycles ERP — lokaler Test-Server
# Doppelklick auf start_server.bat (im selben Ordner) startet diesen Server

$ErrorActionPreference = 'Stop'
$here = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $here

# IP herausfinden für Handy-Zugriff im WLAN
$ips = (Get-NetIPAddress -AddressFamily IPv4 -PrefixOrigin Dhcp,Manual -ErrorAction SilentlyContinue |
        Where-Object { $_.IPAddress -notlike '169.*' -and $_.IPAddress -notlike '127.*' }).IPAddress

Write-Host ""
Write-Host "================================================" -ForegroundColor Yellow
Write-Host "  SVENCYCLES ERP v2 - Test-Server" -ForegroundColor Yellow
Write-Host "================================================" -ForegroundColor Yellow
Write-Host ""
Write-Host "Ordner: $here" -ForegroundColor Gray
Write-Host ""
Write-Host "Aufrufen am PC:" -ForegroundColor Cyan
Write-Host "   http://localhost:8080/index.html  (Desktop)" -ForegroundColor White
Write-Host "   http://localhost:8080/mobil.html  (Mobile-Test)" -ForegroundColor White
Write-Host ""
if ($ips) {
    Write-Host "Aufrufen vom Handy im WLAN:" -ForegroundColor Cyan
    foreach ($ip in $ips) {
        Write-Host "   http://${ip}:8080/mobil.html" -ForegroundColor White
    }
    Write-Host ""
    Write-Host "WICHTIG: Kamera/Mikrofon (QR-Scanner, Sprache-zu-Text)" -ForegroundColor Red
    Write-Host "funktionieren in Chrome nur auf localhost ODER ueber HTTPS." -ForegroundColor Red
    Write-Host "Fuer Handy-Test mit Kamera siehe README_SERVER.md" -ForegroundColor Red
    Write-Host ""
}
Write-Host "Server stoppen: Strg+C" -ForegroundColor Yellow
Write-Host ""

# Python http.server starten
$py = Get-Command python -ErrorAction SilentlyContinue
if (-not $py) { $py = Get-Command py -ErrorAction SilentlyContinue }
if (-not $py) {
    Write-Host "FEHLER: Python nicht gefunden. Bitte python.exe im PATH haben." -ForegroundColor Red
    Read-Host "Enter zum Beenden"
    exit 1
}

& $py.Source -m http.server 8080
