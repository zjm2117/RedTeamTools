Install-Module ps2exe
$in = Read-Host "Name of .ps1 file"
$out = Read-Host "Name of output file"
invoke-ps2exe $in $out