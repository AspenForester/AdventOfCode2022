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
            # Rock
            $points = 1
            switch ($op)
            {
                "A" { $result = 3 } # Rock = Rock
                "B" { $result = 0 } # Rock < Paper
                "C" { $result = 6 } # Rock > Scissors
            }
        }
        "Y" {
            # Paper
            $points = 2
            switch ($op)
            {
                "A" { $result = 6 } # Paper > Rock
                "B" { $result = 3 } # Paper = Paper
                "C" { $result = 0 } # Paper < Scissors
            }
        }
        "Z" {
            # Scissors
            $points = 3
            switch ($op)
            {
                "A" { $result = 0 } # Scissors < Rock
                "B" { $result = 6 } # Scissors > Paper
                "C" { $result = 3 } # Scissors = Scissors
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