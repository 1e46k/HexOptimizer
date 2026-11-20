<div align="center">

<img src="https://github.com/user-attachments/assets/10e5272a-d109-4b7e-9f56-41ecc5c0ff34" alt="HEX+ Optimizer" width="100%">

# ⬡ HEX+ Optimizer

**A free, open, no-bullshit Windows optimizer for gaming.**

Fuck paid optimizers.

![version](https://img.shields.io/badge/version-1.9-orange)
![platform](https://img.shields.io/badge/Windows-10%20%7C%2011-blue)
![price](https://img.shields.io/badge/price-free-brightgreen)

*made by [@wylziz](https://github.com/1e46k)*

</div>

---

## What is HEX+

HEX+ is a single Windows batch script that applies 25+ real, measured performance and latency tweaks for gaming — then cleans your junk, backs everything up first, and lets you undo it all with one click.

No installer. No telemetry. No paywall. The whole thing is readable source you can inspect before running.

---

## Features

- **One-click Extreme preset** — run it and go, no setup.
- **Detailed dry-run** — see exactly what it will change before anything happens.
- **Full revert** — restores registry, services and boot config from an automatic backup, with a debug log.
- **Versioned backups** — every run saves a timestamped backup; nothing gets overwritten.
- **Restore-point verification** — confirms a System Restore point was actually created.
- **Hardware-aware** — detects Windows 10/11 + build, GPU, VRAM and generation, and whether you're on a laptop (softens thermals-risky tweaks on battery).
- **Junk cleanup** — temp, prefetch, caches, crash dumps, logs, DNS, Recycle Bin.
- **Before/after CPU benchmark** and an end-of-run summary.
- **Built-in branding** — applies the HEX+ wallpaper automatically.

---

## What it tunes

| Area | Tweaks |
|------|--------|
| **CPU** | Priority separation, core parking off, throttle off, aggressive boost, Spectre/Meltdown mitigations off |
| **GPU** | Hardware-Accelerated GPU Scheduling, MSI mode, Resizable BAR, TdrDelay, vendor-specific tuning (NVIDIA/AMD/Intel) |
| **RAM** | Paging executive locked, Superfetch/Prefetch off, memory compression off |
| **Network** | Throttling off, Nagle off, fast retransmit, NIC MSI mode |
| **Input** | 1:1 mouse, max-priority mouse/keyboard threads |
| **Timer / DWM** | Global timer resolution, HPET off, dynamic tick off, low presentation latency |
| **System** | GameDVR off, fullscreen-optimizations off, background telemetry and bloatware removed |

---

## Usage

1. Download `HEX.bat`.
2. Right-click → **Run as administrator** (it self-elevates if you forget).
3. Read the dry-run, confirm, and let it finish.
4. **Restart** when it asks — required for all changes to apply.

> Tip: use option **Preview** / **About** first if you want to see what it does without running anything.

---

## How to undo

HEX+ makes this easy — you have three layers of safety:

1. **Built-in revert** — run HEX+ again and pick **Revert**. It restores the registry, services and boot config from the latest backup and writes a log to your Desktop.
2. **System Restore** — a restore point named *Hex+ Optimizer* is created before any change.
3. **Manual** — registry backups are exported to a dated folder on your Desktop (`hexplus_backup_keys_*`).

**Note:** revert restores settings, but does **not** reinstall apps the script removed (Edge, OneDrive, Store apps). Use System Restore if you need those back.

---

## Requirements

- Windows 10 or Windows 11 (64-bit)
- Administrator rights
- A reboot after running

---

## ⚠️ Important / Disclaimer

- HEX+ makes deep system changes. **Read the source, back up, and test before relying on it.**
- The **Extreme** preset is aggressive by design — it can disable Windows Defender and other protections. Only use it if you understand that.
- Some antivirus engines may flag the script (deep registry edits + an embedded wallpaper decode step). This is a common false positive; the source is fully readable.
- Use at your own risk. The author is not responsible for any damage, data loss or instability.

---

## Changelog

See [Releases](../../releases) for the full version history.

---

<div align="center">

**HEX+ — Clean. Branded. Yours.**

If it helped, drop a ⭐

</div>
