# Svencycles Werkstatt-ERP — v2.0

**Web-basiertes Werkstatt-Management für Svencycles GmbH (Waltalingen)**

Pure HTML/CSS/JS, kein Backend. Daten im Browser-localStorage.

## 🚀 Online-Version (GitHub Pages)

- **PC / Disponent / Buchhaltung:** [`index.html`](https://logo66.github.io/Werkstatt-ERP/index.html)
- **Handy / Mechaniker:** [`mobil.html`](https://logo66.github.io/Werkstatt-ERP/mobil.html)

## Demo-Logins (alle Passwort `1234`)

| Benutzer | Rolle | Zugriff |
|---|---|---|
| `sven` | Admin | Vollzugriff |
| `lisa` | Chef-Mechanikerin | Werkstatt + Rechnungen |
| `marco` | Mechaniker | Nur Mobile (Aufnahme + Aufträge) |
| `cornel` | Disponent | Disposition + Offerten + Rechnungen |
| `traber` | Buchhaltung | Buchhaltung + Rechnungen + Export |

## Module

### Desktop (`index.html`)
- 📊 Dashboard (KPIs, Termine heute, wartende Aufnahmen)
- 📅 Disposition (Wochenkalender mit Drag & Drop, ICS-Export für Outlook)
- 📷 Aufnahmen-Übersicht (Sven's Rapports am PC sehen)
- 🔧 Aufträge mit Material + Zeiterfassung + Übergabe-Checkliste
- 📋 Offerten (aus Aufnahme erstellen, PDF, → Auftrag)
- 👥 Kunden mit Bike-Historie
- 📦 Lager mit **QR-Etiketten-Generator** + **Wareneingang-Scanner** (Webcam)
- 📄 Rechnungen mit Swiss QR-Bill PDF
- 💰 Buchhaltung mit MWST-Export
- 👷 Personal mit granularer Rechte-Verwaltung + Passwort-Hash

### Mobile (`mobil.html`) — Sven-Workflow
- 📷 Bike-Aufnahme: Kontrollschild → Foto → Schaden-Checkliste → 🎙️ Sprache-zu-Text
- 🔧 Aufträge mit Pause-Timer (6 Gründe: Kunde, Telefon, Teile, WC, Mittag, Anderes)
- 📦 Material verbauen: manuell oder **QR-Scan mit Handy-Kamera**
- ✓ Übergabe-Checkliste

## Features

- **Login mit SHA-256 Passwort-Hash**
- **18 granulare Berechtigungen** pro Mitarbeiter
- **Swiss QR-Rechnung** PDF (SPS-Standard)
- **html5-qrcode** für Scan, **qrcodejs** für Generation
- **Web Speech API** für Sprache-zu-Text (de-CH)

## ⚠️ Wichtig

- Daten liegen im **Browser-localStorage** — pro Gerät separat
- **Kein Multi-User-Sync** — für echte Werkstatt-Nutzung kommt Phase v3.0 mit Backend
- Kamera/Mikrofon brauchen **HTTPS** — GitHub Pages liefert das automatisch ✓
- Backup täglich machen: Import/Export → Komplett-Backup JSON

## Stack

- **CDN:** jsPDF 2.5.1, qrcodejs 1.0.0, html5-qrcode 2.3.8
- **Fonts:** Barlow Condensed + Space Mono
- **MWST:** 8.1% (Schweiz), Stundensatz CHF 125

## Lokal ausführen

```powershell
# Doppelklick auf:
start_server.bat
# → http://localhost:8080/index.html
```

## Geplant für v2.1+
- 🏠 Einlagerung / Reifenhotel
- 📅 MFK-Erinnerung
- 📧 Kunden-Mail "Bike fertig"
- 📱 WhatsApp-Integration
- ☁️ Cloud-Sync mit Backend (Multi-User Live)

---

**Svencycles GmbH** · Neunfornerstrasse 2 · 8468 Waltalingen
Tel 052 746 10 60 · info@svencycles.ch
