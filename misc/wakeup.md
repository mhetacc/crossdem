# Asus ROG Zephyrus G16 2023 Trying to Fix Sleep
Laptop wakes up every ~15 minutes.

```bash
Apr 01 03:01:56 fedora bluetoothd[967]: Controller resume with wake event 0x0
Apr 01 03:01:57 fedora NetworkManager[1360]: <info>  [1775005317.0010] manager: sleep: wake requested (sleeping: yes  enabled: yes)
Apr 01 03:40:46 fedora bluetoothd[967]: Controller resume with wake event 0x0
Apr 01 03:40:47 fedora NetworkManager[1360]: <info>  [1775007647.0116] manager: sleep: wake requested (sleeping: yes  enabled: yes)
Apr 01 04:20:15 fedora bluetoothd[967]: Controller resume with wake event 0x0
Apr 01 04:20:16 fedora NetworkManager[1360]: <info>  [1775010016.0016] manager: sleep: wake requested (sleeping: yes  enabled: yes)
Apr 01 04:59:43 fedora bluetoothd[967]: Controller resume with wake event 0x0
Apr 01 04:59:43 fedora NetworkManager[1360]: <info>  [1775012383.8979] manager: sleep: wake requested (sleeping: yes  enabled: yes)
Apr 01 05:38:56 fedora bluetoothd[967]: Controller resume with wake event 0x0
Apr 01 05:38:57 fedora NetworkManager[1360]: <info>  [1775014737.0283] manager: sleep: wake requested (sleeping: yes  enabled: yes)
Apr 01 06:18:12 fedora bluetoothd[967]: Controller resume with wake event 0x0
Apr 01 06:18:13 fedora NetworkManager[1360]: <info>  [1775017093.0190] manager: sleep: wake requested (sleeping: yes  enabled: yes)
Apr 01 06:58:08 fedora bluetoothd[967]: Controller resume with wake event 0x0
Apr 01 06:58:08 fedora NetworkManager[1360]: <info>  [1775019488.8950] manager: sleep: wake requested (sleeping: yes  enabled: yes)
Apr 01 07:36:04 fedora bluetoothd[967]: Controller resume with wake event 0x0
Apr 01 07:36:04 fedora NetworkManager[1360]: <info>  [1775021764.8510] manager: sleep: wake requested (sleeping: yes  enabled: yes)
Apr 01 08:15:43 fedora bluetoothd[967]: Controller resume with wake event 0x0
Apr 01 08:15:43 fedora NetworkManager[1360]: <info>  [1775024143.9964] manager: sleep: wake requested (sleeping: yes  enabled: yes)
Apr 01 08:53:59 fedora bluetoothd[967]: Controller resume with wake event 0x0
Apr 01 08:54:00 fedora NetworkManager[1360]: <info>  [1775026440.0451] manager: sleep: wake requested (sleeping: yes  enabled: yes)
Apr 01 09:32:32 fedora bluetoothd[967]: Controller resume with wake event 0x0
Apr 01 09:32:33 fedora NetworkManager[1360]: <info>  [1775028753.0149] manager: sleep: wake requested (sleeping: yes  enabled: yes)
Apr 01 10:11:21 fedora bluetoothd[967]: Controller resume with wake event 0x0
Apr 01 10:11:21 fedora NetworkManager[1360]: <info>  [1775031081.8998] manager: sleep: wake requested (sleeping: yes  enabled: yes)
Apr 01 10:51:15 fedora bluetoothd[967]: Controller resume with wake event 0x0
Apr 01 10:51:16 fedora NetworkManager[1360]: <info>  [1775033476.0537] manager: sleep: wake requested (sleeping: yes  enabled: yes)
Apr 01 11:22:34 fedora bluetoothd[967]: Controller resume with wake event 0x0
Apr 01 11:22:34 fedora NetworkManager[1360]: <info>  [1775035354.7828] manager: sleep: wake requested (sleeping: yes  enabled: yes)
```

