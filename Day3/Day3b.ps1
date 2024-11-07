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
# Can I take a batch of three, concatenate them, Group the letters, and find the letter that
# appears three times?
$priorities = for ($i = 0; $i -lt $data.Count; $i+=3) {

$ruck0 = $data[$i].ToCharArray() | Select-Object -Unique
$ruck1 = $data[$i + 1].ToCharArray() | Select-Object -Unique
$ruck2 = $data[$i + 2].ToCharArray() | Select-Object -Unique

$commonItem = $ruck0 + $ruck1 + $ruck2 | Where-Object { $_ -ne '' } | Group-Object -CaseSensitive | Where-Object Count -eq 3 | Select-object -expand Name

if ($CommonItem.ToLower() -ceq $CommonItem)
    {
        $Priority = $LowerPriorityHash.$($CommonItem)
    }
    else
    {
        $Priority = $UpperPriorityHash.$($CommonItem)
    }
    [PSCustomObject]@{
        Priority = $Priority
    }
}

$priorities | measure-object -Property Priority -Sum