# 🎧 Samsung Chromebook 4 Audio Fix (Ubuntu 24.04 Kernel + Auto Script)

This project provides a complete fix for restoring **full audio functionality (including microphone)** on the **Samsung Chromebook 4** running Debian-based Linux distributions. It includes a custom script to install the required kernel and apply audio configuration fixes.

---

## ✅ What This Fix Covers

- ✔️ Internal speakers  
- ✔️ Headphones (3.5mm jack)  
- ✔️ Internal microphone (DMIC)  
- ✔️ PulseAudio or PipeWire compatibility  
- ✔️ Kernel installation from `.deb` files  

---

## 💡 The Problem

By default, the Samsung Chromebook 4 uses an Intel **SST audio chipset** and **digital microphone (DMIC)** that are **not properly supported in older kernels** or missing key firmware and configuration files.

Symptoms include:

- 🔇 No sound output  
- ❌ Microphone not detected  
- 🎧 No input/output devices listed in sound settings  

---

## 🛠️ The Fix (Ubuntu 24.04 Kernel + Script)

This repo includes a script (`fix-audio.sh`) that:

1. Installs required audio packages and firmware  
2. Installs a new Linux kernel from `.deb` files  
3. Enables DSP driver support  
4. Restarts and un-mutes audio services  
5. Prompts for reboot  

---

## 🚀 How to Use the Fix Script

### 1. 📦 Clone the Repository

```bash
git clone https://github.com/yourusername/samsung-chromebook4-audio-fix.git
cd samsung-chromebook4-audio-fix
2. 📁 Add Your Kernel .deb Files
Place your .deb kernel files (from Ubuntu 24.04 or newer) inside the kernel/ folder.

Example:kernel/
├── linux-headers-6.8.0-xx-generic_*.deb
├── linux-image-6.8.0-xx-generic_*.deb
3. 🏃 Run the Script
Make the script executable:

bash
Copy
Edit
chmod +x fix-audio.sh
Then run it with sudo:

bash
Copy
Edit
sudo ./fix-audio.sh
📜 What the Script Does
bash
Copy
Edit
#!/bin/bash

# ✅ Main Steps
- Verifies root access
- Installs packages: alsa-utils, pulseaudio, firmware-sof-signed, etc.
- Installs Ubuntu 24.04+ kernel from local `.deb` files
- Applies DSP fix: snd-intel-dspcfg dsp_driver=1
- Restarts audio services (PulseAudio and ALSA)
- Unmutes all common output channels
At the end, you’ll see:

css
Copy
Edit
✅ Audio fix complete and custom kernel installed.
🔁 Please reboot your system to apply all changes.
🔊 After Reboot – Test Your Mic & Speakers
✔️ GUI Method:
bash
Copy
Edit
sudo apt install pavucontrol
pavucontrol
Go to Input Devices

Unmute your mic

Tap and watch the meter

✔️ Terminal Method:
bash
Copy
Edit
arecord -f cd test.wav
# Speak for a few seconds
aplay test.wav
🧪 Sample Detection Output
arecord -l
yaml
Copy
Edit
card 0: sofglkda7219max
  device 1: Headset
  device 99: DMIC (internal microphone)
pactl list sources short
markdown
Copy
Edit
alsa_input.pci-0000_00_0e.0-platform-glk_da7219_def.HiFi__Mic__source
alsa_input.pci-0000_00_0e.0-platform-glk_da7219_def.HiFi__Headset__source
🧠 Troubleshooting
Problem	Solution
❌ Mic not working	Try dsp_driver=3 instead of dsp_driver=1
🔇 Still no sound	Ensure kernel .deb files were installed correctly
🧊 PipeWire shows no input	Restart WirePlumber: systemctl --user restart wireplumber
🎙️ No mic signal in apps	Use pavucontrol to set the correct default input
🎛️ No devices at all	Check alsa-base.conf, `dmesg

📁 Repo Structure
bash
Copy
Edit
samsung-chromebook4-audio-fix/
├── fix-audio.sh               # Main fix script
└── kernel/                    # Place your kernel .deb files here
🙋‍♂️ Author
Chima Chidiebere-Sunday (@apex064)
🔧 Linux Hacker & Full Stack Developer
💻 github.com/apex064

