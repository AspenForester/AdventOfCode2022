$data = get-content -path .\Day2Data.txt
Write-Verbose -Message "Lines = $($data.Count)" -Verbose
$rounds = 0
$tally = 0
# Rock Paper Scissors
foreach ($match in $data)
{
    $op,$self = $match.Split(" ")
    switch ($self)
    {
        "X" {
            # Lose
            $points = 0
            switch ($op)
            {
                "A" { $result = 3 } # Rock > Scissors
                "B" { $result = 1 } # Paper > Rock
                "C" { $result = 2 } # Scissors > Paper
            }
        }
        "Y" {
            # Draw
            $points = 3
            switch ($op)
            {
                "A" { $result = 1 } # Rock = Rock
                "B" { $result = 2 } # Paper = Paper
                "C" { $result = 3 } # Paper < Scissors
            }
        }
        "Z" {
            # Win
            $points = 6
            switch ($op)
            {
                "A" { $result = 2 } # Paper > Rock
                "B" { $result = 3 } # Scissors > Paper
                "C" { $result = 1 } # Rock > Scissors
            }
        }
    }
    Write-Verbose -Message "Points: $points, Result: $result" -Verbose
    $rounds++
    $score = $points + $result
    $tally += $score
}
Write-verbose -Message "Rounds: $rounds" -Verbose
$tally
# Not 12865