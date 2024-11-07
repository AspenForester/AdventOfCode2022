$LowerPriorityHash = @{
    a = 1
    b = 2
    c = 3
    d = 4
    e = 5
    f = 6
    g = 7
    h = 8
    i = 9
    j = 10
    k = 11
    l = 12
    m = 13
    n = 14
    o = 15
    p = 16
    q = 17
    r = 18
    s = 19
    t = 20
    u = 21
    v = 22
    w = 23
    x = 24
    y = 25
    z = 26
}
$UpperPriorityHash = @{
    A = 27
    B = 28
    C = 29
    D = 30
    E = 31
    F = 32
    G = 33
    H = 34
    I = 35
    J = 36
    K = 37
    L = 38
    M = 39
    N = 40
    O = 41
    P = 42
    Q = 43
    R = 44
    S = 45
    T = 46
    U = 47
    V = 48
    W = 49
    X = 50
    Y = 51
    Z = 52
}

$Data = Get-Content -Path .\Day3Data.txt

$priorities = foreach ($rucksack in $Data)
{
    $pocket1 = $rucksack.Substring(0,($rucksack.Length / 2)) -split '' | Where-Object { $_ -ne '' } | Select-Object -Unique
    $Pocket2 = $rucksack.Substring($rucksack.Length / 2) -split '' | Where-Object { $_ -ne '' } | Select-Object -Unique

    $CommonItem = Compare-Object -ReferenceObject $pocket1 -DifferenceObject $pocket2 -IncludeEqual -ExcludeDifferent -CaseSensitive
    Write-Verbose -Message "$rucksack - $($CommonItem.InputObject)" -verbose
    #$CommonItem

    if ($CommonItem.InputObject.ToLower() -ceq $CommonItem.InputObject)
    {
        $Priority = $LowerPriorityHash.$($CommonItem.InputObject)
    }
    else
    {
        $Priority = $UpperPriorityHash.$($CommonItem.InputObject)
    }
    [PSCustomObject]@{
        Priority = $Priority
    }
}

$priorities | measure-object -Property Priority -Sum