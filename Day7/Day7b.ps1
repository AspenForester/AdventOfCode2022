# Day 7 Advent of Code 2022

$data = Get-Content -Path .\Day7data.txt
$fs = @{}

# helper that returns the parent path of a given folder
function UpDir {
    param([string]$dir)
    $dir = $dir.Substring(0,$dir.LastIndexOf('/'))
    return ($dir -eq '') ? '/' : $dir
}


Switch -regex ($data) 
{
    # change directory
    '\$ cd (\S+)' {
        if ($matches[1] -eq '/') {
            $curDir = '/'
        }
        elseif ($matches[1] -eq '..') {
            $curDir = UpDir $curDir
        }
        else {
            $curDir += ($curDir -eq '/') ? $matches[1] : "/$($matches[1])"
        }

        # add the current dir to the hashtable if it doesn't exist
        if ($null -eq $fs[$curDir]) {
            $fs[$curDir] = 0
        }
    }

    # file
    '(\d+) (\S+)' {

        # add the file size to the current directory
        $fs[$curDir] += [int]$matches[1]

        # add it to all of the parent directories as well
        $tempDir = $curDir
        while ($tempDir -ne '/') {
            $tempDir = UpDir $tempDir
            $fs[$tempDir] += [int]$matches[1]
        }
    }
}
<# 
$uniqueDirs = $record.FullPath | Select-object -Unique

$Sums = foreach ($dir in $uniqueDirs)
{
    $measurement = $record | Where-Object { $_.FullPath -eq $dir } | Measure-Object -sum Length
    [PSCustomObject]@{
        Dir = $Dir
        Size = $measurement.Sum
    }
}

$Sums | where Size -le 100000 | Measure-Object -Sum -Property Size 
 #>

 $fs.GetEnumerator() | Where-Object Value -le 100000 | Measure-Object -Sum -Property Value
# 1456743 too low
# 1664419 too low
# 2112407 too high

$usedspace = $fs['/']
$needed = 30000000 - (70000000 - $usedspace)
$fs.GetEnumerator() | where value -ge $needed | Sort-Object value | select -first 1