Deep sleep not available, ASUS removed S3 wake up from firmware.
In the BIOS there is not option to shut-off wake-up network or bluetooth. 


Steps taken:

I activated in the bios ErP.

>$ cat /proc/acpi/wakeup

```
Device	S-state	  Status   Sysfs node
PEG1	  S4	*disabled  pci:0000:00:01.0
PEGP	  S4	*disabled  pci:0000:01:00.0
PEG2	  S4	*disabled
PEGP	  S4	*disabled
PEG0	  S4	*disabled  pci:0000:00:06.0
PEGP	  S4	*disabled
RP09	  S4	*disabled
PXSX	  S4	*disabled
RP10	  S4	*disabled
PXSX	  S4	*disabled
RP11	  S4	*disabled
PXSX	  S4	*disabled
RP12	  S4	*disabled
PXSX	  S4	*disabled
RP13	  S4	*disabled
PXSX	  S4	*disabled
RP14	  S4	*disabled
PXSX	  S4	*disabled
RP15	  S4	*disabled
PXSX	  S4	*disabled
RP16	  S4	*disabled
PXSX	  S4	*disabled
RP01	  S4	*disabled
PXSX	  S4	*disabled
RP02	  S4	*disabled
PXSX	  S4	*disabled
RP03	  S4	*disabled
PXSX	  S4	*disabled
RP04	  S4	*disabled
PXSX	  S4	*disabled
RP05	  S4	*disabled
PXSX	  S4	*disabled
RP06	  S4	*disabled  pci:0000:00:1c.0
PXSX	  S4	*disabled  pci:0000:37:00.0
		*disabled  platform:rtsx_pci_sdmmc.0
RP07	  S4	*disabled  pci:0000:00:1c.6
PXSX	  S4	*disabled  pci:0000:38:00.0
RP08	  S4	*disabled
PXSX	  S4	*disabled
RP17	  S4	*disabled
PXSX	  S4	*disabled
RP18	  S4	*disabled
PXSX	  S4	*disabled
RP19	  S4	*disabled
PXSX	  S4	*disabled
RP20	  S4	*disabled
PXSX	  S4	*disabled
RP21	  S4	*disabled
PXSX	  S4	*disabled
RP22	  S4	*disabled
PXSX	  S4	*disabled
RP23	  S4	*disabled
PXSX	  S4	*disabled
RP24	  S4	*disabled
PXSX	  S4	*disabled
XHCI	  S3	*disabled  pci:0000:00:14.0
XDCI	  S4	*disabled
HDAS	  S4	*disabled  pci:0000:00:1f.3
CNVW	  S4	*disabled  pci:0000:00:14.3
TXHC	  S3	*disabled  pci:0000:00:0d.0
TDM0	  S4	*disabled  pci:0000:00:0d.2
TDM1	  S4	*disabled
TRP0	  S4	*disabled  pci:0000:00:07.0
PXSX	  S4	*disabled
TRP1	  S4	*disabled
PXSX	  S4	*disabled
TRP2	  S4	*disabled
PXSX	  S4	*disabled
TRP3	  S4	*disabled
PXSX	  S4	*disabled
AWAC	  S4	*disabled  platform:ACPI000E:00
```

>$ cat /etc/NetworkManager/conf.d/disable-wake-on-wlan.conf
```
[connection]
wifi.powersave = 2
```

>$ cat  /etc/udev/rules.d/91-disable-bluetooth-wake.rules
```
ACTION=="add", SUBSYSTEM=="usb", ATTRS{idVendor}=="8087", ATTRS{idProduct}=="0033", ATTR{power/wakeup}="disabled"
```

>$ cat /etc/udev/rules.d/90-disable-bt-wake.rules
```
ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="8087", ATTR{idProduct}=="0033", ATTR{power/wakeup}="disabled"
```

