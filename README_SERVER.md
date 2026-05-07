# Svencycles ERP — Test-Server

## Quick-Start

1. Doppelklick auf **`start_server.bat`**
2. Browser öffnen: **http://localhost:8080/index.html**
3. Login: `sven` / `1234`

## Vom Handy testen (Sven-Workflow)

Server zeigt beim Start die WLAN-IP an, z.B. `192.168.1.42`.
Auf dem Handy im **gleichen WLAN** öffnen:

```
http://192.168.1.42:8080/mobil.html
```

## ⚠️ WICHTIG: Kamera/Mikrofon = HTTPS nötig

Für **QR-Scanner** und **Sprache-zu-Text** auf dem Handy braucht Chrome HTTPS.
Über `http://` funktioniert nur localhost — vom Handy geht es **nicht ohne Zusatz-Setup**.

### Lösung 1: Chrome am Handy mit Localhost (USB)
- Handy per USB an PC, USB-Debugging aktivieren
- Chrome Desktop → `chrome://inspect` → Port-Forwarding `8080 → localhost:8080`
- Auf Handy `http://localhost:8080/mobil.html` öffnen
- Camera/Mic funktionieren

### Lösung 2: HTTPS mit mkcert (empfohlen für echten Test)
```powershell
# Einmalig installieren:
winget install FiloSottile.mkcert
mkcert -install
cd "G:\Meine Ablage\Svencycles_ERP_System_v1"
mkcert localhost 192.168.1.42 ::1 127.0.0.1   # IP anpassen!

# Server mit HTTPS:
python -m http.server 8443 --bind 0.0.0.0
# → braucht Zusatz-Wrapper (siehe https_server.py unten)
```

### Lösung 3: Cloudflare Tunnel (öffentlicher HTTPS-Link, gratis)
```powershell
winget install Cloudflare.cloudflared
cloudflared tunnel --url http://localhost:8080
# → erzeugt URL wie https://random-name.trycloudflare.com
```
**Achtung:** öffentlich erreichbar — nur für Tests, nicht für echte Daten!

## Datenspeicher

Alle Daten landen im **Browser localStorage** (nicht im Ordner).
Backup über das ERP-Modul "Import/Export → Komplett-Backup JSON".

## Architektur

| Datei | Zweck |
|---|---|
| `index.html` | Voll-ERP für PC (Disponent, Buchhaltung, Chef) |
| `mobil.html` | Mobile-Web-App für Mechaniker (Aufnahme, Pausen, Material) |
| `index_v1_backup.html` | Backup der v1.0 |
| `start_server.bat` | Test-Server starten |

## Demo-Logins (alle Passwort `1234`)

| User | Rolle | Zugriff |
|---|---|---|
| `sven` | Admin | Vollzugriff |
| `lisa` | Chef-Mechanikerin | Werkstatt + Rechnungen |
| `marco` | Mechaniker | Nur Mobile (Aufnahme + Aufträge) |
| `cornel` | Disponent | Disposition + Offerten + Rechnungen |
| `traber` | Buchhaltung | Buchhaltung + Rechnungen + Export |
