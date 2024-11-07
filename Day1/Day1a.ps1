$data = Get-content -path .\Puzzle1Data.txt

$elfNum = 1

$elfcalories = foreach ($line in $data)
{
    if ($line -eq "")
    {
        [PSCustomObject]@{
            Elf = $elfNum
            Calories = $calories
        }
        $calories = 0
        $elfNum++
    }
    else {
        $calories += [int32]$line
    }
}

$elfcalories | Sort-Object Calories -Descending | Select-Object -First 1

