# Written bo Owen Siebert
# New-IPv4toBin and Get-Broadcast functions by Filip of ficility.net
function New-IPv4toBin ($ipv4)
{
    $BinNum = $ipv4 -split '\.' | ForEach-Object {[System.Convert]::ToString($_,2).PadLeft(8,'0')}
    return $binNum -join ""
}

function Get-Broadcast ($addressAndCidr)
{
    $addressAndCidr = $addressAndCidr.Split("/")
    $addressInBin = (New-IPv4toBin $addressAndCidr[0]).ToCharArray()
    for($i=0;$i -lt $addressInBin.length;$i++)
    {
        if($i -ge $addressAndCidr[1])
        {
            $addressInBin[$i] = "1"
        } 
    }
    [string[]]$addressInInt32 = @()
    for ($i = 0;$i -lt $addressInBin.length;$i++) 
    {
        $partAddressInBin += $addressInBin[$i] 
        if(($i+1)%8 -eq 0)
        {
            $partAddressInBin = $partAddressInBin -join ""
            $addressInInt32 += [Convert]::ToInt32($partAddressInBin -join "",2)
            $partAddressInBin = ""
        }
    }
    $addressInInt32 = $addressInInt32 -join "."
    return $addressInInt32
}

function Sweep
{
    $1a,$1b,$1c,$1d=$ip1.split('.')
    $2a,$2b,$2c,$2d=$ip2.split('.')
    
    $1a= [int]$1a    
    $1b= [int]$1b
    $1c= [int]$1c
    $1d= [int]$1d
    $2a= [int]$2a
    $2b= [int]$2b
    $2c= [int]$2c
    $2d= [int]$2d
    
    for ($i = $1a; $i -le $2a; $i++) 
    {
        for ($x = $1b; $x -le $2b; $x++) 
        {
            for ($i2 = $1c; $i2 -le $2c; $i2++) 
            {
                for ($x2 = $1d; $x2 -le $2d; $x2++) 
                {
                    $var=Test-NetConnection -ComputerName $i'.'$x'.'$i2'.'$x2 -Port $port -InformationLevel Quiet -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
                    if($var -eq 'True')
                    {
                        Write-Host $i'.'$x'.'$i2'.'$x2
                    }
                }
            }
        }
    }
}
function Main
{
    Write-Host("Services: SMB, FTP, SSH")
    $service=Read-Host("Enter one of the services above:")
    $service=$service.ToLower()
    $range=Read-Host("Enter an IP range: ")
    if ($range -like '*-*') 
    {
        $ip1,$ip2=$range.split('-')
        $ip1 = $ip1 -replace ' ',''
        $ip2 = $ip2 -replace ' ',''
        
    }
    else
    {
        $ip2=Get-Broadcast($range)
        $ip1,$ip1b=$range.Split('/')
        
    }
    if ($service -like "ssh") 
    {
        $port='22'
        Sweep
    }
    elseif ($service -like "ftp") 
    {
        $port='21'
        Sweep
    }
    elseif ($service -like "smb") 
    {
        $port='445'
        Sweep
    }
    else
    {
        exit 
    }
}

Main
