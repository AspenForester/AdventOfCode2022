# Never got this to quite work right

$data = get-content .\Day9Sample.txt


$Info = [PSCustomObject]@{
    HeadInitialX = 0
    HeadInitialY = 0
    HeadX = 0 # Left Right
    HeadY = 0 # Up Down
    TailX = 0
    TailY = 0
    LocationsVisited = @() #  A collection of "X Y" strings - Can be filtered with Select-object -unique
}



foreach ($line in $data) 
{
    $Direction, [int]$Distance = $line -split ' '

    Switch ($Direction){
        'R' {
            $info.headx++
            $info.LocationsVisited += "$($info.TailX) $($info.TailY)"
            While (($Distance -1) -gt 0) {
                if ($info.headx -eq $info.TailX -and $info.HeadY -eq $info.TailY) # head on top of tail
                {
                    $info.HeadX++
                }
                elseif ($info.TailX -eq $info.headx + 1) # Tail is "ahead" of the head regardless of Y
                {
                    $info.HeadX++
                }
                elseif ($info.TailY -ne $info.HeadY -and $info.TailX -eq $info.HeadX - 1) # Tail needs to move diagonally to catch up
                {
                    $info.HeadX++
                    $info.TailX++
                    $info.TailY = $info.HeadY
                }
                else {
                    $info.HeadX++
                    $info.TailX++
                }
            $info.LocationsVisited += "$($info.TailX) $($info.TailY)"
            $Distance--
            }
        }
        'L' {
            $info.HeadX--
            $info.LocationsVisited += "$($info.TailX) $($info.TailY)"
            While (($Distance -1) -gt 0) {
                if ($info.headx -eq $info.TailX -and $info.HeadY -eq $info.TailY) {
                    $info.HeadX--
                }
                elseif ($info.TailX -eq $info.headx - 1) # Tail is "ahead" of the head
                {
                    $info.HeadX--
                }
                elseif ($info.TailY -ne $info.HeadY -and $info.TailX -eq $info.HeadX + 1) {
                    $info.HeadX--
                    $info.TailX--
                    $info.TailY = $info.HeadY
                }
                else {
                    $info.HeadX--
                    $info.TailX--
                }
            $info.LocationsVisited += "$($info.TailX) $($info.TailY)"
            $Distance--
            }
        }
        'U' {
            $info.HeadY++
            $info.LocationsVisited += "$($info.TailX) $($info.TailY)"
            While (($Distance -1) -gt 0) {
                if ($info.headx -eq $info.TailX -and $info.HeadY -eq $info.TailY) {
                    $info.HeadY++
                }
                elseif ($info.TailY -eq $info.headY +1) # Tail is "ahead" of the head
                {
                    $info.HeadY++
                }
                elseif ($info.TailX -ne $info.HeadX -and $info.TailY -eq $info.HeadY - 1) {
                    $info.HeadY++
                    $info.TailY++
                    $info.TailX = $info.HeadX
                }
                else {
                    $info.HeadY++
                    $info.TailY++
                }
            $info.LocationsVisited += "$($info.TailX) $($info.TailY)"
            $Distance--
            }
        }
        'D' {
            $info.HeadY--
            $info.LocationsVisited += "$($info.TailX) $($info.TailY)"
            While (($Distance -1) -gt 0) {
                if ($info.headx -eq $info.TailX -and $info.HeadY -eq $info.TailY) {
                    $info.HeadY--
                }
                elseif ($info.TailY -eq $info.headY -1) # Tail is "ahead" of the head
                {
                    $info.HeadY--
                }
                elseif ($info.TailX -ne $info.HeadX -and $info.TailY -eq $info.HeadY + 1) {
                    $info.HeadY--
                    $info.TailY--
                    $info.TailX = $info.HeadX
                }
                else {
                    $info.HeadY--
                    $info.TailY--
                }
            $info.LocationsVisited += "$($info.TailX) $($info.TailY)"
            $Distance--
            }
        }
    }
}
$info.locationsvisited | select-object -unique | measure-object | select-object -expand count