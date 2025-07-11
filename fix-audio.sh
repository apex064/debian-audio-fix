#!/bin/bash

set -e

echo "🔧 Fixing Linux Audio Issues (with Custom Kernel Installer)"

# 1. Check for root
if [[ $EUID -ne 0 ]]; then
  echo "❌ This script must be run as root. Use: sudo $0"
  exit 1
fi

# 2. Install required audio packages
echo "📦 Installing necessary audio packages..."
apt update
apt install -y alsa-utils pulseaudio firmware-sof-signed alsa-ucm-conf

# 3. Prepare to install custom kernel
KERNEL_DIR="./kernel"

echo "📁 Checking for custom kernel in $KERNEL_DIR..."

if [ ! -d "$KERNEL_DIR" ]; then
  echo "❌ No 'kernel' directory found. Please create it and add your .deb files."
  exit 1
fi

cd "$KERNEL_DIR"
KERNEL_FILES=$(ls *.deb 2>/dev/null || true)

if [ -z "$KERNEL_FILES" ]; then
  echo "⚠️ No .deb files found in the 'kernel' folder."
  echo "➡️ Please place your custom kernel .deb files there and re-run the script."
  exit 1
fi

# 4. Install the kernel .deb files
echo "📦 Installing kernel packages..."
dpkg -i *.deb || apt -f install -y
cd ..

# 5. Check for Intel audio (Baytrail/Geminilake fix)
if lspci | grep -i audio | grep -qi "Intel"; then
  echo "🛠️ Detected Intel audio chipset. Applying DSP fix..."
  echo "options snd-intel-dspcfg dsp_driver=1" > /etc/modprobe.d/alsa-base.conf
fi

# 6. Restart audio services
echo "🔄 Restarting audio services..."
pulseaudio -k || true
alsa force-reload || true

# 7. Unmute outputs
echo "🔊 Unmuting audio outputs..."
amixer -c 0 set Master unmute || true
amixer -c 0 set Speaker unmute || true
amixer -c 0 set Headphone unmute || true

# 8. Done
echo -e "\n✅ Audio fix complete and custom kernel installed."
echo "🔁 Please reboot your system to apply all changes."

