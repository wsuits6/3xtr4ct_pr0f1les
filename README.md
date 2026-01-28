# ProfilesBackup

██╗    ██╗███████╗██╗   ██╗██╗████████╗███████╗ ██████╗ 
██║    ██║██╔════╝██║   ██║██║╚══██╔══╝██╔════╝██╔════╝ 
██║ █╗ ██║███████╗██║   ██║██║   ██║   ███████╗███████╗ 
██║███╗██║╚════██║██║   ██║██║   ██║   ╚════██║██╔═══██╗
╚███╔███╔╝███████║╚██████╔╝██║   ██║   ███████║╚██████╔╝
 ╚══╝╚══╝ ╚══════╝ ╚═════╝ ╚═╝   ╚═╝   ╚══════╝ ╚═════╝ 
                                                        

yaml
Copy code

## Overview
ProfilesBackup is a Windows batch tool that safely copies **important Firefox and Chrome profile data** to a USB drive for backup, analysis, or offline processing.

It is designed to produce clean, structured artifacts that can later be ingested by a Python application or database.

---

## What It Collects

### Firefox
- `places.sqlite` (history & bookmarks)
- `logins.json`
- `key4.db`
- `prefs.js`

### Chrome
- `Bookmarks`
- `Login Data`
- `Preferences`
- `History`

---

## Requirements
- Windows system
- USB drive labeled **Hsociety**
- Firefox and/or Chrome installed
- Administrator privileges recommended (not always required)

---

## Usage

1. Insert the USB drive labeled `Hsociety`
2. Double-click `ProfilesBackup.bat`
3. Wait for completion

Backup results will be saved to:
Hsociety:\ProfilesBackup\Backup_<timestamp>\

yaml
Copy code

A log file is generated for each run.

---

## Output Structure
ProfilesBackup/
└── Backup_YYYY-MM-DD_HH-MM-SS/
├── Firefox/
│ └── <profile_name>/
├── Chrome/
└── backup.log

yaml
Copy code

---

## Notes
- This tool **does not transmit data**.
- It only copies specific files, not entire browser profiles.
- Designed for controlled, authorized use.

---

## Disclaimer
Use this tool **only on systems you own or have explicit permission to analyze**.  
The author assumes no responsibility for misuse.

---

## Author
**Wsuits6**  
Internal tooling for controlled data extraction and analysis.