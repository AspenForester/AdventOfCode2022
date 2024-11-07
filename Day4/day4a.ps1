$data = Get-Content -path .\Day4data.txt

foreach ($line in $data)
{
    $elf1,$elf2 = $line -split ','

    # casting to int is important!
    [int]$elf1Start,[int]$elf1End = $elf1 -split '-'
    [int]$elf2Start,[int]$elf2End = $elf2 -split '-'

    if ((($elf1Start -ge $elf2Start) -and ($elf1End -le $elf2End)) -or 
        (($elf2Start -ge $elf1Start) -and ($elf2End -le $elf1End)) ) #-and (($elf1End -ge $elf2Start) -or ($elf2End -ge $elf1Start)))
    {
        Write-Host "Overlap on line $line"
        $count++
    }
    
}
$count
Clear-Variable count

# 366 is too low
# 550 is too high