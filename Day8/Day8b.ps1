$data = Get-Content -Path .\Day8Data.txt
$visible = 0
$sidelength = $data[0].Length

$Perimeter = (($sidelength - 1) * 4)
$HighVisScore = 0

# From https://stackoverflow.com/questions/50532196/powershell-adding-items-from-text-file-to-2-dimensional-array
$grid = $data | ForEach-Object  { , $_ }

for ($x = 1; $x -lt $grid.Count - 1; $x++)
{
    :Search for ($y = 1; $y -lt $grid.Count - 1; $y++)
    {
        $isVisible = $false
        Clear-Variable NScore, SScore, EScore, WScore, VisScore -ErrorAction SilentlyContinue
        # Test all North neighbors
        for ($i = $x - 1; $i -ge 0; $i--)
        {
            if (($grid[$i][$y]) -lt ($grid[$x][$y]))
            {
                $isVisible = $true
                $NScore++
            }
            else
            {
                $isVisible = $false
                $NScore++
                break
                #Write-Verbose -Message "Looking North, [$($grid[$i][$y])] at [$i ,$y] is taller than [$($grid[$x][$y])]" -Verbose
            }
        }

        # Test all South neighbors
        for ($i = $x + 1; $i -lt $grid.Count; $i++)
        {
            if ([int]($grid[$i][$y]) -lt [int]($grid[$x][$y]))
            {
                $isVisible = $true
                $SScore++
            }
            else
            {
                $isVisible = $false
                $SScore++
                break
                #Write-Verbose -Message "Looking South, [$($grid[$i][$y])] at [$i ,$y] is taller than [$($grid[$x][$y])]" -Verbose
            }
        }
        
        # Test all West neighbors
        for ($i = $y - 1; $i -ge 0; $i--)
        {
            if ([int]($grid[$x][$i]) -lt [int]($grid[$x][$y]))
            {
                $isVisible = $true
                $WScore++
            }
            else
            {
                $isVisible = $false
                $WScore++
                break
                #Write-Verbose -Message "Looking West, [$($grid[$x][$i])] at [$x ,$i] is taller than [$($grid[$x][$y])]" -Verbose
            }
        }
      
        # Test all East neighbors
        for ($i = $y + 1; $i -lt $grid.Count; $i++)
        {
            if ([int]($grid[$x][$i]) -lt [int]($grid[$x][$y]))
            {
                $isVisible = $true
                $EScore++
            }
            else
            {
                $isVisible = $false
                $EScore++
                break
                #Write-Verbose -Message "Looking East, [$($grid[$x][$i])] at [$x ,$i] is taller than [$($grid[$x][$y])]" -Verbose            }
            }
        }
        $VisScore = $NScore * $SScore * $WScore * $EScore
        if ($VisScore -gt $HighVisScore)
        {
            $HighVisScore = $VisScore
        }

    }
}

$HighVisScore
# 200928 is too low
# 5764801 is too high