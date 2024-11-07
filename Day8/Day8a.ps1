$data = Get-Content -Path .\Day8Data.txt
$visible = 0
$sidelength = $data[0].Length

$Perimeter = (($sidelength - 1) * 4)

# From https://stackoverflow.com/questions/50532196/powershell-adding-items-from-text-file-to-2-dimensional-array
$grid = $data | ForEach-Object  { , $_ }

for ($x = 1; $x -lt $grid.Count - 1; $x++)
{
    :Search for ($y = 1; $y -lt $grid.Count - 1; $y++)
    {
        $isVisible = $false
        # Test all North neighbors
        for ($i = $x - 1; $i -ge 0; $i--)
        {
            if (($grid[$i][$y]) -lt ($grid[$x][$y]))
            {
                $isVisible = $true
            }
            else
            {
                $isVisible = $false
                break
                #Write-Verbose -Message "Looking North, [$($grid[$i][$y])] at [$i ,$y] is taller than [$($grid[$x][$y])]" -Verbose
            }
        }
        if ($isVisible)
        {
            Write-Verbose "[$($grid[$x][$y])] at [$x ,$y] is visible" -verbose
            $visible++
            continue search
        }
        # Test all South neighbors
        for ($i = $x + 1; $i -lt $grid.Count; $i++)
        {
            if ([int]($grid[$i][$y]) -lt [int]($grid[$x][$y]))
            {
                $isVisible = $true
            }
            else
            {
                $isVisible = $false
                break
                #Write-Verbose -Message "Looking South, [$($grid[$i][$y])] at [$i ,$y] is taller than [$($grid[$x][$y])]" -Verbose
            }
        }
        if ($isVisible)
        {
            Write-Verbose "[$($grid[$x][$y])] at [$x ,$y] is visible" -verbose
            $visible++
            continue search
        }
        # Test all West neighbors
        for ($i = $y - 1; $i -ge 0; $i--)
        {
            if ([int]($grid[$x][$i]) -lt [int]($grid[$x][$y]))
            {
                $isVisible = $true
            }
            else
            {
                $isVisible = $false
                break
                #Write-Verbose -Message "Looking West, [$($grid[$x][$i])] at [$x ,$i] is taller than [$($grid[$x][$y])]" -Verbose
            }
        }
        if ($isVisible)
        {
            Write-Verbose "[$($grid[$x][$y])] at [$x ,$y] is visible" -verbose
            $visible++
            continue search
        }
        # Test all East neighbors
        for ($i = $y + 1; $i -lt $grid.Count; $i++)
        {
            if ([int]($grid[$x][$i]) -lt [int]($grid[$x][$y]))
            {
                $isVisible = $true
            }
            else
            {
                $isVisible = $false
                break
                #Write-Verbose -Message "Looking East, [$($grid[$x][$i])] at [$x ,$i] is taller than [$($grid[$x][$y])]" -Verbose            }
            }
        }
        #other comparisons
        if ($isVisible)
        {
            Write-Verbose "[$($grid[$x][$y])] at [$x ,$y] is visible" -verbose
            $visible++
        }
    }
}

$visible + $Perimeter