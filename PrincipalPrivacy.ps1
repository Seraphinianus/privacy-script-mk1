# Programul trebuie inchis din taskbar tray cu X

Start-Transcript -Append C:\Users\Person\Desktop\Logs\LastLog.txt

# Modificatorul de acces pentru rularea inerenta
Set-ExecutionPolicy Unrestricted

Write-Output "Se sterge istoricul..."
ipconfig /flushdns

Write-Output "Se porneste Chrome"
start chrome google.com

# Functia pentru nume random de desktop
Function New-RandomComputerName
{
    [CmdletBinding(SupportsShouldProcess=$True)]

    Param(
        [int]$NameLength
    )

    # Caractere pentru nume

    $CharSimple = "A","B","C","D","E","F","G","H","J","K","L","M","N","P","Q","R","S","T","U","V","W","X","Y","Z","1","2","3","4","5","6","7","8","9","0"
    $CharNumbers = "1","2","3","4","5","6","7","8","9","0"
     
    # Se verifica sa aiba macar o cifra

    $ContainsNumber = $False
    $Name = $Null
     
    # Seteaza caracterele pentru a le folosi in $Complex

    # Loop pentru generarea numelui

    for ($i=0;$i -lt $NameLength; $i++)
        {$c = Get-Random -InputObject $CharSimple
            if ([char]::IsDigit($c))
        {$ContainsNumber = $True}
         $Name += $c}
    
    # Daca nu a vazut nicio cifra, repara

    if ($ContainsNumber)
        {
            Return $Name
        }
        else
        {
            $Position = Get-Random -Maximum $NameLength
            $Number = Get-Random -InputObject $CharNumbers
            $NameArray = $Name.ToCharArray()
            $NameArray[$Position] = $Number
            $Name = ""
            foreach ($s in $NameArray)
            {
                $Name += $s
            }
        Return $Name
       
    }
}

# Functia asta genereaza o adresa MAC unica si functionala
Function New-MacAddress
{
    # Aici poti schimba "A"-ul in ceva ce o sa mearga pentru tipul de adrese MAC acceptate de masinaria ta individuala
    $FirstPart = %{ (0..0 | %{"{0:X}A" -f (Get-Random -Minimum 0 -Maximum 15),(Get-Random -Minimum 0 -Maximum 15)} ) -join "" }
    $NewMac = %{ (1..5 | %{"{0:X}{1:X}" -f (Get-Random -Minimum 0 -Maximum 15),(Get-Random -Minimum 0 -Maximum 15)} ) -join "" }

    $BestMAC = $FirstPart + $NewMac

    Return $BestMAC
}

$Generat = New-RandomComputerName -NameLength 7
$Formatat = "DESKTOP-$Generat"
Write-Output "Denumirea PC-ului schimbata in $Formatat"

$EngineeredMAC = New-MacAddress

# Partea asta modifica valoarea din registru cu privire la adresa MAC 
#
#=============================================================================

Function Changing-Mac
{
    Write-Output "Se schimba adresa MAC..."

    Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\0001" /v "NetworkAddress" /t REG_SZ /d "$EngineeredMAC" /f
    Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\0002" /v "NetworkAddress" /t REG_SZ /d "$EngineeredMAC" /f
    Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\0003" /v "NetworkAddress" /t REG_SZ /d "$EngineeredMAC" /f
    Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\0004" /v "NetworkAddress" /t REG_SZ /d "$EngineeredMAC" /f
    Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\0005" /v "NetworkAddress" /t REG_SZ /d "$EngineeredMAC" /f
    Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\0006" /v "NetworkAddress" /t REG_SZ /d "$EngineeredMAC" /f
    Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\0007" /v "NetworkAddress" /t REG_SZ /d "$EngineeredMAC" /f
    Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\0008" /v "NetworkAddress" /t REG_SZ /d "$EngineeredMAC" /f
    Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\0009" /v "NetworkAddress" /t REG_SZ /d "$EngineeredMAC" /f
    Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\0010" /v "NetworkAddress" /t REG_SZ /d "$EngineeredMAC" /f
    Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\0011" /v "NetworkAddress" /t REG_SZ /d "$EngineeredMAC" /f
    Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\0012" /v "NetworkAddress" /t REG_SZ /d "$EngineeredMAC" /f
    Reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\0013" /v "NetworkAddress" /t REG_SZ /d "$EngineeredMAC" /f

    netsh interface set interface name="Ethernet" admin="disable"
    netsh interface set interface name="Ethernet" admin="enable"

    netsh interface set interface name="Wi-Fi" admin="disable"
    netsh interface set interface name="Wi-Fi" admin="enable"

    Write-Output "Adresa MAC a fost schimbata cu succes in $EngineeredMac"
}
#=============================================================================

# O rulam prima data ca sa fim siguri
Changing-Mac

# Temporizator pentru restart

$delay = 900
$Counter_Form = New-Object System.Windows.Forms.Form
$Counter_Form.Text = "Temporizator"
$Counter_Form.Width = 450
$Counter_Form.Height = 200
$Counter_Label = New-Object System.Windows.Forms.Label
$Counter_Label.AutoSize = $true
$Counter_Label.ForeColor = "Green"
$normalfont = New-Object System.Drawing.Font("Times New Roman",14)
$Counter_Label.Font = $normalfont
$Counter_Label.Left = 20
$Counter_Label.Top = 20
$Counter_Form.Controls.Add($Counter_Label)
while ($delay -ge 0)
{
  $Counter_Form.Show()
  $Counter_Label.Text = "Seconds Remaining: $($delay)"

    if ($delay -lt 5)
    { 
        $Counter_Label.ForeColor = "Red"
        $fontsize = 20-$delay
        $warningfont = New-Object System.Drawing.Font("Times New Roman",$fontsize,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold -bor [System.Drawing.FontStyle]::Underline))
        $Counter_Label.Font = $warningfont
    } 
 start-sleep 1
 $delay -= 1
}

# Curatenie la locul de munca sa nu fie probleme
#
#=====================================================
Reg.exe delete "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\0001" /v "NetworkAddress" /f
Reg.exe delete "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\0002" /v "NetworkAddress" /f
Reg.exe delete "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\0003" /v "NetworkAddress" /f
Reg.exe delete "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\0004" /v "NetworkAddress" /f
Reg.exe delete "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\0005" /v "NetworkAddress" /f
Reg.exe delete "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\0006" /v "NetworkAddress" /f
Reg.exe delete "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\0007" /v "NetworkAddress" /f
Reg.exe delete "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\0008" /v "NetworkAddress" /f
Reg.exe delete "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\0009" /v "NetworkAddress" /f
Reg.exe delete "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\0010" /v "NetworkAddress" /f
Reg.exe delete "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\0011" /v "NetworkAddress" /f
Reg.exe delete "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\0012" /v "NetworkAddress" /f
Reg.exe delete "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Class\{4d36e972-e325-11ce-bfc1-08002be10318}\0013" /v "NetworkAddress" /f
#=====================================================
Write-Output "Fisierele create in Registre s-au sters."

ipconfig /flushdns
Write-Output "Istoric sters acum la sfarsit."

Stop-Transcript

Rename-Computer -NewName $Formatat -Restart