$data = Get-Content -path .\Day4data.txt

foreach ($line in $data)
{
    $elf1,$elf2 = $line -split ','

    # casting to int is important!
    [int]$elf1Start,[int]$elf1End = $elf1 -split '-'
    [int]$elf2Start,[int]$elf2End = $elf2 -split '-'

    if (compare-object -ReferenceObject ($elf1Start..$elf1End) -DifferenceObject ($elf2Start..$elf2End) -IncludeEqual -ExcludeDifferent ) {
        Write-Host "Overlap on line $line"
        $count++
    }    
}
$count
Clear-Variable count

