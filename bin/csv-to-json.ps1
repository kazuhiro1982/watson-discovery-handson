[CmdletBinding()]
param (
    [Parameter()]
    [string]
    $FileName
)

if (!(Test-Path .\work)) {
    New-Item .\work -ItemType Directory
}

$Enc = [Text.Encoding]::GetEncoding("Shift_JIS")
$Reader = New-Object System.IO.StreamReader($FileName, $Enc)
$Header = $Reader.ReadLine()
$Headers = $Header.Split(',')
for ($i = 0; $i -lt $Headers.Count; $i++) {
    $Headers[$i] = $Headers[$i].Substring(1, $Headers[$i].Length - 2)
}
while ( $Reader.EndOfStream -ne $true ) {
    $Hash = @{}
    $Line = $Reader.ReadLine()
    $Rows = $Line.Split(',')
    for ($i = 0; $i -lt $Headers.Count; $i++) {
        if ($Rows[$i].Length -gt 1) {
            $Val = $Rows[$i].Substring(1, $Rows[$i].Length - 2).Replace("\\", "\")
            if ($Val.Length -gt 0) {
                $Hash[$Headers[$i]] = $Val
            }
        }
    }
    $OutFileName = ".\work\" + $Hash["ÉLÅ["] + ".json"
    $Hash | ConvertTo-Json | Out-File $OutFileName -Encoding UTF8
}
$reader.Dispose();