>$  sudo udevadm control --reload-rules && sudo udevadm trigger

>$ cat /etc/systemd/system/disable-peg1-wake.service
```
[Unit]
Description=Disable PEG1 ACPI wake trigger
After=multi-user.target

[Service]
Type=oneshot
ExecStart=/bin/sh -c "grep -q 'PEG1.*enabled' /proc/acpi/wakeup && echo PEG1 > /proc/acpi/wakeup || true"
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
```
>$ sudo systemctl enable --now disable-peg1-wake.service

>$ iw dev wlo1 get power_save
```
Power save: on
```

> iw phy phy0 wowlan show
```
WoWLAN is disabled
```

## Unloading kernel modules

### Bluetooth
All files in `usr/lib/systemd/system-sleep/` get called by the system before (for `pre`) and after (for `post`) sleep.

```bash
mhetac@fedora:~$ sudo tee /usr/lib/systemd/system-sleep/bt-unload.sh << 'EOF'
#!/bin/bash
case "$1" in
  pre)  modprobe -r btusb ;;
  post) modprobe btusb ;;
esac
EOF
sudo chmod +x /usr/lib/systemd/system-sleep/bt-unload.sh
#!/bin/bash
case "$1" in
  pre)  modprobe -r btusb ;;
  post) modprobe btusb ;;
esac
```

```bash
mhetac@fedora:~$ cat /usr/lib/systemd/system-sleep/bt-unload.sh
#!/bin/bash
case "$1" in
  pre)  modprobe -r btusb ;;
  post) modprobe btusb ;;
esac
```

### Network

If 
```
Apr 01 14:14:04 fedora NetworkManager[1360]: <info>  [1775045644.8766] manager: sleep: wake requested (sleeping: yes  enabled: yes)
```

Then add

```bash
#!/bin/bash
case "$1" in
  pre)
    modprobe -r btusb
    iw dev wlo1 set power_save off
    iw phy phy0 wowlan disable 2>/dev/null || true
    ;;
  post)
    modprobe btusb
    ;;
esac
```

Now: 

```bash
Apr 01 17:43:07 fedora kernel: rtc_cmos rtc_cmos: RTC can wake from S4
Apr 01 15:43:12 fedora (udev-worker)[643]: 3-10:1.0: /etc/udev/rules.d/91-disable-bluetooth-wake.rules:1 ATTR{power/wakeup}="disabled": Could not chase sysfs attribute "/sys/devices/pci0000:00/0000:00:14.0/usb3/3-10/3-10:1.0/power/wakeup", ignoring: No such file or directory
Apr 01 15:43:12 fedora (udev-worker)[629]: 3-10:1.1: /etc/udev/rules.d/91-disable-bluetooth-wake.rules:1 ATTR{power/wakeup}="disabled": Could not chase sysfs attribute "/sys/devices/pci0000:00/0000:00:14.0/usb3/3-10/3-10:1.1/power/wakeup", ignoring: No such file or directory
Apr 01 15:43:13 fedora NetworkManager[1147]: <info>  [1775050993.6378] Read config: /etc/NetworkManager/NetworkManager.conf, /usr/lib/NetworkManager/conf.d/{20-connectivity-fedora.conf,22-wifi-mac-addr.conf,99-nvme-nbft-no-ignore-carrier.conf}, /etc/NetworkManager/conf.d/{disable-wake-on-wlan.conf,wgpia.conf,wifi-powersave.conf}
Apr 01 15:43:13 fedora NetworkManager[1147]: <warn>  [1775050993.6378] config: unknown key 'wifi.wake-on-wlan' in section [device] of file '/etc/NetworkManager/conf.d/wifi-powersave.conf'
Apr 01 15:43:24 fedora systemd[1]: Starting disable-peg1-wake.service - Disable PEG1 ACPI wake trigger...
Apr 01 15:43:24 fedora systemd[1]: Finished disable-peg1-wake.service - Disable PEG1 ACPI wake trigger.
Apr 01 15:43:24 fedora audit[1]: SERVICE_START pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=disable-peg1-wake comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Apr 01 18:51:34 fedora NetworkManager[1147]: <info>  [1775062294.8003] manager: sleep: wake requested (sleeping: yes  enabled: yes)
Apr 01 19:30:56 fedora NetworkManager[1147]: <info>  [1775064656.7847] manager: sleep: wake requested (sleeping: yes  enabled: yes)
Apr 01 20:04:30 fedora NetworkManager[1147]: <info>  [1775066670.7862] manager: sleep: wake requested (sleeping: yes  enabled: yes)
Apr 01 20:37:18 fedora NetworkManager[1147]: <info>  [1775068638.7867] manager: sleep: wake requested (sleeping: yes  enabled: yes)
Apr 01 21:11:05 fedora NetworkManager[1147]: <info>  [1775070665.7576] manager: sleep: wake requested (sleeping: yes  enabled: yes)
Apr 01 21:43:32 fedora NetworkManager[1147]: <info>  [1775072612.2008] manager: sleep: wake requested (sleeping: yes  enabled: yes)
```

