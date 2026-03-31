# Asus ROG Zephyrus G16 2023 Trying to Fix Sleep

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

