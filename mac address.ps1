$FirstPart = %{ (0..0 | %{"{0:X}A" -f (Get-Random -Minimum 0 -Maximum 15),(Get-Random -Minimum 0 -Maximum 15)} ) -join "" }
$NewMac = %{ (1..5 | %{"{0:X}{1:X}" -f (Get-Random -Minimum 0 -Maximum 15),(Get-Random -Minimum 0 -Maximum 15)} ) -join "" }

$adapter = Get-NetAdapter | Where {$_.Name -Match "Wi-Fi"}
$WifiName = $adapter.InterfaceDescription
$MacAddress = $adapter.MacAddress

$MacAddress

$FirstPart
$NewMac

$EngineeredMAC = $FirstPart + $NewMac

Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\0001" /v "NetworkAddress" /t REG_SZ /d "$EngineeredMAC" /f
Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\0013" /v "NetworkAddress" /t REG_SZ /d "$EngineeredMAC" /f

netsh interface set interface name="Ethernet" admin="disable"
netsh interface set interface name="Ethernet" admin="enable"

netsh interface set interface name="Wi-Fi" admin="disable"
netsh interface set interface name="Wi-Fi" admin="enable"

$EngineeredMAC



# adapter name = "Intel(R) Wi-Fi 6 AX200 160MHz"
# original mac address = "B4-0E-DE-6C-30-EA"

# Set-NetAdapterAdvancedProperty -Name "Intel(R) Wi-Fi 6 AX200 160MHz" -RegistryKeyword "NetworkAddress" -RegistryValue "A2358DA317C0"