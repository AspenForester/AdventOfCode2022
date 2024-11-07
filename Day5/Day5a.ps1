Function Peek ([System.Collections.Stack]$stack)
{
    $startingErrorActionPreference = $ErrorActionPreference
    $errorActionPreference = "Stop"
    try
    {
        $stack.Peek()
    }
    Catch
    {
        " "
    }

    $ErrorActionPreference = $startingErrorActionPreference
}


[System.Collections.Stack]$1 = @()
[System.Collections.Stack]$2 = @()
[System.Collections.Stack]$3 = @()
[System.Collections.Stack]$4 = @()
[System.Collections.Stack]$5 = @()
[System.Collections.Stack]$6 = @()
[System.Collections.Stack]$7 = @()
[System.Collections.Stack]$8 = @()
[System.Collections.Stack]$9 = @()

$1.Push('H'); $1.Push('R'); $1.Push('B'); $1.Push('D'); $1.Push('Z'); $1.Push('F'); $1.Push('L'); $1.Push('S')
$2.Push('T'); $2.Push('B'); $2.Push('M'); $2.Push('Z'); $2.Push('R')
$3.Push('Z'); $3.Push('L'); $3.Push('C'); $3.Push('H'); $3.Push('N'); $3.Push('S')
$4.Push('S'); $4.Push('C'); $4.Push('F'); $4.Push('J')
$5.Push('P'); $5.Push('G'); $5.Push('H'); $5.Push('W'); $5.Push('R'); $5.Push('Z'); $5.Push('B')
$6.Push('V'); $6.Push('J'); $6.Push('Z'); $6.Push('G'); $6.Push('D'); $6.Push('N'); $6.Push('M'); $6.Push('T')
$7.Push('G'); $7.Push('L'); $7.Push('N'); $7.Push('W'); $7.Push('F'); $7.Push('S'); $7.Push('P'); $7.Push('Q')
$8.Push('M'); $8.Push('Z'); $8.Push('R')
$9.Push('M'); $9.Push('C'); $9.Push('L'); $9.Push('G'); $9.Push('V'); $9.Push('R'); $9.Push('T')

$data = Get-Content -Path .\Day5data.txt 
<# 
$1.Push('Z');$1.Push('N')
$2.Push('M');$2.Push('C');$2.Push('D')
$3.Push('P')

$data = Get-Content -Path .\Day5Sample.txt
 #>
#$ErrorActionPreference = "Stop"

$regex = "move (?'Quantity'\d+) from (?'Source'\d) to (?'Destination'\d)"

foreach ($line in $data)
{
    if ($line -match $regex)
    {
        $quantity = $matches.Quantity
        $source = $matches.Source
        $destination = $matches.Destination

        $sourceStack = Get-Variable $source -ValueOnly
        $destinationStack = Get-Variable $destination -ValueOnly

        for ($i = 0; $i -lt $quantity; $i++)
        {
            try
            {
                #Write-Verbose "Pushing $(Peek $sourceStack) to $destination" -Verbose
                $destinationStack.Push($sourceStack.Pop())
            }
            Catch
            {
                Throw "Error on move $line"
            }
        }
        # Write-verbose -Message (((1..$StackCount) | ForEach-Object { $(Peek (Get-Variable $_ -ValueOnly)) }) -join ("")) -verbose
    }
    elseif ($line -like " 1   2*")
    {
        [int]$StackCount = [convert]::toint32(($line.ToCharArray() | Where-Object { $_ -ne " " } | Select-Object -Last 1), 10)
    }
}

((1..$StackCount) | ForEach-Object { $(Peek (Get-Variable $_ -ValueOnly)) }) -join ("")

