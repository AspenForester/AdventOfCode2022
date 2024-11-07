$data = Get-content -path .\Puzzle1Data.txt

$elfNum = 1

$data | Foreach-object -Begin {$elfcalories = @()} -Process{
    $line = $_
    if ($line -eq "")
    {
        $elfcalories = $elfcalories +  [PSCustomObject]@{
            Elf = $elfNum
            Calories = $calories
        }
        $calories = 0
        $elfNum++
    }
    else {
        $calories += [int32]$line
    }

} -End {
    $elfcalories = $elfcalories + [PSCustomObject]@{
        Elf = $elfNum
        Calories = $calories
    }
    $calories = $elfNum = 0
}

#$elfcalories | Sort-Object Calories -Descending
$elfcalories | Sort-Object Calories -Descending | Select-Object -First 3 | Measure-Object -Sum Calories

