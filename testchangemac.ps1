$NewMac = %{ (0..5 | %{"{0:X}{1:X}" -f (Get-Random -Minimum 0 -Maximum 15),(Get-Random -Minimum 0 -Maximum 15)} ) -join "" }

Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\0001" /v "NetworkAddress" /t REG_SZ /d "$NewMac" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\0013" /v "NetworkAddress" /t REG_SZ /d "$NewMac" /f

netsh interface set interface name="Ethernet" admin="disable"
netsh interface set interface name="Ethernet" admin="enable"

netsh interface set interface name="Wi-Fi" admin="disable"
netsh interface set interface name="Wi-Fi" admin="enable"

Exit