**Claude:** "The culprit is IRQ 9 = ACPI. This means the wakeup is coming from the ACPI subsystem itself — specifically the ASUS Embedded Controller firing an ACPI event on a timer. This is a known ASUS ROG hardware quirk and ec_no_wakeup=1 didn't fully stop it."

```bash
sudo grubby --update-kernel=ALL --args="acpi.ec_no_wakeup=1 ec_sys.write_support=1"
sudo reboot
```

## Finding the Culprit

```bash
mhetac@192:~$ sudo acpi_listen
button/lid LID close
ac_adapter ACPI0003:00 00000000 00000000
battery PNP0C0A:03 00000080 00000001
battery PNP0C0A:03 00000081 00000001
battery PNP0C0A:03 00000080 00000001
ac_adapter ACPI0003:00 00000000 00000000
battery PNP0C0A:03 00000080 00000001
battery PNP0C0A:03 00000081 00000001
battery PNP0C0A:03 00000080 00000001
ac_adapter ACPI0003:00 00000000 00000000
battery PNP0C0A:03 00000080 00000001
battery PNP0C0A:03 00000081 00000001
battery PNP0C0A:03 00000080 00000001
ac_adapter ACPI0003:00 00000000 00000000
battery PNP0C0A:03 00000080 00000001
battery PNP0C0A:03 00000081 00000001
battery PNP0C0A:03 00000080 00000001
ac_adapter ACPI0003:00 00000000 00000000
battery PNP0C0A:03 00000080 00000001
battery PNP0C0A:03 00000081 00000001
battery PNP0C0A:03 00000080 00000001
ac_adapter ACPI0003:00 00000000 00000000
battery PNP0C0A:03 00000080 00000001
battery PNP0C0A:03 00000081 00000001
battery PNP0C0A:03 00000080 00000001
button/lid LID open
```
### Trying to Fix the Culprit

```bash
mhetac@192:~$ sudo sh -c 'echo disabled > /sys/devices/pci0000:00/0000:00:1f.0/ACPI0003:00/power_supply/ADP0/power/wakeup'
sudo sh -c 'echo disabled > /sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:0a/PNP0C0A:03/power/wakeup'
sudo sh -c 'echo disabled > /sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:0a/PNP0C0D:01/power/wakeup'
[sudo] password for mhetac: 
mhetac@192:~$ cat /sys/devices/pci0000:00/0000:00:1f.0/ACPI0003:00/power_supply/ADP0/power/wakeup
cat /sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:0a/PNP0C0A:03/power/wakeup
cat /sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:0a/PNP0C0D:01/power/wakeup
disabled
disabled
disabled
```

## Updated BIOS

### 1. All "enabled"
